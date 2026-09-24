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
-- Nota: solo reacciona si lo que toca Area es un personaje (tiene un
-- Humanoid) — así no se enciende por accidente si Area toca el suelo
-- u otra Part.
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
	if not (character and character:FindFirstChild("Humanoid")) then
		return
	end

	local fire = game.Workspace:FindFirstChild("Torch") and game.Workspace.Torch:FindFirstChild("Fire")
	if fire then
		fire.Enabled = true
	end
end

local area = game.Workspace.Area
area.Touched:Connect(onAreaTouched)
