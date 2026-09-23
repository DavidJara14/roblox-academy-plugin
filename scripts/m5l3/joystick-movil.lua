-- Joystick de movimiento (móvil) — Módulo 5, Lección 3
--
-- Ubicación: LocalScript dentro del ImageButton que actúa como
-- joystick (script.Parent), en un ScreenGui.
--
-- CÓMO USARLO:
-- 1. Crea un ScreenGui con un ImageButton (el "stick" visual).
-- 2. Requiere el VectorForce de la nave (ver ControlScript de M5L1).
-- 3. Selecciona el ImageButton e inserta este script.
-- 4. Prueba con el emulador de dispositivo táctil de Roblox Studio.
--
-- Qué hace: al tocar la pantalla cerca del joystick, lo mueve a la
-- posición del toque; mientras se arrastra el dedo, calcula una
-- dirección relativa al centro del joystick y mueve/orienta la nave
-- en esa dirección (mismo VectorForce que usa ControlScript).

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local stick = script.Parent
local PLAYER_SPEED = 70000
local forwardForceVector = Vector3.new(0, 0, -PLAYER_SPEED)

local stickCenterX = stick.AbsolutePosition.X + stick.AbsoluteSize.X / 2
local stickCenterY = stick.AbsolutePosition.Y + stick.AbsoluteSize.Y / 2

UserInputService.InputBegan:Connect(function(input)
	if input.UserInputType ~= Enum.UserInputType.Touch or not player.Character then
		return
	end
	if input.Position.X < stickCenterX * 3 and input.Position.Y > stickCenterY * 0.5 then
		stick.Position = UDim2.new(0, input.Position.X - stick.AbsoluteSize.X / 2, 0, input.Position.Y - stick.AbsoluteSize.Y / 2)
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input.UserInputType ~= Enum.UserInputType.Touch or not player.Character then
		return
	end
	if input.Position.X >= stick.Parent.AbsoluteSize.X * 0.4 or input.Position.Y <= stick.Parent.AbsoluteSize.Y * 0.5 then
		return
	end

	local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
	if not rootPart then
		return
	end

	local currentCenterX = stick.AbsolutePosition.X + stick.AbsoluteSize.X / 2
	local currentCenterY = stick.AbsolutePosition.Y + stick.AbsoluteSize.Y / 2
	local deltaX = input.Position.X - currentCenterX
	local deltaY = input.Position.Y - currentCenterY

	local newLocation = Vector3.new(deltaX, rootPart.Position.Y, deltaY)
	rootPart.CFrame = CFrame.new(rootPart.Position, rootPart.Position + newLocation)
	rootPart.CFrame *= CFrame.Angles(0, math.rad(90), 0)
	rootPart.VectorForce.Force = forwardForceVector
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType ~= Enum.UserInputType.Touch or not player.Character then
		return
	end
	local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
	if rootPart then
		rootPart.VectorForce.Force = Vector3.new(0, 0, 0)
	end
end)
