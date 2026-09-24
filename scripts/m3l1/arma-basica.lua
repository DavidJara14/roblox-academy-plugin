-- Arma básica: disparar un proyectil físico — Módulo 3, Lección 1
--
-- Ubicación: LocalScript dentro de la Tool "Weapon" (script.Parent).
--
-- CÓMO USARLO:
-- 1. Construye la Tool "Weapon": Handle + una Part "Bomb" (unidas con
--    WeldConstraint, CanCollide=false), movida a StarterPack.
-- 2. Selecciona la Tool "Weapon" e inserta este script.
-- 3. Presiona Play, equipa el arma y haz clic para disparar.
--
-- Qué hace: al hacer clic, clona la Part "Bomb", le da un impulso
-- físico (BodyThrust) que la dispara hacia adelante, le prende fuego,
-- y la autodestruye tras 1 segundo. Tiene un cooldown simple para no
-- disparar dos veces seguidas sin esperar.
--
-- Nota: es un arma de un solo jugador — el proyectil solo lo ve quien
-- dispara. No hace daño a nada todavía (eso lo añade "Arma: dañar a un
-- objetivo" de M3L2). Para daño en red real (multijugador, con
-- leaderboard de bajas) usa "Pistola (disparo en red)" de M3L3, que
-- reemplaza por completo esta arquitectura.

local gun = script.Parent
local bomb = gun:FindFirstChild("Bomb")
local reload = false

local function disparar()
	if reload then
		return
	end
	reload = true

	local bullet = bomb:Clone()
	bomb.CanCollide = false
	bomb.Transparency = 1

	bullet.Position = bomb.Position
	bullet.CanCollide = true
	bullet.Name = "BombFired"

	local weldConstraint = bullet:FindFirstChild("WeldConstraint")
	if weldConstraint then
		weldConstraint:Destroy()
	end

	local thrust = Instance.new("BodyThrust")
	local randCoeff = math.random(100, 300)
	thrust.Force = Vector3.new(randCoeff, 197, 0)
	thrust.Parent = bullet

	local fire = Instance.new("Fire")
	fire.Parent = bullet

	bullet.BrickColor = BrickColor.Random()
	bullet.Parent = gun

	game.Debris:AddItem(bullet, 1)

	task.wait(1)
	bomb.CanCollide = true
	bomb.Transparency = 0
	reload = false
end

gun.Activated:Connect(disparar)
