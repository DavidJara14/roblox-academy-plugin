-- Conectar jugador (registra al jugador actual) — Módulo 2, Lección 8
--
-- Ubicación: dentro de la Folder "Data" (script.Parent), que debe
-- contener un ObjectValue llamado "Player".
--
-- CÓMO USARLO:
-- 1. Crea una Folder "Data" en Workspace con un ObjectValue "Player"
--    dentro.
-- 2. Selecciona la Folder "Data" e inserta este script.
--
-- Qué hace: guarda en Data.Player al jugador que entra al juego. Otros
-- scripts del sistema de combate (SeekEnemy, DemonAttack) lo usan para
-- saber a quién perseguir.
-- Nota: solo soporta un jugador a la vez (un único ObjectValue) — pensado
-- para partidas de un jugador, no multijugador real.

local function whenLoaded(player)
	script.Parent.Player.Value = player
end

game.Players.PlayerAdded:Connect(whenLoaded)
