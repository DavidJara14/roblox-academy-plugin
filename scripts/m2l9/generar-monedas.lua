-- CreateCoinScript: generar monedas periódicamente — Módulo 2, Lección 9
--
-- Ubicación: dentro de la Part "Coin" (script.Parent), junto a
-- recolectar-moneda.lua (como hermano, deshabilitado).
--
-- CÓMO USARLO:
-- 1. Crea una Folder "CoinSpawner" en Workspace con una Part "Coin"
--    dentro.
-- 2. Inserta primero recolectar-moneda.lua en "Coin" y deshabilítalo
--    (propiedad Disabled = true).
-- 3. Selecciona "Coin" e inserta este script.
--
-- Qué hace: cada 5-60 segundos (al azar), crea una copia visual de
-- moneda cerca de esta Part, con una copia habilitada de
-- recolectar-moneda.lua dentro.

while true do
	local tiempoEspera = math.random(5, 60)
	task.wait(tiempoEspera)

	local moneda = Instance.new("Part")
	moneda.Name = "coin"
	moneda.Shape = Enum.PartType.Cylinder
	moneda.Material = Enum.Material.Metal
	moneda.Color = Color3.new(1, 0.933333, 0.00392157)
	moneda.Size = Vector3.new(0.2, 2, 2)
	moneda.Position = script.Parent.Position + Vector3.new(math.random(-2, 2), 2, math.random(-2, 2))
	moneda.Anchored = true
	moneda.CanCollide = false
	moneda.Parent = game.Workspace.CoinSpawner

	local collectScript = script.Parent.CoinCollectScript
	collectScript.Disabled = false
	collectScript:Clone().Parent = moneda
	collectScript.Disabled = true
end
