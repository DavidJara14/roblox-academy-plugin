-- Parpadeo de tres luces — Módulo 1, Lección 7
--
-- Ubicación: dentro de un contenedor común (usa script.Parent), que
-- debe tener 3 Parts hijas nombradas exactamente Part1, Part2, Part3,
-- cada una con el tipo de luz correspondiente como hijo directo (nombre
-- por defecto al insertarlo desde la pestaña Model > Lighting):
--   Part1 -> PointLight
--   Part2 -> SpotLight
--   Part3 -> SurfaceLight
--
-- Qué hace: apaga las tres luces, espera 1 segundo, las enciende, espera
-- 1 segundo, y repite indefinidamente — parpadean sincronizadas.
--
-- Para experimentar: cambia el 1 de los task.wait() para que el
-- parpadeo sea más rápido o más lento. En las propiedades de cada luz
-- prueba también Brightness, Range y Color.

local pointLight = script.Parent.Part1.PointLight
local spotLight = script.Parent.Part2.SpotLight
local surfaceLight = script.Parent.Part3.SurfaceLight

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
