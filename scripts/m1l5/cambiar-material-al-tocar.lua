-- Cambiar Material al tocar — Módulo 1, Lección 5
--
-- CÓMO USARLO:
-- 1. Selecciona en el Explorer la Part que quieras convertir en botón
--    (cualquier Part sirve, no necesita un nombre especial).
-- 2. Pulsa "Insertar" en el plugin.
-- 3. Dale a Play y toca la Part con tu personaje.
--
-- Qué hace: al tocar esta Part, cambia su Material a Neon.
--
-- Nota: solo reacciona si lo que la toca es un personaje (tiene un
-- Humanoid) — así no se activa por accidente al tocar el suelo u otra
-- Part cuando empieza la partida.
--
-- Para experimentar: prueba otros materiales, por ejemplo
-- Enum.Material.Ice, Enum.Material.Wood o Enum.Material.ForceField.

local NUEVO_MATERIAL = Enum.Material.Neon

local boton = script.Parent

local function onBotonTocado(hit)
	local character = hit.Parent
	if character and character:FindFirstChild("Humanoid") then
		boton.Material = NUEVO_MATERIAL
	end
end

boton.Touched:Connect(onBotonTocado)
