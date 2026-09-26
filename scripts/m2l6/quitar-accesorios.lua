-- Quitar todos los accesorios al hacer clic — Módulo 2, Lección 6
--
-- Ubicación: dentro del propio ClickDetector (script.Parent).
--
-- CÓMO USARLO:
-- 1. Añade una Part con un ClickDetector para el botón de "quitar todo".
-- 2. Selecciona el ClickDetector e inserta este script.
--
-- Qué hace: al hacer clic, quita los accesorios equipados (gafas,
-- sombreros, etc.) del jugador que hizo clic, sin tocarle el cabello.
--
-- Nota: la diapositiva original tenía un bug — llamaba
-- Humanoid:RemoveAccessories(accl), pero ese método no acepta
-- argumentos, así que siempre quitaba TODO, incluido el cabello (el
-- cabello es técnicamente un Accessory más). Corregido abajo: se
-- recorren los accesorios uno por uno y se salta el que sea de tipo
-- Hair.

script.Parent.MouseClick:Connect(function(player)
	local humanoid = player.Character.Humanoid
	for _, accesorio in humanoid:GetAccessories() do
		if accesorio.AccessoryType ~= Enum.AccessoryType.Hair then
			accesorio:Destroy()
		end
	end
end)
