-- Daño de bala (PvP) — Módulo 3, Lección 3
--
-- Ubicación: plantilla deshabilitada en ServerStorage; "Bala: crear en
-- el servidor" la clona dentro de cada bala que crea.
--
-- ⚠️ IMPORTANTE: el nombre de este Script debe ser exactamente
-- "GunDamage" — "Bala: crear en el servidor" lo busca por ese nombre.
--
-- CÓMO USARLO:
-- 1. En el Explorer, selecciona el servicio "ServerStorage" e inserta
--    este script directamente ahí (no dentro de ninguna Part).
-- 2. Déjalo deshabilitado (Disabled = true, ya viene así) — es solo la
--    plantilla que "Bala: crear en el servidor" clona y habilita.
--
-- Qué hace: cuando la bala en la que fue clonado toca a un Humanoid,
-- le hace 10 de daño y, si la víctima no es quien disparó, actualiza
-- su valor "Killer" para que "Leaderboard PvP" le atribuya la baja a
-- quien disparó.

local bullet = script.Parent

local function onBulletTouched(hit)
	local humanoid = hit.Parent and hit.Parent:FindFirstChild("Humanoid")
	if not humanoid then
		return
	end

	humanoid:TakeDamage(10)

	local victim = game.Players:GetPlayerFromCharacter(humanoid.Parent)
	local attackerName = bullet:FindFirstChild("Attacker") and bullet.Attacker.Value
	if victim and attackerName and victim.Name ~= attackerName then
		local killerTag = victim:FindFirstChild("Killer")
		if killerTag then
			killerTag.Value = attackerName
		end
	end

	bullet:Destroy()
end

bullet.Touched:Connect(onBulletTouched)
