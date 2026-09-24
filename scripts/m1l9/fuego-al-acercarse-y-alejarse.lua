-- Fuego que se enciende y apaga según proximidad — Módulo 1, Lección 9
--
-- Ubicación: dentro de la Part de la antorcha (usa script.Parent), que
-- debe tener un efecto Fire como hijo.
-- Requisito: una Part transparente y anclada en Workspace nombrada
-- exactamente Area (zona de detección).
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

local fire = script.Parent.Fire
local area = game.Workspace.Area

local function onAreaTouched(hit)
	local character = hit.Parent
	local humanoid = character:FindFirstChild("Humanoid")
	if humanoid then
		fire.Enabled = true
	end
end

local function onAreaTouchEnded(hit)
	local character = hit.Parent
	local humanoid = character:FindFirstChild("Humanoid")
	if humanoid then
		task.wait(SEGUNDOS_ANTES_DE_APAGAR)
		fire.Enabled = false
	end
end

area.Touched:Connect(onAreaTouched)
area.TouchEnded:Connect(onAreaTouchEnded)
