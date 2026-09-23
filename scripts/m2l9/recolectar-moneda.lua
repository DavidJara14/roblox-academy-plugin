-- CoinCollectScript: recolectar una moneda — Módulo 2, Lección 9
--
-- Ubicación: dentro de la Part "Coin" (script.Parent), como plantilla
-- deshabilitada; generar-monedas.lua la clona (habilitada) en cada
-- moneda que crea.
--
-- ⚠️ IMPORTANTE: el nombre de este Script debe ser exactamente
-- "CoinCollectScript" — generar-monedas.lua lo busca por ese nombre.
--
-- CÓMO USARLO:
-- 1. Selecciona la Part "Coin" e inserta este script.
-- 2. Deshabilítalo (propiedad Disabled = true) — es solo la plantilla.
--
-- Qué hace: cuando un personaje toca la moneda, suma 1 a
-- leaderstats.Coins del jugador y destruye la moneda.

script.Parent.Touched:Connect(function(hit)
	local humanoid = hit.Parent and hit.Parent:FindFirstChild("Humanoid")
	if not humanoid then
		return
	end
	local player = game.Players:GetPlayerFromCharacter(hit.Parent)
	if not player then
		return
	end
	player.leaderstats.Coins.Value += 1
	script.Parent:Destroy()
end)
