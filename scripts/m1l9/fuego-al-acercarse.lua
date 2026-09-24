-- Fuego que se enciende al acercarse — Módulo 1, Lección 9
--
-- Ubicación: dentro de la Part de la antorcha (usa script.Parent), que
-- debe tener un efecto Fire como hijo.
-- Requisito: una Part transparente y anclada en Workspace nombrada
-- exactamente Area (zona de detección).
--
-- Qué hace: enciende el fuego cuando el jugador toca la Part Area.
--
-- Nota: este script NUNCA apaga el fuego de nuevo. Es la versión
-- intermedia tal como aparece en la lección — para el comportamiento
-- completo (se apaga al alejarse), usa
-- "fuego-al-acercarse-y-alejarse.lua" en su lugar.
--
-- Para experimentar: en las propiedades del Fire prueba Size, Heat y
-- Color para que la llama se vea distinta.

local function onAreaTouched(hit)
	local character = hit.Parent
	local fire = script.Parent.Fire

	if character and fire then
		fire.Enabled = true
	end
end

local area = game.Workspace.Area
area.Touched:Connect(onAreaTouched)
