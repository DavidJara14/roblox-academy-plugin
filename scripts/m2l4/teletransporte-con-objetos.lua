-- Teletransporte que se desbloquea al recoger 3 objetos — Módulo 2, Lección 4
--
-- Ubicación: dentro de la Folder "Teleports" (usa script.Parent), junto a
-- Part1 (destino oculto) y Part2 (llegada) — mismo patrón que
-- m2l3/teletransporte.lua.
--
-- CÓMO USARLO:
-- 1. Crea una Folder "Teleports" en Workspace con Part1 y Part2 dentro
--    (ver m2l3/teletransporte.lua para ese patrón base).
-- 2. Crea 3 Parts coleccionables en Workspace y renómbralas exactamente
--    Crystal1, Crystal2, Crystal3.
-- 3. Selecciona la Folder "Teleports" e inserta este script.
--
-- Qué hace: esconde Part1 (transparente y elevada) hasta que el jugador
-- toque los 3 cristales; cada cristal tocado se destruye y cuenta; al
-- llegar a 3, Part1 vuelve a su posición y se hace visible.

local Workspace = game:GetService("Workspace")

local part1 = script.Parent.Part1
part1.Transparency = 1
part1.Position = part1.Position + Vector3.new(0, 100, 0)

local cristalesRecogidos = 0

local function onCristalTocado(cristal, hit)
	local humanoid = hit.Parent and hit.Parent:FindFirstChild("Humanoid")
	if not humanoid then
		return
	end
	cristal:Destroy()
	cristalesRecogidos += 1
	if cristalesRecogidos == 3 then
		part1.Position = part1.Position - Vector3.new(0, 100, 0)
		part1.Transparency = 0
	end
end

for _, nombre in { "Crystal1", "Crystal2", "Crystal3" } do
	local cristal = Workspace:WaitForChild(nombre)
	cristal.Touched:Connect(function(hit)
		onCristalTocado(cristal, hit)
	end)
end
