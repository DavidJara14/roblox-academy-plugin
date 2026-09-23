-- Cargar y reproducir música de fondo — Módulo 4, Lección 4
--
-- Ubicación: LocalScript en StarterPlayerScripts.
--
-- CÓMO USARLO:
-- 1. Inserta primero "AudioPlayer" (audio-player.lua) en
--    ReplicatedStorage.
-- 2. Elige una canción del Toolbox de audio y copia su assetId.
-- 3. Inserta este script en StarterPlayerScripts y cambia AUDIO_ID
--    (y opcionalmente NOMBRE_CANCION) por los tuyos.
-- 4. Presiona Play: la música se precarga y se reproduce.
--
-- Qué hace: cada jugador precarga y reproduce, al entrar, la canción
-- indicada por AUDIO_ID.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AudioPlayer = require(ReplicatedStorage:WaitForChild("AudioPlayer"))

local NOMBRE_CANCION = "My music"
local AUDIO_ID = 1839029458 -- Cambia este id por el de tu canción del Toolbox

AudioPlayer.preloadAudio({
	[NOMBRE_CANCION] = AUDIO_ID,
})

AudioPlayer.playAudio(NOMBRE_CANCION)
