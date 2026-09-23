-- Mostrar/ocultar menú de coches — Módulo 4, Lección 1
--
-- Ubicación: LocalScript dentro del ScreenGui (script.Parent), hermano
-- del botón "SpawnCar" y del Frame del menú.
--
-- CÓMO USARLO:
-- 1. Crea un ScreenGui con un ImageButton "SpawnCar" y un Frame (el
--    menú de selección de coches).
-- 2. Selecciona el ScreenGui e inserta este script.
-- 3. Presiona Play y pulsa "SpawnCar".
--
-- Qué hace: cada vez que se pulsa el botón "SpawnCar", muestra u
-- oculta el Frame del menú (alterna su propiedad Visible).

local button = script.Parent.SpawnCar
local menuFrame = script.Parent.Frame

local function alternarMenu()
	menuFrame.Visible = not menuFrame.Visible
end

button.MouseButton1Click:Connect(alternarMenu)
