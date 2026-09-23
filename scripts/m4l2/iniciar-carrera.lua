-- BeginRace: iniciar la cuenta regresiva — Módulo 4, Lección 2
--
-- Ubicación: Script dentro de la Part "Start" (script.Parent).
--
-- CÓMO USARLO:
-- 1. Crea dos Parts ancladas en la pista, "Start" y "Finish", con
--    CanCollide = false (para que el coche las atraviese).
-- 2. Selecciona "Start" e inserta este script, y renómbralo BeginRace.
-- 3. Inserta también "EndRace" (terminar-carrera.lua) en "Finish",
--    deshabilitado.
--
-- Qué hace: cuando un coche (VehicleSeat) toca esta Part, guarda la
-- hora de inicio, se desactiva a sí mismo, y activa el script de
-- "Finish" para que pueda detectar la llegada.
--
-- Bug corregido del original: cada vez que se tocaba "Start" se creaba
-- un NumberValue NUEVO en ServerStorage en vez de reemplazar el
-- anterior. Como "EndRace" busca ese valor con FindFirstChild (que
-- devuelve el primero que existe, no el último), a partir de la
-- segunda vuelta el tiempo se calculaba contra la hora de la primera
-- carrera. Aquí se destruye el valor anterior antes de crear uno
-- nuevo.

local RACE_TIMER_NAME = "RaceTimer"

local function iniciarCarrera(x_part)
	if not x_part:IsA("VehicleSeat") then
		return
	end

	workspace.Finish.Transparency = 0
	workspace.Start.Transparency = 1

	local anterior = game.ServerStorage:FindFirstChild(RACE_TIMER_NAME)
	if anterior then
		anterior:Destroy()
	end

	local timer = Instance.new("NumberValue")
	timer.Name = RACE_TIMER_NAME
	timer.Value = tick()
	timer.Parent = game.ServerStorage

	print("La carrera ha comenzado")

	script.Disabled = true
	workspace.Finish:FindFirstChildOfClass("Script").Disabled = false
end

script.Parent.Touched:Connect(iniciarCarrera)
