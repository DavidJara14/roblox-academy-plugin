-- Magic Wand: crear esferas aleatorias — Módulo 3, Lección 1
--
-- Ubicación: LocalScript dentro de la Tool "Magic Wand" (script.Parent).
--
-- CÓMO USARLO:
-- 1. Crea una Tool en StarterPack, renómbrala "Magic Wand", con su Part
--    "Handle" obligatoria.
-- 2. Selecciona la Tool "Magic Wand" e inserta este script.
-- 3. Presiona Play, equipa la varita y haz clic.
--
-- Qué hace: cada clic crea, cayendo desde arriba cerca de la varita,
-- una esfera de color y tamaño aleatorio.
--
-- Nota: al ser LocalScript, cada esfera solo la ve el jugador que la
-- generó (misma limitación que Brick, ver M3L3 para la versión
-- multijugador).
--
-- Correcciones sobre el script original de la diapositiva:
-- - Usaba "Wand.Part.Position" para ubicarse, lo que exigía que la
--   Part decorativa de la varita se llamara exactamente "Part". Ahora
--   usa "Wand.Handle.Position", que siempre existe en cualquier Tool.
-- - "detal.Shape = 'Ball'" (texto) no es válido en Luau; se cambió a
--   "Enum.PartType.Ball".
-- - "math.random(1.5)" da error en tiempo de ejecución (math.random
--   solo acepta límites enteros); se reemplazó por un multiplicador de
--   tamaño aleatorio entre 1.0 y 3.0.

local wand = script.Parent

local function crearEsfera()
	local origen = wand.Handle.Position
	local x = math.random(-20, 20)
	local z = math.random(-20, 20)

	local esfera = Instance.new("Part")
	esfera.Shape = Enum.PartType.Ball
	esfera.Position = Vector3.new(origen.X + x, 100, origen.Z + z)
	esfera.BrickColor = BrickColor.Random()

	local escala = math.random(10, 30) / 10
	esfera.Size = esfera.Size * escala

	esfera.Parent = workspace
end

wand.Activated:Connect(crearEsfera)
