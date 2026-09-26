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
--
-- Corrección sobre el material original: nunca rotaba los muros del
-- norte/sur, así que su lado largo (el eje Z de la Part "Wall", de 20
-- studs) quedaba perpendicular a la línea del muro en vez de a lo
-- largo de ella — se veía como una fila de rejas sueltas, no como una
-- pared sólida. Los del este/oeste ya estaban bien porque su eje largo
-- coincide de casualidad con la dirección en la que corren. Aquí se
-- giran los del norte/sur 90 grados en Y para alinearlos.

for x = -256, 256, 4 do
	local norte = game.ServerStorage.Wall:Clone()
	norte.CFrame = CFrame.new(x, 2, -248) * CFrame.Angles(0, math.rad(90), 0)
	norte.Parent = script.Parent

	local sur = game.ServerStorage.Wall:Clone()
	sur.CFrame = CFrame.new(x, 2, 248) * CFrame.Angles(0, math.rad(90), 0)
	sur.Parent = script.Parent

	local este = game.ServerStorage.Wall:Clone()
	este.Position = Vector3.new(248, 2, x)
	este.Parent = script.Parent

	local oeste = game.ServerStorage.Wall:Clone()
	oeste.Position = Vector3.new(-248, 2, x)
	oeste.Parent = script.Parent
end
