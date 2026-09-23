-- Cambiar Color al tocar — Módulo 1, Lección 5
--
-- Ubicación: dentro de la Part que quieras convertir en botón (usa
-- script.Parent). Funciona con cualquier Part.
--
-- Qué hace: al tocar esta Part, cambia su color (BrickColor).
--
-- El color se puede indicar de tres formas (edita NUEVO_COLOR):
--   BrickColor.new("Lime green")   -- por nombre
--   BrickColor.new(1020)           -- por número
--   BrickColor.new(0, 255, 0)      -- por combinación RGB

local NUEVO_COLOR = BrickColor.new("Lime green")

local boton = script.Parent

local function onBotonTocado()
	boton.BrickColor = NUEVO_COLOR
end

boton.Touched:Connect(onBotonTocado)
