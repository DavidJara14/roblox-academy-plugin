-- Bala: crear en el servidor — Módulo 3, Lección 3
--
-- Ubicación: ServerScriptService. Escucha ReplicatedStorage.ShotEvent
-- (RemoteEvent), disparado por "Pistola (disparo en red)".
--
-- CÓMO USARLO:
-- 1. Inserta este script en ServerScriptService.
-- 2. Requiere el RemoteEvent "ShotEvent" en ReplicatedStorage y la
--    plantilla "Daño de bala (PvP)" (GunDamage) deshabilitada en
--    ServerStorage.
--
-- Qué hace: cuando un cliente dispara (evento ShotEvent), crea la bala
-- físicamente en el servidor, le clona el script de daño, la lanza
-- hacia donde apuntaba el mouse, y la autodestruye tras un instante.
--
-- Nota de seguridad: este evento confía en la posición del arma y del
-- mouse que envía el cliente, sin validarlas — un cliente modificado
-- podría enviar coordenadas falsas para disparar desde cualquier
-- lugar. Aceptable para el nivel del curso, vale la pena mencionarlo
-- si se habla de buenas prácticas de seguridad más adelante.
--
-- Corrección sobre el script original: el humo y el fuego se creaban
-- como hijos de "bullet.Parent" (el Scope del arma) en vez de la bala,
-- y la bala se dejaba anidada dentro del arma del jugador en vez de
-- volar libremente en Workspace. Aquí la bala se parenta a Workspace y
-- los efectos se parentan a la propia bala.

-- WaitForChild aquí sí es necesario: el RemoteEvent puede no haber
-- replicado todavía cuando este script arranca.
local remoteEvent = game.ReplicatedStorage:WaitForChild("ShotEvent")

local BULLET_SPEED = 800

remoteEvent.OnServerEvent:Connect(function(player, gunPos, mousePos)
	local bullet = Instance.new("Part")
	bullet.Name = "Bullet"
	bullet.Shape = Enum.PartType.Ball
	bullet.Size = Vector3.new(0.4, 0.4, 0.4)
	bullet.BrickColor = BrickColor.new("Gold")
	bullet.CFrame = CFrame.new(gunPos, mousePos)

	local smoke = Instance.new("Smoke")
	smoke.Parent = bullet

	local fire = Instance.new("Fire")
	fire.Parent = bullet

	local damageScript = game.ServerStorage:FindFirstChild("GunDamage"):Clone()
	damageScript.Disabled = false
	damageScript.Parent = bullet

	local attacker = Instance.new("StringValue")
	attacker.Name = "Attacker"
	attacker.Value = player.Name
	attacker.Parent = bullet

	bullet.Parent = workspace
	bullet.AssemblyLinearVelocity = bullet.CFrame.LookVector * BULLET_SPEED

	game.Debris:AddItem(bullet, 1000 / BULLET_SPEED)
end)
