-- dmg: plantilla de daño de bala a un objetivo — Módulo 3, Lección 2
--
-- Ubicación: plantilla deshabilitada en ServerStorage; "Arma: dañar a
-- un objetivo" la clona dentro de cada bala que dispara.
--
-- ⚠️ IMPORTANTE: el nombre de este Script debe ser exactamente "dmg" —
-- el arma lo busca por ese nombre exacto para clonarlo.
--
-- CÓMO USARLO:
-- 1. En el Explorer, selecciona el servicio "ServerStorage" e inserta
--    este script directamente ahí (no dentro de ninguna Part).
-- 2. Déjalo deshabilitado (Disabled = true, ya viene así) — es solo la
--    plantilla que otro script clona y habilita.
--
-- Qué hace: cuando la bala en la que fue clonado toca a un Humanoid,
-- le hace 30 de daño y se autodestruye.

local function onBulletTouched(hit)
	local humanoid = hit.Parent and hit.Parent:FindFirstChild("Humanoid")
	if not humanoid then
		return
	end
	humanoid:TakeDamage(30)
	script.Parent:Destroy()
end

script.Parent.Touched:Connect(onBulletTouched)
