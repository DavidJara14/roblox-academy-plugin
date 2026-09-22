-- Dynamite (peligro que destruye al personaje) — Módulo 1, Lección 5
--
-- Ubicación: ServerScriptService.
-- Requisito: crea una Part en Workspace y renómbrala exactamente Dynamite.
--
-- Qué hace: cuando el personaje de un jugador toca la Part Dynamite,
-- su Humanoid.Health se pone en 0, lo que lo mata/destruye al instante.

local Workspace = game:GetService("Workspace")

local function onDynamiteTouched(hit)
	local character = hit.Parent
	local humanoid = character and character:FindFirstChild("Humanoid")
	if humanoid then
		humanoid.Health = 0
	end
end

local dynamite = Workspace:WaitForChild("Dynamite")
dynamite.Touched:Connect(onDynamiteTouched)
