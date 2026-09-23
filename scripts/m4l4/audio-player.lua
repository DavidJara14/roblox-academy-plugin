-- AudioPlayer: módulo reutilizable de audio — Módulo 4, Lección 4
--
-- Ubicación: ModuleScript en ReplicatedStorage.
--
-- CÓMO USARLO:
-- 1. En el Explorer, selecciona el servicio "ReplicatedStorage" e
--    inserta este script directamente ahí, renómbralo AudioPlayer.
-- 2. Desde un LocalScript, haz "require" de este módulo y llama a
--    preloadAudio({...}) y luego playAudio(nombre) — ver
--    reproducir-audio.lua.
--
-- Qué hace: expone dos funciones. preloadAudio(tabla) crea un objeto
-- Sound por cada entrada nombre→assetId y los precarga. playAudio(
-- nombre) reproduce un sonido ya precargado, esperando a que termine
-- de cargar si hace falta.

local AudioPlayer = {}

local ContentProvider = game:GetService("ContentProvider")

function AudioPlayer.preloadAudio(assetTable)
	local audioAssets = {}
	for name, audioId in pairs(assetTable) do
		local sound = Instance.new("Sound")
		sound.Name = name
		sound.SoundId = "rbxassetid://" .. audioId
		sound.Parent = workspace
		table.insert(audioAssets, sound)
	end

	pcall(function()
		ContentProvider:PreloadAsync(audioAssets)
	end)
end

function AudioPlayer.playAudio(assetName)
	local audio = workspace:FindFirstChild(assetName)
	if not audio then
		warn("No se pudo encontrar elemento de audio: " .. assetName)
		return
	end
	if not audio.IsLoaded then
		audio.Loaded:Wait()
	end
	audio:Play()
end

return AudioPlayer
