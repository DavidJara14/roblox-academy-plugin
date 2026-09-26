-- DemonAttack con bate: combate cuerpo a cuerpo con arma animada — Módulo 2, Lección 8
--
-- Ubicación: dentro del Model "Demon" (script.Parent).
--
-- CÓMO USARLO:
-- 1. El Model "Demon" debe tener HumanoidRootPart, RightHand y LeftHand
--    (esqueleto R15). No hace falta la espada "ClassicSword" de "Ataque
--    del demonio": el bate lo construye este mismo script con dos Parts.
-- 2. Crea un IntValue "AttackSpeed" dentro de la Folder "NPC" (igual que
--    en "Ataque del demonio" — el script lo busca como
--    script.Parent.Parent.AttackSpeed).
-- 3. Selecciona el Model "Demon" e inserta este script (en vez de, no
--    junto con, "Ataque del demonio").
--
-- Qué hace: construye un bate de béisbol con dos Parts (mango + cabeza),
-- lo mantiene flotando junto a la mano derecha del Demon, y lo hace
-- balancearse de un lado a otro sin parar, simulando que golpea. Igual
-- que "Ataque del demonio", quita salud al tocar al jugador con las
-- manos o con el bate.
--
-- Nota: en vez de soldar el bate al hueso de la mano con un Motor6D (la
-- orientación exacta de RightHand varía según el modelo/rig que uses),
-- el bate se reposiciona cada fotograma relativo al HumanoidRootPart,
-- que siempre apunta "hacia adelante" de forma predecible sin importar
-- el rig. Si el bate no queda bien alineado con la mano de tu modelo,
-- ajusta BATE_OFFSET.
--
-- Para experimentar: cambia BATE_LARGO/BATE_GROSOR para un bate más
-- grande o pequeño, SWING_ANGULO para un golpe más amplio, o
-- SWING_VELOCIDAD para un balanceo más rápido.

local RunService = game.RunService

local BATE_LARGO = 2.2
local BATE_GROSOR = 0.35
local SWING_ANGULO = 50
local SWING_VELOCIDAD = 6
local BATE_OFFSET = CFrame.new(1.2, 0, -0.6) -- a la derecha y un poco al frente del HumanoidRootPart

local rightHand = script.Parent:FindFirstChild("RightHand")
local leftHand = script.Parent:FindFirstChild("LeftHand")
local hrp = script.Parent:FindFirstChild("HumanoidRootPart")
local attackSpeed = script.Parent.Parent.AttackSpeed

-- Construir el bate: mango delgado + cabeza más gruesa, en línea recta
local bate = Instance.new("Model")
bate.Name = "Bate"

local mango = Instance.new("Part")
mango.Name = "Mango"
mango.Shape = Enum.PartType.Cylinder
mango.Size = Vector3.new(BATE_LARGO * 0.4, BATE_GROSOR, BATE_GROSOR)
mango.Material = Enum.Material.Wood
mango.BrickColor = BrickColor.new("Reddish brown")
mango.Anchored = true
mango.CanCollide = false
mango.Parent = bate

local cabeza = Instance.new("Part")
cabeza.Name = "Cabeza"
cabeza.Shape = Enum.PartType.Cylinder
cabeza.Size = Vector3.new(BATE_LARGO * 0.6, BATE_GROSOR * 1.8, BATE_GROSOR * 1.8)
cabeza.Material = Enum.Material.Wood
cabeza.BrickColor = BrickColor.new("Reddish brown")
cabeza.Anchored = true
cabeza.CanCollide = false
cabeza.Parent = bate

mango.CFrame = hrp.CFrame * BATE_OFFSET
cabeza.CFrame = mango.CFrame * CFrame.new(BATE_LARGO * 0.5, 0, 0)

bate.PrimaryPart = mango
bate.Parent = script.Parent

-- Balanceo continuo: gira el bate de lado a lado sin parar
local swingConnection
swingConnection = RunService.Heartbeat:Connect(function()
	if not hrp.Parent then
		swingConnection:Disconnect()
		return
	end
	local angulo = math.sin(tick() * SWING_VELOCIDAD) * SWING_ANGULO
	bate:PivotTo(hrp.CFrame * BATE_OFFSET * CFrame.Angles(0, math.rad(angulo), 0))
end)

local function damageWithHand(hit)
	local humanoid = hit.Parent and hit.Parent:FindFirstChild("Humanoid")
	if humanoid then
		humanoid.Health -= 0.1
		task.wait(attackSpeed.Value)
	end
end

local function damageWithBate(hit)
	local humanoid = hit.Parent and hit.Parent:FindFirstChild("Humanoid")
	if humanoid then
		humanoid.Health -= 1
		task.wait(attackSpeed.Value)
	end
end

rightHand.Touched:Connect(damageWithHand)
leftHand.Touched:Connect(damageWithHand)
cabeza.Touched:Connect(damageWithBate)
mango.Touched:Connect(damageWithBate)
