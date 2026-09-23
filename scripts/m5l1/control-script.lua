-- ControlScript: mover y apuntar la nave (teclado + mouse) — Módulo 5, Lección 1
--
-- Ubicación: LocalScript en StarterPlayer > StarterPlayerScripts.
--
-- CÓMO USARLO:
-- 1. Añade un VectorForce (nombre por defecto "VectorForce") y un
--    Attachment a la Part "HumanoidRootPart" de tu nave (motor de
--    movimiento).
-- 2. Selecciona StarterPlayerScripts e inserta este script.
-- 3. Presiona Play: W (o clic izquierdo sostenido) avanza, el mouse
--    apunta la nave.
--
-- Qué hace: aplica una fuerza hacia adelante al VectorForce de la nave
-- mientras se mantiene presionada la tecla W o el clic izquierdo, y
-- gira la nave para que siempre apunte hacia donde está el mouse.

local ContextActionService = game:GetService("ContextActionService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local mouse = player:GetMouse()
local PLAYER_SPEED = 70000
local FORWARD_KEY = Enum.KeyCode.W

local forwardForceVector = Vector3.new(0, 0, -PLAYER_SPEED)

local function onMove(actionName, inputState)
	if not player.Character then
		return
	end
	local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
	if not rootPart then
		return
	end

	if inputState == Enum.UserInputState.Begin then
		rootPart.VectorForce.Force = forwardForceVector
	elseif inputState == Enum.UserInputState.End then
		rootPart.VectorForce.Force = Vector3.new(0, 0, 0)
	end
end

local function onAim()
	if player.Character then
		local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
		local mouseLocation = Vector3.new(mouse.Hit.X, rootPart.Position.Y, mouse.Hit.Z)
		rootPart.CFrame = CFrame.new(rootPart.Position, mouseLocation)
		rootPart.CFrame *= CFrame.Angles(0, math.rad(180), 0)
	end
end

ContextActionService:BindAction("Aim", onAim, false, Enum.UserInputType.MouseMovement)
ContextActionService:BindAction("MoveViaClick", onMove, false, Enum.UserInputType.MouseButton1)
ContextActionService:BindAction("Move", onMove, false, FORWARD_KEY)
