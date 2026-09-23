-- Pistola (disparo en red) — Módulo 3, Lección 3
--
-- Ubicación: LocalScript dentro de la Tool "Gun" (script.Parent).
--
-- CÓMO USARLO:
-- 1. Construye la Tool "Gun" (Handle + Base + Scope, con Weld,
--    CanCollide=false en Scope), movida a StarterPack.
-- 2. Crea un RemoteEvent llamado "ShotEvent" en ReplicatedStorage.
-- 3. Selecciona la Tool "Gun" e inserta este script.
-- 4. Inserta también "Bala: crear en el servidor" (ServerScriptService)
--    y "Daño de bala (PvP)" (plantilla en ServerStorage) — sin esos
--    dos, el disparo no hace nada.
-- 5. Presiona Play con al menos 2 jugadores simulados para ver el
--    disparo replicado en ambos clientes.
--
-- Qué hace: al equipar el arma, pone la cámara en primera persona; al
-- hacer clic, avisa al servidor (vía RemoteEvent) de dónde está el
-- arma y hacia dónde apunta el mouse, con un segundo de cooldown entre
-- disparos; al soltar el arma, vuelve a la cámara normal.
--
-- Esta es la versión multijugador real del arma: reemplaza por
-- completo a "Arma básica" / "Arma: dañar a un objetivo" de M3L1/M3L2
-- (esas dos son de un solo jugador). No las uses juntas.
--
-- Nota: el original usaba "mouse.Hit.p" (propiedad de CFrame obsoleta);
-- aquí se usa "mouse.Hit.Position", su equivalente actual.

local gun = script.Parent
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local remoteEvent = ReplicatedStorage:WaitForChild("ShotEvent")

local RELOAD_TIME = 1
local reload = false

local player = game.Players.LocalPlayer

gun.Equipped:Connect(function(mouse)
	player.CameraMode = Enum.CameraMode.LockFirstPerson

	mouse.Button1Down:Connect(function()
		if reload then
			return
		end
		reload = true
		remoteEvent:FireServer(gun.Scope.Position, mouse.Hit.Position)
		task.wait(RELOAD_TIME)
		reload = false
	end)
end)

gun.Unequipped:Connect(function()
	player.CameraMode = Enum.CameraMode.Classic
end)
