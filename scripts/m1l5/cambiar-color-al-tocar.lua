-- Cambiar Color al tocar — Módulo 1, Lección 5
--
-- CÓMO USARLO:
-- 1. Selecciona en el Explorer la Part que quieras convertir en botón.
-- 2. Pulsa "Insertar" en el plugin.
-- 3. Dale a Play y toca la Part con tu personaje.
--
-- Qué hace: al tocar esta Part, cambia su color (BrickColor).
--
-- El color se puede indicar de tres formas (edita NUEVO_COLOR):
--   BrickColor.new("Lime green")   -- por nombre
--   BrickColor.new(1020)           -- por número
--   BrickColor.new(0, 255, 0)      -- por combinación RGB
--
-- Nota: solo reacciona si lo que la toca es un personaje (tiene un
-- Humanoid) — así no se activa por accidente al tocar el suelo u otra
-- Part cuando empieza la partida.
--
-- Para experimentar: prueba otros valores de NUEVO_COLOR, o combínalo
-- con Material (por ejemplo Enum.Material.Neon) para que el color
-- resalte más.

local NUEVO_COLOR = BrickColor.new("Lime green")

local boton = script.Parent

local function onBotonTocado(hit)
	local character = hit.Parent
	if character and character:FindFirstChild("Humanoid") then
		boton.BrickColor = NUEVO_COLOR
	end
end

boton.Touched:Connect(onBotonTocado)
