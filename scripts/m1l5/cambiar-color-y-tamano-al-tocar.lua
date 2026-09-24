-- Cambiar Color y Tamaño al tocar ("botón que se aprieta") — Módulo 1, Lección 5
--
-- CÓMO USARLO:
-- 1. Selecciona en el Explorer la Part que quieras convertir en botón.
-- 2. Pulsa "Insertar" en el plugin.
-- 3. Dale a Play y toca la Part con tu personaje.
--
-- Qué hace: al tocar esta Part, cambia su color a amarillo Y reduce su
-- altura — simula el efecto de un botón físico que se aprieta al
-- pisarlo.
--
-- Nota: reacciona a cualquier cosa que toque la Part, no solo a
-- personajes — se mantiene simple a propósito.
--
-- Tamaño recomendado para la Part antes de insertar: (5, 1, 5), anclada
-- y apoyada justo encima de una superficie (para que se note el efecto
-- de "hundirse"). El eje Y es la altura en Roblox — por eso es el que
-- se reduce.
--
-- Para experimentar: prueba otro NUEVO_COLOR, o cambia cuánto se reduce
-- la altura (el "5" en NUEVO_TAMANO) para que el botón se hunda más o
-- menos.

local NUEVO_COLOR = BrickColor.new(Color3.fromRGB(255, 255, 0))
local NUEVO_TAMANO = Vector3.new(5, 0.1, 5)

local boton = script.Parent

local function onBotonTocado(hit)
	local character = hit.Parent
	if character then
		boton.BrickColor = NUEVO_COLOR
		boton.Size = NUEVO_TAMANO
	end
end

boton.Touched:Connect(onBotonTocado)
