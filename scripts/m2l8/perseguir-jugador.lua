-- SeekEnemy: perseguir al jugador con Pathfinding — Módulo 2, Lección 8
--
-- Ubicación: dentro del Model "Demon" (script.Parent), clonado por
-- generador-de-enemigos.lua.
--
-- CÓMO USARLO:
-- 1. En la plantilla "Demon" (en ServerStorage), renombra su Humanoid a
--    DemonType.
-- 2. Crea un IntValue "WalkSpeed" hermano de Field/SpawnPoint (bajo el
--    Model "Spawner").
-- 3. Selecciona el Model "Demon" e inserta este script.
--
-- Qué hace: si el jugador está a menos de 50 studs, calcula un camino
-- (PathfindingService) y lo persigue punto por punto; si no hay camino,
-- se mueve a un punto aleatorio cerca del spawn; si el jugador está
-- lejos, vuelve al punto de spawn.

local DISTANCIA_PERSECUCION = 50

local demonHumanoid = script.Parent.DemonType

while true do
	local jugadorActual = game.Workspace.Data.Player.Value
	local destino = jugadorActual.Character.HumanoidRootPart.Position
	local distancia = (demonHumanoid.RootPart.Position - destino).Magnitude

	if distancia < DISTANCIA_PERSECUCION then
		demonHumanoid.WalkSpeed = script.Parent.Parent.WalkSpeed.Value

		local path = game.PathfindingService:CreatePath({
			AgentRadius = 2,
			AgentHeight = 5,
			AgentCanJump = false,
		})
		path:ComputeAsync(demonHumanoid.RootPart.Position, destino)

		if path.Status == Enum.PathStatus.Success then
			local waypoints = path:GetWaypoints()
			for i = 1, #waypoints do
				demonHumanoid:MoveTo(waypoints[i].Position)
				demonHumanoid.MoveToFinished:Wait()
			end
		else
			local puntoSpawn = game.Workspace.Spawners.Spawner.SpawnPoint.Position
			demonHumanoid:MoveTo(puntoSpawn + Vector3.new(math.random(10), 0, math.random(10)))
			demonHumanoid.MoveToFinished:Wait()
		end
	else
		demonHumanoid:MoveTo(game.Workspace.Spawners.Spawner.SpawnPoint.Position)
	end

	task.wait(0.1)
end
