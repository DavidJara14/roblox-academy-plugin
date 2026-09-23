-- Pregunta de elección múltiple: respuesta correcta — Módulo 2, Lección 4
--
-- Ubicación: dentro de la Part de respuesta correcta (script.Parent).
-- Requisito: esa Part debe tener un ParticleEmitter como hijo, apagado.
--
-- CÓMO USARLO:
-- 1. Añade un ParticleEmitter (apagado) a la Part de respuesta correcta.
-- 2. Selecciona esa Part e inserta este script.
--
-- Qué hace: si el personaje toca esta Part, enciende su ParticleEmitter.

local respuesta = script.Parent
local particulas = respuesta:WaitForChild("ParticleEmitter")

local function onTocada(hit)
	local humanoid = hit.Parent and hit.Parent:FindFirstChild("Humanoid")
	if humanoid then
		particulas.Enabled = true
	end
end

respuesta.Touched:Connect(onTocada)
