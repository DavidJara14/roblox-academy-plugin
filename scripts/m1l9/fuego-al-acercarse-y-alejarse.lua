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
--
-- Nota: solo reacciona si lo que toca/deja de tocar Area es un
-- personaje (tiene un Humanoid).
--
-- Para experimentar: cambia SEGUNDOS_ANTES_DE_APAGAR, o en las
-- propiedades del Fire prueba Size, Heat y Color.

local SEGUNDOS_ANTES_DE_APAGAR = 3

local function getFire()
	local torch = game.Workspace:FindFirstChild("Torch")
	return torch and torch:FindFirstChild("Fire")
end

local function isCharacter(hit)
	local character = hit.Parent
	return character and character:FindFirstChild("Humanoid") ~= nil
end

local function onAreaTouched(hit)
	if not isCharacter(hit) then
		return
	end
	local fire = getFire()
	if fire then
		fire.Enabled = true
	end
end

local function onAreaTouchEnded(hit)
	if not isCharacter(hit) then
		return
	end
	task.wait(SEGUNDOS_ANTES_DE_APAGAR)
	local fire = getFire()
	if fire then
		fire.Enabled = false
	end
end

local area = game.Workspace.Area
area.Touched:Connect(onAreaTouched)
area.TouchEnded:Connect(onAreaTouchEnded)
