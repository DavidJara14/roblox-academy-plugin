-- Cambiar Transparencia al tocar — Módulo 1, Lección 5
--
-- CÓMO USARLO:
-- 1. Selecciona en el Explorer la Part que quieras convertir en botón.
-- 2. Pulsa "Insertar" en el plugin.
-- 3. Dale a Play y toca la Part con tu personaje.
--
-- Qué hace: al tocar esta Part, cambia su Transparency
-- (0 = opaco, 1 = invisible).
--
-- Nota: solo reacciona si lo que la toca es un personaje (tiene un
-- Humanoid) — así no se activa por accidente al tocar el suelo u otra
-- Part cuando empieza la partida.
--
-- Para experimentar: prueba NUEVA_TRANSPARENCIA = 1 (invisible) y
-- combínalo con CanCollide = false para hacer una Part que "desaparece"
-- del todo al tocarla.

local NUEVA_TRANSPARENCIA = 0.5

local boton = script.Parent

local function onBotonTocado(hit)
	local character = hit.Parent
	if character and character:FindFirstChild("Humanoid") then
		boton.Transparency = NUEVA_TRANSPARENCIA
	end
end

boton.Touched:Connect(onBotonTocado)
