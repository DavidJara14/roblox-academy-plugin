-- Generar laberinto — Módulo 3, Lección 2
--
-- Ubicación: Script dentro de la Folder "Map" (script.Parent).
--
-- CÓMO USARLO:
-- 1. Crea una Part plantilla "Block" en ServerStorage.
-- 2. Crea una Folder "Map" (vacía) en Workspace.
-- 3. Selecciona la Folder "Map" e inserta este script.
-- 4. Presiona Play: el laberinto se genera una sola vez, al iniciar.
--
-- Qué hace: recorre una cuadrícula de -200 a 200 (pasos de 20 studs) y,
-- por cada celda, tira un número aleatorio: con más de 75 crea un
-- bloque de piso completo, entre 25 y 75 crea solo un "techo" fino, y
-- por debajo de 25 no crea nada — así el laberinto sale distinto cada
-- vez que se juega.
--
-- Nota: el original apuntaba a "game.Workspace.Map" por nombre fijo;
-- aquí se usa "script.Parent" (la propia Folder donde insertaste el
-- script), así funciona sin importar cómo la hayas nombrado o dónde
-- la muevas.

local BLOCK_SIZE = 20

for x = -200, 200, BLOCK_SIZE do
	for y = -200, 200, BLOCK_SIZE do
		local chance = math.random(100)
		if chance > 75 then
			local bloque = game.ServerStorage.Block:Clone()
			bloque.Size = Vector3.new(BLOCK_SIZE, 20, BLOCK_SIZE)
			bloque.Position = Vector3.new(x, 9, y)
			bloque.Parent = script.Parent
		elseif chance > 25 then
			local bloque = game.ServerStorage.Block:Clone()
			bloque.Size = Vector3.new(BLOCK_SIZE, 1, BLOCK_SIZE)
			bloque.Position = Vector3.new(x, 19, y)
			bloque.Parent = script.Parent
		end
	end
end
