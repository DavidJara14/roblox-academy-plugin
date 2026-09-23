-- Validar el código secreto ingresado — Módulo 2, Lección 4
--
-- Ubicación: LocalScript dentro del Frame de la ventana (usa
-- script.Parent). Debe ser LocalScript: TextBox.FocusLost es una
-- interacción de cliente.
--
-- CÓMO USARLO:
-- 1. Dentro del Frame (ver mostrar-ventana-de-codigo.lua), añade un
--    TextBox nombrado TextBox.
-- 2. Cambia PALABRA_SECRETA abajo por el código que quieras.
-- 3. Selecciona el Frame e inserta este script.
--
-- Qué hace: compara lo escrito en el TextBox contra la palabra secreta;
-- pinta el TextBox de verde si acierta, de rojo si falla (y cierra la
-- ventana tras 4 segundos).

local PALABRA_SECRETA = "1254"

local frame = script.Parent
local textBox = frame.TextBox

local COLOR_NORMAL = Color3.new(1, 1, 1)
local COLOR_INCORRECTO = Color3.new(1, 0, 0)
local COLOR_CORRECTO = Color3.new(0, 1, 0)

textBox.ClearTextOnFocus = true
textBox.Text = ""
textBox.Font = Enum.Font.Code
textBox.PlaceholderText = "Ingresa la palabra secreta"
textBox.BackgroundColor3 = COLOR_NORMAL

local function onFocused()
	textBox.BackgroundColor3 = COLOR_NORMAL
end

local function onFocusLost(enterPressed)
	if not enterPressed then
		textBox.Text = ""
		textBox.BackgroundColor3 = COLOR_NORMAL
		return
	end

	if textBox.Text == PALABRA_SECRETA then
		textBox.Text = "Respuesta correcta"
		textBox.BackgroundColor3 = COLOR_CORRECTO
	else
		textBox.Text = "Respuesta incorrecta"
		textBox.BackgroundColor3 = COLOR_INCORRECTO
		task.wait(4)
		frame.Visible = false
	end
end

textBox.Focused:Connect(onFocused)
textBox.FocusLost:Connect(onFocusLost)
