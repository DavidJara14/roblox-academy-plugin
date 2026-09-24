-- Equipar un accesorio al hacer clic — Módulo 2, Lección 6
--
-- Ubicación: dentro del propio ClickDetector (no de la Part) — usa
-- script.Parent para su evento MouseClick.
-- Requiere: "definir-accesorios-equipables.lua" ya insertado y corrido.
--
-- CÓMO USARLO:
-- 1. Añade un ClickDetector a la Part que activará el accesorio.
-- 2. Cambia NOMBRE_ACCESORIO por el nombre exacto definido en
--    definir-accesorios-equipables.lua (ej. "HPGlasses", "lPHat").
-- 3. Selecciona el ClickDetector e inserta este script (uno por
--    accesorio: repite con distinto NOMBRE_ACCESORIO para cada uno).
--
-- Qué hace: al hacer clic, clona el accesorio y lo añade al Humanoid
-- del jugador que hizo clic.

local NOMBRE_ACCESORIO = "HPGlasses"

-- WaitForChild aquí sí es necesario: el accesorio lo crea en tiempo de
-- ejecución "definir-accesorios-equipables.lua", puede que todavía no
-- exista cuando este script arranca.
local accesorio = game.ReplicatedStorage:WaitForChild(NOMBRE_ACCESORIO)

script.Parent.MouseClick:Connect(function(player)
	player.Character.Humanoid:AddAccessory(accesorio:Clone())
end)
