-- Quitar todos los accesorios al hacer clic — Módulo 2, Lección 6
--
-- Ubicación: dentro del propio ClickDetector (script.Parent).
--
-- CÓMO USARLO:
-- 1. Añade una Part con un ClickDetector para el botón de "quitar todo".
-- 2. Selecciona el ClickDetector e inserta este script.
--
-- Qué hace: al hacer clic, quita TODOS los accesorios equipados del
-- jugador que hizo clic.
--
-- Nota: la diapositiva original tenía un bug — llamaba
-- Humanoid:RemoveAccessories(accl), pero ese método no acepta
-- argumentos (siempre quita todo). Corregido abajo.

script.Parent.MouseClick:Connect(function(player)
	player.Character.Humanoid:RemoveAccessories()
end)
