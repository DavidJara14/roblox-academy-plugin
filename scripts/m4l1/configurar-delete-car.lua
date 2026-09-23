-- Configurar botón DeleteCar — Módulo 4, Lección 1
--
-- Ubicación: LocalScript dentro del botón "DeleteCar" (script.Parent).
--
-- CÓMO USARLO:
-- 1. Requiere "CarSpawner" (ServerScriptService) y los RemoteEvent
--    SpawnCar/DeleteCar ya insertados.
-- 2. Haz invisible el botón "DeleteCar" (Visible = false) — este
--    script lo muestra solo cuando el jugador tiene un coche activo.
-- 3. Selecciona el botón "DeleteCar" e inserta este script.
--
-- Qué hace: muestra el botón cuando aparece el coche del jugador en
-- Workspace; al pulsarlo, baja al jugador del asiento (si estaba
-- sentado en el coche) y pide al servidor que elimine su coche activo.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DeleteCarEvent = ReplicatedStorage:WaitForChild("DeleteCar")
local player = game.Players.LocalPlayer

local function nombreCocheDe()
	return player.Name .. "sCar"
end

workspace.ChildAdded:Connect(function(added)
	if added.Name == nombreCocheDe() then
		script.Parent.Visible = true
	end
end)

script.Parent.MouseButton1Down:Connect(function()
	local car = workspace:FindFirstChild(nombreCocheDe())
	if not car then
		return
	end

	script.Parent.Visible = false

	local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
	if humanoid and humanoid.SeatPart and humanoid.SeatPart:IsA("VehicleSeat") then
		humanoid.Sit = false
	end

	task.wait()
	DeleteCarEvent:FireServer(car)
end)
