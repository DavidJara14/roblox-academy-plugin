-- Generar muros perimetrales — Módulo 3, Lección 2
--
-- Ubicación: Script dentro de la misma Folder de mapa que usas para
-- "Generar laberinto" (script.Parent).
--
-- CÓMO USARLO:
-- 1. Crea una Part plantilla "Wall" en ServerStorage (por ejemplo
--    4x4x20 studs, anclada).
-- 2. Selecciona la Folder de mapa e inserta este script (puede ser la
--    misma Folder donde insertaste "Generar laberinto", no hay orden
--    obligatorio entre ambos).
-- 3. Presiona Play: los 4 muros se generan una sola vez, al iniciar.
--
-- Qué hace: clona la Part "Wall" a lo largo de los 4 bordes del mapa
-- (de -256 a 256 studs, cada 4 studs), formando un perímetro cerrado.

for x = -256, 256, 4 do
	local norte = game.ServerStorage.Wall:Clone()
	norte.Position = Vector3.new(x, 2, -248)
	norte.Parent = script.Parent

	local sur = game.ServerStorage.Wall:Clone()
	sur.Position = Vector3.new(x, 2, 248)
	sur.Parent = script.Parent

	local este = game.ServerStorage.Wall:Clone()
	este.Position = Vector3.new(248, 2, x)
	este.Parent = script.Parent

	local oeste = game.ServerStorage.Wall:Clone()
	oeste.Position = Vector3.new(-248, 2, x)
	oeste.Parent = script.Parent
end
