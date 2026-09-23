-- Patrulla infinita entre dos puntos — Módulo 2, Lección 7
--
-- Ubicación: dentro del Model del NPC (script.Parent).
--
-- CÓMO USARLO:
-- 1. Crea dos Models anclados en Workspace, GreenFlag y RedFlag, cada
--    uno con PrimaryPart definido.
-- 2. Selecciona el Model del NPC (Humanoid + HumanoidRootPart sin
--    Anchor) e inserta este script.
--
-- Qué hace: el NPC camina indefinidamente entre GreenFlag y RedFlag,
-- esperando PATROL_DELAY segundos en cada punto antes de seguir.

local PATROL_DELAY = 2

local npc = script.Parent
local humanoid = npc:WaitForChild("Humanoid")
local pointA = game.Workspace:WaitForChild("GreenFlag")
local pointB = game.Workspace:WaitForChild("RedFlag")
local siguienteDestino = pointA

while task.wait(PATROL_DELAY) do
	humanoid:MoveTo(siguienteDestino.PrimaryPart.Position)
	humanoid.MoveToFinished:Wait()
	if siguienteDestino == pointA then
		siguienteDestino = pointB
	else
		siguienteDestino = pointA
	end
end
