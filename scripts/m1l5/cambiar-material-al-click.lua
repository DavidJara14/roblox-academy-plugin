-- Cambiar Material al hacer clic — Módulo 1, Lección 5 (variante con ClickDetector)
--
-- CÓMO USARLO:
-- 1. Selecciona la Part que quieras convertir en botón y añádele un
--    ClickDetector como hijo (clic derecho > Insert Object >
--    ClickDetector). Para esta actividad no hace falta nada más: solo
--    la Part principal en Workspace, con el ClickDetector y este
--    script dentro.
-- 2. Con esa misma Part seleccionada, pulsa "Insertar" en el plugin.
-- 3. Dale a Play y haz clic con el mouse sobre la Part (necesitas estar
--    a poca distancia; el ClickDetector tiene un rango máximo).
--
-- Qué hace: al hacer clic en la Part, cambia su Material a Neon.
--
-- Diferencia con la versión "al tocar": aquí no hace falta revisar si
-- es un personaje, porque un ClickDetector solo se activa con un clic
-- de mouse de un jugador real — nunca por contacto físico con el suelo
-- u otra Part.

local NUEVO_MATERIAL = Enum.Material.Neon

local boton = script.Parent
local clickDetector = boton:WaitForChild("ClickDetector")

local function onBotonClicado()
	boton.Material = NUEVO_MATERIAL
end

clickDetector.MouseClick:Connect(onBotonClicado)
