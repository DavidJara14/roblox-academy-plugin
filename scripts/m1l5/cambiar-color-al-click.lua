-- Cambiar Color al hacer clic — Módulo 1, Lección 5 (variante con ClickDetector)
--
-- CÓMO USARLO:
-- 1. Selecciona la Part que quieras convertir en botón y añádele un
--    ClickDetector como hijo. Para esta actividad no hace falta nada
--    más: solo la Part principal en Workspace, con el ClickDetector y
--    este script dentro.
-- 2. Con esa misma Part seleccionada, pulsa "Insertar" en el plugin.
-- 3. Dale a Play y haz clic con el mouse sobre la Part.
--
-- Qué hace: al hacer clic en la Part, cambia su color (BrickColor).

local NUEVO_COLOR = BrickColor.new("Lime green")

local boton = script.Parent
local clickDetector = boton:WaitForChild("ClickDetector")

local function onBotonClicado()
	boton.BrickColor = NUEVO_COLOR
end

clickDetector.MouseClick:Connect(onBotonClicado)
