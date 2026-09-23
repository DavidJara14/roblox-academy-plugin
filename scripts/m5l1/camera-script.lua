-- CameraScript: cámara cenital que sigue a la nave — Módulo 5, Lección 1
--
-- Ubicación: LocalScript en StarterPlayer > StarterPlayerScripts.
--
-- CÓMO USARLO:
-- 1. Construye tu personaje custom (nave) con una Part "HumanoidRootPart"
--    (ver M5L1: modelo StarterCharacter movido a StarterPlayer).
-- 2. Selecciona StarterPlayerScripts e inserta este script.
-- 3. Presiona Play.
--
-- Qué hace: pone la cámara en modo Scriptable y la mantiene mirando
-- hacia abajo (vista cenital), siguiendo la posición de la nave del
-- jugador cada frame.

local RunService = game:GetService("RunService")

local camera = workspace.CurrentCamera
local player = game.Players.LocalPlayer
local CAMERA_OFFSET = Vector3.new(-1, 60, 0)
camera.CameraType = Enum.CameraType.Scriptable

local function onRenderStep()
	if player.Character then
		local playerPosition = player.Character.HumanoidRootPart.Position
		local cameraPosition = playerPosition + CAMERA_OFFSET
		camera.CoordinateFrame = CFrame.new(cameraPosition, playerPosition)
	end
end

RunService:BindToRenderStep("Camera", Enum.RenderPriority.Camera.Value, onRenderStep)
