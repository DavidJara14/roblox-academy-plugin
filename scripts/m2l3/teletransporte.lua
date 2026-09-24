-- Teletransporte entre dos puntos — Módulo 2, Lección 3
--
-- Ubicación: dentro de la Folder que contiene las 2 Parts (usa script.Parent).
--
-- CÓMO USARLO:
-- 1. Crea una Folder en Workspace.
-- 2. Dentro, crea 2 Parts ancladas de colores distintos: Part1 (origen,
--    donde el jugador debe pisar) y Part2 (destino).
-- 3. Selecciona la Folder e inserta este script.
--
-- Qué hace: al tocar Part1, mueve al personaje completo a la posición de
-- Part2 (elevado 10 studs para no incrustarlo en el suelo).
--
-- Nota: reacciona a cualquier cosa que toque Part1, no solo a
-- personajes — se mantiene simple a propósito.

local startPoint = script.Parent.Part1
local endPoint = script.Parent.Part2

local function onStartPointTouched(hit)
	local character = hit.Parent
	if character then
		character:MoveTo(endPoint.Position + Vector3.new(0, 10, 0))
	end
end

startPoint.Touched:Connect(onStartPointTouched)
