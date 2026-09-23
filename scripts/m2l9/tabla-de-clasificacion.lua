-- Leaderboard (tabla de clasificación) — Módulo 2, Lección 9
--
-- Ubicación: ServerScriptService (lógica global de PlayerAdded).
--
-- CÓMO USARLO:
-- 1. Inserta este script en ServerScriptService.
-- 2. (Opcional) si ya usas conectar-jugador.lua de M2L8 para
--    Data.Player, puedes borrar esa línea de aquí para no duplicarla.
--
-- Qué hace: crea, para cada jugador que entra, una carpeta leaderstats
-- con dos columnas (Coins, Exp) que Roblox muestra automáticamente en
-- la tabla de jugadores nativa.

local Players = game:GetService("Players")

local function leaderboardSetup(player)
	game.Workspace.Data.Player.Value = player

	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player

	local coins = Instance.new("IntValue")
	coins.Name = "Coins"
	coins.Value = 0
	coins.Parent = leaderstats

	local exp = Instance.new("IntValue")
	exp.Name = "Exp"
	exp.Value = 0
	exp.Parent = leaderstats
end

Players.PlayerAdded:Connect(leaderboardSetup)
