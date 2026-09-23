-- Parpadeo de tres luces — Módulo 1, Lección 7
--
-- Ubicación: script independiente en Workspace (coordina 3 Parts a la
-- vez, así que no vive dentro de ninguna de ellas en particular).
-- Requisito: 3 Parts en Workspace nombradas exactamente Part1, Part2, Part3,
-- cada una con el tipo de luz correspondiente como hijo directo (nombre
-- por defecto al insertarlo desde la pestaña Model > Lighting):
--   Part1 -> PointLight
--   Part2 -> SpotLight
--   Part3 -> SurfaceLight
--
-- Qué hace: apaga las tres luces, espera 1 segundo, las enciende, espera
-- 1 segundo, y repite indefinidamente — parpadean sincronizadas.

local Workspace = game:GetService("Workspace")

local pointLight = Workspace:WaitForChild("Part1"):WaitForChild("PointLight")
local spotLight = Workspace:WaitForChild("Part2"):WaitForChild("SpotLight")
local surfaceLight = Workspace:WaitForChild("Part3"):WaitForChild("SurfaceLight")

while true do
	pointLight.Enabled = false
	spotLight.Enabled = false
	surfaceLight.Enabled = false
	task.wait(1)

	pointLight.Enabled = true
	spotLight.Enabled = true
	surfaceLight.Enabled = true
	task.wait(1)
end
