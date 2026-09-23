-- Emitir partículas al tocar — Módulo 1, Lección 5
--
-- CÓMO USARLO:
-- 1. Selecciona la Part que quieras decorar y añádele un efecto
--    Sparkles como hijo (clic derecho en la Part > Insert Object >
--    Sparkles, o desde la pestaña Model > Effects > Sparkles).
-- 2. Con esa misma Part seleccionada, pulsa "Insertar" en el plugin.
-- 3. Dale a Play y toca la Part con tu personaje.
--
-- Qué hace: el efecto Sparkles empieza apagado; al tocar la Part con
-- el personaje, se activa (Enabled = true) y la Part queda "brillando"
-- con destellos de forma permanente.
--
-- Nota: solo reacciona si lo que la toca es un personaje (tiene un
-- Humanoid).

local parte = script.Parent
local sparkles = parte:WaitForChild("Sparkles")

sparkles.Enabled = false

local function onParteTocada(hit)
	local character = hit.Parent
	if character and character:FindFirstChild("Humanoid") then
		sparkles.Enabled = true
	end
end

parte.Touched:Connect(onParteTocada)
