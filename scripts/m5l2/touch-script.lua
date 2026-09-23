-- TouchScript: colisión enemigo-jugador + tabla de clasificación — Módulo 5, Lección 2
--
-- Ubicación: Script dentro de la esfera "EnemyShip" en ServerStorage
-- (script.Parent) — se clona junto con cada enemigo (ver GunScript).
--
-- CÓMO USARLO:
-- 1. Requiere "PlayerShipHandler" (crea la tabla leaderstats con
--    Score/Loose) ya insertado.
-- 2. Selecciona "EnemyShip" (dentro de ServerStorage.Enemies) e
--    inserta este script.
--
-- Qué hace: cuando un enemigo toca al jugador (su HumanoidRootPart o
-- Cannon), le suma 1 a "Loose" y reinicia "Score" a 0, lo saca del
-- juego temporalmente con una explosión visual, y lo restaura tras 3
-- segundos con velocidad y fuerza en cero.
--
-- Nota: esta versión ya incluye la actualización de la tabla de
-- clasificación que M5L3 añade sobre la base de M5L2 — sirve desde
-- M5L2 en adelante.
--
-- Nota de diseño: filtra por nombre de Part ("HumanoidRootPart"/
-- "Cannon") en vez de buscar un Humanoid, porque el personaje de esta
-- lección (la nave, ver M5L1) no tiene objeto Humanoid.

local RESPAWN_DURATION = 3
local Players = game:GetService("Players")

local function onTouched(other)
	if not (other.Name == "HumanoidRootPart" or other.Name == "Cannon") then
		return
	end

	local character = other.Parent
	local player = Players:GetPlayerFromCharacter(character)
	if not player then
		return
	end

	local looseStat = player.leaderstats:WaitForChild("Loose")
	local scoreStat = player.leaderstats:WaitForChild("Score")
	looseStat.Value += 1
	scoreStat.Value = 0

	character.Parent = game:GetService("ReplicatedStorage")
	local explosion = Instance.new("Explosion")
	explosion.Position = character:GetPrimaryPartCFrame().Position
	explosion.Parent = workspace

	task.wait(RESPAWN_DURATION)

	character.Parent = workspace
	character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
	character.HumanoidRootPart.VectorForce.Force = Vector3.new(0, 0, 0)
end

script.Parent.Touched:Connect(onTouched)
