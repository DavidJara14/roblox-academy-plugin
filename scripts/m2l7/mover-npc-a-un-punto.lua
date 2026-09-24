-- Mover NPC a un punto (una vez) — Módulo 2, Lección 7
--
-- Ubicación: dentro del Model del NPC (script.Parent).
--
-- CÓMO USARLO:
-- 1. Crea un Model anclado en Workspace llamado GreenFlag, con
--    PrimaryPart definido (agrupa las Parts de la bandera y fija cuál
--    es la principal).
-- 2. Selecciona el Model del NPC (debe tener Humanoid, y su
--    HumanoidRootPart con Anchor desactivado) e inserta este script.
--
-- Qué hace: mueve al NPC hacia GreenFlag una sola vez, al insertarse.

local npc = script.Parent
local humanoid = npc.Humanoid
local destino = game.Workspace.GreenFlag

humanoid:MoveTo(destino.PrimaryPart.Position)
