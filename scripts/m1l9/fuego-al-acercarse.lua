-- Fuego que se enciende al acercarse — Módulo 1, Lección 9
--
-- Ubicación: script independiente en Workspace (coordina dos Parts
-- distintas — la zona y la antorcha — así que no vive dentro de
-- ninguna de las dos).
-- Requisito: una Part transparente y anclada en Workspace nombrada
-- exactamente Area (zona de detección), y una Part Torch con un efecto
-- Fire como hijo.
--
-- Qué hace: enciende el fuego cuando el jugador toca la Part Area.
--
-- Nota: este script NUNCA apaga el fuego de nuevo. Es la versión
-- intermedia tal como aparece en la lección — para el comportamiento
-- completo (se apaga al alejarse), usa
-- "fuego-al-acercarse-y-alejarse.lua" en su lugar.

local Workspace = game:GetService("Workspace")

local function onAreaTouched()
	local fire = Workspace:FindFirstChild("Torch") and Workspace.Torch:FindFirstChild("Fire")
	if fire then
		fire.Enabled = true
	end
end

local area = Workspace:WaitForChild("Area")
area.Touched:Connect(onAreaTouched)
