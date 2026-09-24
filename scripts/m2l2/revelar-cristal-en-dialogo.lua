-- Revelar un objeto oculto según la elección de diálogo — Módulo 2, Lección 2
--
-- Ubicación: LocalScript en StarterPlayerScripts (el sistema Dialog necesita
-- una instancia por jugador; un Script normal no reacciona igual aquí).
--
-- CÓMO USARLO:
-- 1. Crea un NPC en Workspace llamado QuestNPC, con un Dialog en su Head.
-- 2. Dentro del Dialog, crea DialogChoice1 y DialogChoice2; dentro de
--    DialogChoice2, anida un DialogChoice3 (rama secundaria).
-- 3. Crea un Model en Workspace llamado Crystal.
-- 4. Inserta este script (se coloca en StarterPlayerScripts).
--
-- Qué hace: esconde el Crystal al iniciar (lo mueve a ServerStorage) y lo
-- revela cuando el jugador elige la rama DialogChoice2 > DialogChoice3.

local crystal = game.Workspace.Crystal
crystal.Parent = game.ServerStorage

local npc = game.Workspace.QuestNPC
local dialog = npc.Head.Dialog

local function onDialogChoiceSelected(player, choice)
	if choice == dialog.DialogChoice1 then
		print("Dialogue 1 running")
	elseif choice == dialog.DialogChoice2 then
		print("Dialogue 2 running")
	elseif choice == dialog.DialogChoice2.DialogChoice3 then
		crystal.Parent = game.Workspace
		print("Take the crystal")
	end
end

dialog.DialogChoiceSelected:Connect(onDialogChoiceSelected)
