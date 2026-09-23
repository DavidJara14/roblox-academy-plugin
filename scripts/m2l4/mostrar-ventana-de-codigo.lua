-- Mostrar ventana de respuesta al presionar un botón — Módulo 2, Lección 4
--
-- Ubicación: LocalScript dentro del ScreenGui (usa script.Parent). La
-- diapositiva original lo llama "Script", pero MouseButton1Click solo
-- funciona desde StarterGui si es LocalScript.
--
-- CÓMO USARLO:
-- 1. Crea un ScreenGui en StarterGui con un TextButton (nombrado
--    TextButton) y un Frame (nombrado Frame, con Visible = false).
-- 2. Selecciona el ScreenGui e inserta este script.
--
-- Qué hace: al presionar el botón, hace visible el Frame.

local boton = script.Parent.TextButton
local ventana = script.Parent.Frame

local function mostrarVentana()
	ventana.Visible = true
end

boton.MouseButton1Click:Connect(mostrarVentana)
