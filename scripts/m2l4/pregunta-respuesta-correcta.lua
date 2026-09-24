-- Pregunta de elección múltiple: respuesta correcta — Módulo 2, Lección 4
--
-- Ubicación: dentro de la Part de respuesta correcta (script.Parent).
-- Requisito: esa Part debe tener un ParticleEmitter como hijo, apagado.
--
-- CÓMO USARLO:
-- 1. Añade un ParticleEmitter (apagado) a la Part de respuesta correcta.
-- 2. Selecciona esa Part e inserta este script.
--
-- Qué hace: al tocar esta Part, enciende su ParticleEmitter.
--
-- Nota: reacciona a cualquier cosa que toque la Part, no solo a
-- personajes — se mantiene simple a propósito.

local respuesta = script.Parent
local particulas = respuesta.ParticleEmitter

local function onTocada(hit)
	local character = hit.Parent
	if character then
		particulas.Enabled = true
	end
end

respuesta.Touched:Connect(onTocada)
