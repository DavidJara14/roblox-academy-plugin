-- CarSpawner: instanciar/eliminar el coche del jugador — Módulo 4, Lección 1
--
-- Ubicación: ServerScriptService.
--
-- CÓMO USARLO:
-- 1. Crea una carpeta "Cars" en ServerStorage con los coches
--    disponibles dentro, renombrados Car1, Car2, etc.
-- 2. Crea dos RemoteEvent en ReplicatedStorage: "SpawnCar" y "DeleteCar".
-- 3. Inserta este script en ServerScriptService.
--
-- Qué hace: cuando un cliente pide un coche (evento SpawnCar con el
-- nombre del coche), clona ese coche desde ServerStorage.Cars y lo
-- coloca junto al jugador, eliminando cualquier coche anterior que
-- tuviera. También elimina el coche del jugador si este se
-- desconecta o si su personaje reaparece.
--
-- Nota de seguridad: SpawnCarEvent.OnServerEvent confía en el nombre
-- de coche que manda el cliente, pero solo se usa para buscarlo dentro
-- de una carpeta controlada por el servidor (ServerStorage.Cars) — en
-- el peor caso, un nombre inventado simplemente no encuentra nada.
--
-- Nota: el original usaba ":Remove()" (obsoleto); aquí se usa
-- ":Destroy()", su equivalente actual.

local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SpawnCarEvent = ReplicatedStorage:WaitForChild("SpawnCar")
local DeleteCarEvent = ReplicatedStorage:WaitForChild("DeleteCar")

local function nombreCocheDe(player)
	return player.Name .. "sCar"
end

SpawnCarEvent.OnServerEvent:Connect(function(player, carName)
	local car = ServerStorage:FindFirstChild("Cars") and ServerStorage.Cars:FindFirstChild(carName)
	local currentCar = workspace:FindFirstChild(nombreCocheDe(player))
	if currentCar then
		currentCar:Destroy()
	end

	if car and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		local clonedCar = car:Clone()
		clonedCar.Name = nombreCocheDe(player)
		clonedCar.Parent = workspace
		local rootPart = player.Character.HumanoidRootPart
		clonedCar:MoveTo(rootPart.Position + rootPart.CFrame.LookVector * 15)
	end
end)

DeleteCarEvent.OnServerEvent:Connect(function(player, car)
	if car then
		car:Destroy()
	end
end)

game.Players.PlayerRemoving:Connect(function(player)
	local car = workspace:FindFirstChild(nombreCocheDe(player))
	if car then
		car:Destroy()
	end
end)

game.Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function()
		local car = workspace:FindFirstChild(nombreCocheDe(player))
		if car then
			car:Destroy()
		end
	end)
end)
