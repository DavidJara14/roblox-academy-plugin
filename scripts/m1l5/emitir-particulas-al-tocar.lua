-- Emitir partículas al tocar — Módulo 1, Lección 5
--
-- CÓMO USARLO:
-- 1. Selecciona la Part que quieras decorar y añádele un efecto
--    ParticleEmitter como hijo (clic derecho en la Part > Insert Object
--    > ParticleEmitter, o desde la pestaña Model > Effects).
-- 2. Con esa misma Part seleccionada, pulsa "Insertar" en el plugin.
-- 3. Dale a Play y toca la Part con tu personaje.
--
-- Qué hace: el efecto ParticleEmitter empieza apagado; al tocar la Part
-- con el personaje, se activa (Enabled = true) y la Part queda
-- "brillando" con partículas de forma permanente.
--
-- Nota: solo reacciona si lo que la toca es un personaje (tiene un
-- Humanoid).
--
-- Para experimentar: en las propiedades del ParticleEmitter prueba
-- cambiar Rate (cuántas partículas salen por segundo), Speed (qué tan
-- rápido se alejan) y Color.

local parte = script.Parent
local particulas = parte.ParticleEmitter

particulas.Enabled = false

local function onParteTocada(hit)
	local character = hit.Parent
	local humanoid = character:FindFirstChild("Humanoid")
	if humanoid then
		particulas.Enabled = true
	end
end

parte.Touched:Connect(onParteTocada)
