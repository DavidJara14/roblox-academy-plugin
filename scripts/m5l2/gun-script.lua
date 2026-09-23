-- GunScript: generador de enemigos — Módulo 5, Lección 2
--
-- Ubicación: Script dentro de la Part "GunEnd" (script.Parent), que
-- debe tener una Part hermana "GunStart".
--
-- CÓMO USARLO:
-- 1. Crea una plantilla "EnemyShip" dentro de una Folder "Enemies" en
--    ServerStorage.
-- 2. Crea una Folder "Enemies" (vacía) en Workspace.
-- 3. Crea dos Parts "GunStart"/"GunEnd" (el cañón), mueve "GunEnd" a
--    la Arena.
-- 4. Selecciona "GunEnd" e inserta este script.
--
-- Qué hace: cada 2 segundos, clona "EnemyShip" y lo lanza hacia
-- afuera del cañón (alejándose de "GunStart") con velocidad
-- aleatoria.

local MAX_ENEMY_SPEED = 50
local COOLDOWN = 2

local ServerStorage = game:GetService("ServerStorage")
local gun = script.Parent
local start = gun.GunStart.Position

while true do
	local enemy = ServerStorage.Enemies.EnemyShip:Clone()
	enemy.Parent = workspace.Enemies
	enemy.BrickColor = BrickColor.Random()

	local gunX, gunY, gunZ = gun.Position.X, gun.Position.Y, gun.Position.Z
	local forwardVector = Vector3.new(gunX, 0, gunZ) - Vector3.new(start.X, 0, start.Z)
	local unitVector = forwardVector / forwardVector.Magnitude

	enemy.Position = Vector3.new(
		gunX + unitVector.X * enemy.Size.X,
		gunY + enemy.Size.Y,
		gunZ + unitVector.Z * enemy.Size.Z
	)

	local randVel = MAX_ENEMY_SPEED * (math.random() + 1)
	enemy.AssemblyLinearVelocity = unitVector * randVel

	task.wait(COOLDOWN)
end
