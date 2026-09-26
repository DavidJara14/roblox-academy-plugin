-- DemonAttack: combate cuerpo a cuerpo — Módulo 2, Lección 8
--
-- Ubicación: dentro del Model "Demon" (script.Parent).
--
-- CÓMO USARLO:
-- 1. El Model "Demon" debe tener Parts RightHand/LeftHand (esqueleto
--    R15) y una espada (ClassicSword) como hijo directo.
-- 2. Crea un IntValue "AttackSpeed" dentro de la Folder "NPC" (donde
--    generador-de-enemigos.lua clona a los Demon) — el script lo busca
--    como script.Parent.Parent.AttackSpeed, y en tiempo de ejecución el
--    padre del Demon clonado es esa Folder, no el Model "Spawner".
-- 3. Selecciona el Model "Demon" e inserta este script.
--
-- Qué hace: al tocar al jugador con las manos o la espada, le quita
-- salud (0.1 por mano, 1 por espada), con una pequeña pausa entre
-- golpes según AttackSpeed.
--
-- Corrección respecto al material original: la diapositiva conectaba el
-- daño de espada al brazo izquierdo por error de copiar/pegar, y usaba
-- "findFirstChild" (minúscula) en vez de "FindFirstChild" — ambos
-- corregidos aquí.

local rightHand = script.Parent:FindFirstChild("RightHand")
local leftHand = script.Parent:FindFirstChild("LeftHand")
local sword = script.Parent:FindFirstChild("ClassicSword")
local attackSpeed = script.Parent.Parent.AttackSpeed

local function damageWithHand(hit)
	local humanoid = hit.Parent and hit.Parent:FindFirstChild("Humanoid")
	if humanoid then
		humanoid.Health -= 0.1
		task.wait(attackSpeed.Value)
	end
end

local function damageWithSword(hit)
	local humanoid = hit.Parent and hit.Parent:FindFirstChild("Humanoid")
	if humanoid then
		humanoid.Health -= 1
		task.wait(attackSpeed.Value)
	end
end

rightHand.Touched:Connect(damageWithHand)
leftHand.Touched:Connect(damageWithHand)
sword.Touched:Connect(damageWithSword)
