-- Arma: dañar a un objetivo — Módulo 3, Lección 2
--
-- Ubicación: LocalScript dentro de la Tool "Weapon" (script.Parent).
-- Es la versión de "Arma básica" (M3L1) modificada para que cada bala
-- dañe a un objetivo al impactar.
--
-- CÓMO USARLO:
-- 1. Construye la Tool "Weapon" igual que en M3L1 (Handle + Part
--    "Bomb", WeldConstraint, CanCollide=false).
-- 2. Selecciona la Tool "Weapon" e inserta este script (reemplaza a
--    "Arma básica" si ya la tenías puesta: usa el mismo nombre de
--    instancia).
-- 3. Añade un NPC al mapa y renómbralo "Target".
-- 4. Presiona Play, dispara al objetivo.
--
-- Qué hace: igual que "Arma básica", pero además detecta cuándo la
-- bala toca a un Humanoid y le hace 30 de daño directamente.
--
-- Nota: no la uses junto con "Arma básica" en la misma Tool — son dos
-- versiones alternativas del mismo script, no capas que se suman. Para
-- daño multijugador real (con leaderboard de bajas) usa "Pistola
-- (disparo en red)" de M3L3, que reemplaza esta arquitectura por
-- completo.
--
-- Corrección sobre el script original: clonaba una plantilla de daño
-- ("dmg") desde ServerStorage dentro de cada bala. Eso nunca puede
-- funcionar: al ser LocalScript, la bala que crea solo existe en la
-- copia local del jugador que dispara — ni el servidor ni ServerStorage
-- son visibles desde ahí, así que clonar algo desde ServerStorage
-- fallaba de inmediato. Ahora el daño se detecta directamente en este
-- mismo script (mismo enfoque "un solo jugador" que el resto de M3L1/
-- M3L2, sin depender de nada fuera del cliente).

local gun = script.Parent
local bomb = gun:FindFirstChild("Bomb")
local reload = false

local function onBulletTouched(hit)
	local character = hit.Parent
	local humanoid = character:FindFirstChild("Humanoid")
	if humanoid then
		humanoid:TakeDamage(30)
	end
end

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

	bullet.Touched:Connect(onBulletTouched)

	bullet.BrickColor = BrickColor.Random()
	bullet.Parent = gun

	game.Debris:AddItem(bullet, 1)

	task.wait(1)
	bomb.CanCollide = true
	bomb.Transparency = 0
	reload = false
end

gun.Activated:Connect(disparar)
