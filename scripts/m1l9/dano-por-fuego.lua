-- Daño por fuego (antorcha peligrosa) — Módulo 1, Lección 9
--
-- Ubicación: dentro de la propia Part de la antorcha (usa script.Parent).
-- Requisito: la Part debe tener un efecto Fire como hijo para que el
-- daño se aplique (ver nota abajo).
--
-- Qué hace: si el personaje de un jugador toca esta Part mientras tiene
-- el efecto Fire como hijo, le quita 20 puntos de salud. Usa una bandera
-- de "enfriamiento" (cooldown) para no aplicar daño en cada instante de
-- contacto continuo.
--
-- Nota de diseño: el daño depende de que exista el efecto Fire como
-- hijo de esta Part, no de si Fire.Enabled es true o false. Si combinas
-- este script con uno de los que apagan el fuego (fuego-por-tiempo.lua,
-- fuego-al-acercarse-y-alejarse.lua), la antorcha seguirá haciendo daño
-- incluso con la llama visualmente apagada. Si prefieres que el daño
-- dependa también de Fire.Enabled, cambia la condición de más abajo.

local torchPart = script.Parent

local enFriamiento = false
local DANO = 20
local SEGUNDOS_DE_COOLDOWN = 0.2

local function onTorchTouched(hit)
	if enFriamiento then
		return
	end

	local character = hit.Parent
	local humanoid = character and character:FindFirstChild("Humanoid")
	if not humanoid then
		return
	end

	if not torchPart:FindFirstChild("Fire") then
		return
	end

	enFriamiento = true
	humanoid:TakeDamage(DANO)
	task.wait(SEGUNDOS_DE_COOLDOWN)
	enFriamiento = false
end

torchPart.Touched:Connect(onTorchTouched)
