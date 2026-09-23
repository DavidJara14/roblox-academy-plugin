-- EndRace: detener la cuenta regresiva — Módulo 4, Lección 2
--
-- Ubicación: Script dentro de la Part "Finish" (script.Parent).
-- Debe insertarse DESHABILITADO — "BeginRace" lo habilita cuando
-- corresponde.
--
-- CÓMO USARLO:
-- 1. Inserta primero "BeginRace" (iniciar-carrera.lua) en la Part
--    "Start".
-- 2. Selecciona "Finish" e inserta este script, renómbralo EndRace, y
--    déjalo deshabilitado (ya viene así).
--
-- Qué hace: cuando un coche (VehicleSeat) toca esta Part, calcula el
-- tiempo transcurrido desde que "BeginRace" se activó, lo imprime en
-- Output, se desactiva a sí mismo, y tras 3 segundos reactiva
-- "BeginRace" para permitir una nueva vuelta.

local RACE_TIMER_NAME = "RaceTimer"

local function redondear(n, decimales)
	decimales = decimales or 0
	local factor = 10 ^ decimales
	return math.floor(n * factor) / factor
end

local function terminarCarrera(x_part)
	if not x_part:IsA("VehicleSeat") then
		return
	end

	workspace.Finish.Transparency = 1
	workspace.Start.Transparency = 0

	local timer = game.ServerStorage:FindFirstChild(RACE_TIMER_NAME)
	if not timer then
		return
	end

	local tiempoCarrera = redondear(tick() - timer.Value, 2)
	print("La carrera ha terminado:", tiempoCarrera, "segundos")

	script.Disabled = true
	workspace.Finish:FindFirstChildOfClass("Script").Disabled = true

	task.wait(3)
	workspace.Start:FindFirstChildOfClass("Script").Disabled = false
end

script.Parent.Touched:Connect(terminarCarrera)
