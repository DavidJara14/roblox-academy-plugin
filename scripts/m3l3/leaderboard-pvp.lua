-- Leaderboard PvP (Frag / Deaths) — Módulo 3, Lección 3
--
-- Ubicación: ServerScriptService (lógica global de PlayerAdded).
--
-- CÓMO USARLO:
-- 1. Inserta este script en ServerScriptService.
-- 2. Úsalo junto con "Pistola (disparo en red)" y "Bala: crear en el
--    servidor" — este leaderboard depende del valor "Killer" que esos
--    scripts registran vía "Daño de bala (PvP)".
--
-- Qué hace: crea, para cada jugador, dos columnas de leaderboard
-- (Frag = bajas, Deaths = muertes) y un StringValue oculto "Killer"
-- que guarda quién lo mató por última vez. Al morir, suma 1 a sus
-- Deaths y 1 al Frag de quien lo mató.

local function onPlayerJoin(player)
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player

	local frag = Instance.new("IntValue")
	frag.Name = "Frag"
	frag.Value = 0
	frag.Parent = leaderstats

	local deaths = Instance.new("IntValue")
	deaths.Name = "Deaths"
	deaths.Value = 0
	deaths.Parent = leaderstats

	local killer = Instance.new("StringValue")
	killer.Name = "Killer"
	killer.Parent = player

	player.CharacterAdded:Connect(function(character)
		local humanoid = character:WaitForChild("Humanoid")
		humanoid.Died:Connect(function()
			deaths.Value += 1
			local killerPlayer = game.Players:FindFirstChild(killer.Value)
			if killerPlayer then
				killerPlayer.leaderstats.Frag.Value += 1
			end
		end)
	end)
end

game.Players.PlayerAdded:Connect(onPlayerJoin)
