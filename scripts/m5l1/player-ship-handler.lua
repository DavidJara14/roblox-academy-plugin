-- PlayerShipHandler: propiedad de red + tabla de clasificación — Módulo 5, Lección 1
--
-- Ubicación: Script en ServerScriptService.
--
-- CÓMO USARLO:
-- 1. Requiere el personaje custom de nave de M5L1 (Part "HumanoidRootPart").
-- 2. Inserta este script en ServerScriptService.
--
-- Qué hace: por cada jugador, da la propiedad de red ("network
-- ownership") de su nave para que el movimiento (VectorForce) responda
-- con la menor latencia posible, y crea una tabla de clasificación
-- (leaderstats) con Score (enemigos derrotados) y Loose (veces que
-- chocó con un enemigo).
--
-- Nota: esta versión ya incluye la tabla de clasificación que M5L3
-- añade sobre la base de M5L1 — sirve desde M5L1 en adelante, no hace
-- falta insertar una versión "sin tabla de clasificación" primero.
-- Requiere "TouchScript" (M5L2/M5L3) para que Score/Loose cambien.

local function onCharacterAdded(character)
	local rootPart = character:WaitForChild("HumanoidRootPart")
	while not rootPart:IsDescendantOf(workspace) do
		task.wait()
	end
	rootPart:SetNetworkOwner(game.Players:GetPlayerFromCharacter(character))
end

local function onPlayerAdded(player)
	player.CharacterAdded:Connect(onCharacterAdded)

	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"

	local score = Instance.new("IntValue")
	score.Name = "Score"
	score.Value = 0
	score.Parent = leaderstats

	local loose = Instance.new("IntValue")
	loose.Name = "Loose"
	loose.Value = 0
	loose.Parent = leaderstats

	leaderstats.Parent = player
end

game.Players.PlayerAdded:Connect(onPlayerAdded)
