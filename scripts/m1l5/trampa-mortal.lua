-- Trampa mortal (Part que mata al tocarla) — Módulo 1, Lección 5
--
-- Ubicación: dentro de la Part que quieras convertir en trampa (usa
-- script.Parent). Funciona con cualquier Part.
--
-- Qué hace: si el personaje de un jugador toca esta Part, su
-- Humanoid.Health se pone en 0 y muere al instante.
--
-- Nota: no hay ningún efecto visual de explosión — el personaje muere
-- de forma "silenciosa" (no se desarma ni desaparece), por eso el
-- script ya no se llama "Dynamite" como en la diapositiva original.

local trampa = script.Parent

local function onTrampaTocada(hit)
	local character = hit.Parent
	local humanoid = character and character:FindFirstChild("Humanoid")
	if humanoid then
		humanoid.Health = 0
	end
end

trampa.Touched:Connect(onTrampaTocada)
