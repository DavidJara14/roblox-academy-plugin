-- Detección de proximidad y generación de enemigos — Módulo 2, Lección 8
--
-- Ubicación: dentro de la Part "Field" (script.Parent).
--
-- CÓMO USARLO (requiere esta jerarquía exacta en Workspace):
-- 1. Spawners (Folder)
--      Spawner (Model)
--        Field (Part, material ForceField) <- aquí va este script
--        SpawnPoint (Part, con efecto Fire desactivado)
--      Quantity (IntValue, hijo de Spawners, empieza en 0)
-- 2. NPC (Folder vacía, donde aparecerán los clones)
-- 3. Data/Player (ver conectar-jugador.lua, ya debe existir y estar
--    poblado)
-- 4. ServerStorage debe tener un Model "Demon" (la plantilla de enemigo)
-- 5. Selecciona la Part "Field" e inserta este script.
--
-- Qué hace: cuando un jugador se acerca a menos de 50 studs, enciende el
-- fuego del SpawnPoint y empieza a clonar "Demon" (hasta 10 a la vez)
-- mientras el jugador siga cerca.

local DISTANCIA_ACTIVACION = 50
local MAXIMO_ENEMIGOS = 10

local esperandoJugador = true
local distancia = 0

while esperandoJugador do
	for _, player in pairs(game.Players:GetPlayers()) do
		distancia = player:DistanceFromCharacter(script.Parent.Position)
		if distancia > 0 and distancia < DISTANCIA_ACTIVACION then
			esperandoJugador = false
			script.Parent.Parent.SpawnPoint.Fire.Enabled = true
			script.Parent.Parent.SpawnPoint.Fire.Size = 100
		end
	end
	task.wait(1)
end

task.wait(2)

local cantidad = script.Parent.Parent.Parent.Quantity
while cantidad.Value < MAXIMO_ENEMIGOS do
	if distancia < DISTANCIA_ACTIVACION then
		local demonio = game.ServerStorage.Demon:Clone()
		demonio.Parent = game.Workspace.NPC
		demonio:MoveTo(script.Parent.Parent.SpawnPoint.Position)
		cantidad.Value += 1
	end
	local destino = game.Workspace.Data.Player.Value.Character.HumanoidRootPart.Position
	distancia = (destino - script.Parent.Position).Magnitude
	task.wait(5)
end
