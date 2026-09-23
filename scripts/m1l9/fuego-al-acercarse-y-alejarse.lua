-- Fuego que se enciende y apaga según proximidad — Módulo 1, Lección 9
--
-- Ubicación: script independiente en Workspace (coordina dos Parts
-- distintas — la zona y la antorcha — así que no vive dentro de
-- ninguna de las dos).
-- Requisito: una Part transparente y anclada en Workspace nombrada
-- exactamente Area (zona de detección), y una Part Torch con un efecto
-- Fire como hijo.
--
-- Qué hace: enciende el fuego cuando el jugador toca Area, y lo apaga
-- (con 3 segundos de retraso) cuando el jugador deja de tocarla.

local Workspace = game:GetService("Workspace")

local SEGUNDOS_ANTES_DE_APAGAR = 3

local function getFire()
	local torch = Workspace:FindFirstChild("Torch")
	return torch and torch:FindFirstChild("Fire")
end

local function onAreaTouched()
	local fire = getFire()
	if fire then
		fire.Enabled = true
	end
end

local function onAreaTouchEnded()
	task.wait(SEGUNDOS_ANTES_DE_APAGAR)
	local fire = getFire()
	if fire then
		fire.Enabled = false
	end
end

local area = Workspace:WaitForChild("Area")
area.Touched:Connect(onAreaTouched)
area.TouchEnded:Connect(onAreaTouchEnded)
