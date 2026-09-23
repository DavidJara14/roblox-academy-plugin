-- Cambiar Transparencia al hacer clic — Módulo 1, Lección 5 (variante con ClickDetector)
--
-- CÓMO USARLO:
-- 1. Selecciona la Part que quieras convertir en botón y añádele un
--    ClickDetector como hijo. Para esta actividad no hace falta nada
--    más: solo la Part principal en Workspace, con el ClickDetector y
--    este script dentro.
-- 2. Con esa misma Part seleccionada, pulsa "Insertar" en el plugin.
-- 3. Dale a Play y haz clic con el mouse sobre la Part.
--
-- Qué hace: al hacer clic en la Part, cambia su Transparency
-- (0 = opaco, 1 = invisible).
--
-- Para experimentar: prueba NUEVA_TRANSPARENCIA = 1, o la propiedad
-- MaxActivationDistance del ClickDetector.

local NUEVA_TRANSPARENCIA = 0.5

local boton = script.Parent
local clickDetector = boton.ClickDetector

local function onBotonClicado()
	boton.Transparency = NUEVA_TRANSPARENCIA
end

clickDetector.MouseClick:Connect(onBotonClicado)
