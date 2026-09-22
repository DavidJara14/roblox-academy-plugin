-- Desaparición (destrucción) de una Part al tocarla — Módulo 1, Lección 9
--
-- Ubicación: ServerScriptService.
-- Requisito: una Part en Workspace nombrada exactamente SorpresaFragil.
--
-- Qué hace: cuando el jugador toca la Part, esta se destruye
-- permanentemente (a diferencia de "aparicion-de-objeto.lua", esto no
-- se puede revertir sin recrear la Part).

local Workspace = game:GetService("Workspace")

local function onFragilTouched(hit)
	local character = hit.Parent
	if character and character:FindFirstChild("Humanoid") then
		Workspace.SorpresaFragil:Destroy()
	end
end

local parteFragil = Workspace:WaitForChild("SorpresaFragil")
parteFragil.Touched:Connect(onFragilTouched)
