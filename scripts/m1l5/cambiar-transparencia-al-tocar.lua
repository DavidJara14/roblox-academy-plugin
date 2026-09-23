-- Cambiar Transparencia al tocar — Módulo 1, Lección 5
--
-- Ubicación: dentro de la Part que quieras convertir en botón (usa
-- script.Parent). Funciona con cualquier Part.
--
-- Qué hace: al tocar esta Part, cambia su Transparency
-- (0 = opaco, 1 = invisible).

local NUEVA_TRANSPARENCIA = 0.5

local boton = script.Parent

local function onBotonTocado()
	boton.Transparency = NUEVA_TRANSPARENCIA
end

boton.Touched:Connect(onBotonTocado)
