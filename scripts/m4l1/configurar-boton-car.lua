-- Configurar botón de coche (Car1, Car2...) — Módulo 4, Lección 1
--
-- Ubicación: LocalScript dentro de cada botón de coche del menú
-- (script.Parent), cuyo nombre debe coincidir exactamente con el del
-- coche en ServerStorage.Cars (por ejemplo "Car1").
--
-- CÓMO USARLO:
-- 1. Requiere "CarSpawner" (ServerScriptService) y los RemoteEvent
--    SpawnCar/DeleteCar ya insertados.
-- 2. Selecciona el botón (dentro del Frame del menú) e inserta este
--    script. Repite para cada botón de coche (Car1, Car2, Car3...).
--
-- Qué hace: al pulsar el botón, oculta el menú y pide al servidor el
-- coche correspondiente. Si el jugador ya tenía otro coche activo, lo
-- baja del asiento (si estaba sentado), pide eliminar el anterior y
-- pide el nuevo.

local player = game.Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SpawnCarEvent = ReplicatedStorage:WaitForChild("SpawnCar")
local DeleteCarEvent = ReplicatedStorage:WaitForChild("DeleteCar")

local carName = script.Parent.Name
local menuFrame = script.Parent.Parent

script.Parent.MouseButton1Down:Connect(function()
	menuFrame.Visible = false

	local currentCar = workspace:FindFirstChild(player.Name .. "sCar")
	if not currentCar then
		SpawnCarEvent:FireServer(carName)
		return
	end

	local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
	if humanoid and humanoid.SeatPart and humanoid.SeatPart:IsA("VehicleSeat") then
		humanoid.Sit = false
	end

	task.wait()
	DeleteCarEvent:FireServer(currentCar)
	SpawnCarEvent:FireServer(carName)
end)
