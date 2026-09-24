-- Desaparición (destrucción) de una Part al tocarla — Módulo 1, Lección 9
--
-- Ubicación: dentro de la Part que quieras que desaparezca (usa
-- script.Parent). Funciona con cualquier Part.
--
-- Qué hace: cuando el personaje de un jugador la toca, la Part se
-- destruye permanentemente (no se puede revertir sin recrearla).
--
-- Para experimentar: antes de destruirla, prueba añadir un sonido o un
-- efecto de partículas para que la desaparición se note más.

local parte = script.Parent

local function onParteTocada(hit)
	local character = hit.Parent
	local humanoid = character:FindFirstChild("Humanoid")
	if humanoid then
		parte:Destroy()
	end
end

parte.Touched:Connect(onParteTocada)
