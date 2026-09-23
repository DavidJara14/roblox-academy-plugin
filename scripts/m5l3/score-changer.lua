-- ScoreChanger: mostrar el puntaje en pantalla — Módulo 5, Lección 3
--
-- Ubicación: LocalScript dentro de un TextLabel (script.Parent), en
-- un ScreenGui.
--
-- CÓMO USARLO:
-- 1. Requiere "PlayerShipHandler" (crea leaderstats.Score) ya
--    insertado.
-- 2. Crea un TextLabel en un ScreenGui, con texto inicial "0".
-- 3. Selecciona el TextLabel e inserta este script.
--
-- Qué hace: muestra el puntaje actual del jugador (leaderstats.Score)
-- en el TextLabel, con el color del texto cambiando cíclicamente como
-- efecto decorativo.

local player = game.Players.LocalPlayer
local increment = 0

while true do
	increment += 0.01
	if increment > 1 then
		increment = 0
	end

	script.Parent.TextColor3 = Color3.fromHSV(increment, 1, 1)

	local score = player.leaderstats:WaitForChild("Score")
	script.Parent.Text = tostring(score.Value)

	task.wait(0.1)
end
