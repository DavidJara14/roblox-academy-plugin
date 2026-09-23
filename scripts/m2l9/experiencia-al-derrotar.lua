-- Experiencia al derrotar un demonio — Módulo 2, Lección 9
--
-- Ubicación: dentro del Model "Demon" (script.Parent).
-- Requiere: leaderstats.Exp (ver tabla-de-clasificacion.lua) y el
-- Humanoid del Demon renombrado a "DemonType" (M2L8).
--
-- CÓMO USARLO:
-- 1. Selecciona el Model "Demon" (en ServerStorage, la plantilla) e
--    inserta este script.
--
-- Qué hace: cuando la salud del demonio llega a 0, suma 1 a
-- leaderstats.Exp del jugador actual y destruye al demonio.

local demonHumanoid = script.Parent.DemonType

demonHumanoid.HealthChanged:Connect(function(health)
	if health <= 0 then
		local exp = game.Workspace.Data.Player.Value.leaderstats.Exp
		exp.Value += 1
		script.Parent:Destroy()
	end
end)
