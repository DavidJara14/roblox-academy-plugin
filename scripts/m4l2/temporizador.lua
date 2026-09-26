-- Timer: mostrar el tiempo de carrera en pantalla — Módulo 4, Lección 2
--
-- Ubicación: LocalScript dentro del ScreenGui del temporizador
-- (script.Parent), que debe contener un Frame con un TextLabel.
--
-- CÓMO USARLO:
-- 1. Inserta primero "BeginRace" (en Start) y "EndRace" (en Finish,
--    deshabilitado) — ver iniciar-carrera.lua / terminar-carrera.lua.
-- 2. Crea un ScreenGui con Frame > TextLabel para mostrar el tiempo.
-- 3. Selecciona el ScreenGui e inserta este script.
--
-- Qué hace: mientras la carrera está en curso (BeginRace deshabilitado
-- y EndRace todavía habilitado), actualiza el TextLabel con el tiempo
-- transcurrido en vivo.

local function redondear(n, decimales)
	decimales = decimales or 0
	local factor = 10 ^ decimales
	return math.floor(n * factor) / factor
end

-- WaitForChild aquí sí es necesario: este LocalScript lee estos objetos
-- de Workspace apenas arranca (no dentro de un evento), y el contenido
-- de Workspace tarda un instante en replicarse del servidor al
-- cliente — sin esto, a veces el script corre antes de que Start/
-- Finish hayan terminado de llegar.
local debounce = true
local beginRace = game.Workspace:WaitForChild("Start"):WaitForChild("BeginRace")
local endRace = game.Workspace:WaitForChild("Finish"):WaitForChild("EndRace")
local textLabel = script.Parent.TextLabel

while true do
	if beginRace.Disabled and debounce then
		debounce = false
		local timeStart = tick()
		local corriendo = true
		while corriendo do
			local tiempo = redondear(tick() - timeStart, 2)
			textLabel.Text = "Time: " .. tostring(tiempo)
			if endRace.Disabled then
				corriendo = false
				task.wait(5)
				debounce = true
			end
			task.wait()
		end
	end
	task.wait()
end
