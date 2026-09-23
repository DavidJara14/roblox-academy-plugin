-- Pregunta de elección múltiple: respuesta incorrecta — Módulo 2, Lección 4
--
-- Ubicación: dentro de la Part de respuesta incorrecta (script.Parent).
--
-- CÓMO USARLO:
-- 1. Selecciona la Part que representa una respuesta incorrecta.
-- 2. Inserta este script.
--
-- Qué hace: si el personaje toca esta Part, muere al instante.

local respuesta = script.Parent

local function onTocada(hit)
	local humanoid = hit.Parent and hit.Parent:FindFirstChild("Humanoid")
	if humanoid then
		humanoid.Health = 0
	end
end

respuesta.Touched:Connect(onTocada)
