-- Punto de control (Checkpoint) — Módulo 1, Lección 4
--
-- Ubicación: dentro de la Part que actúa como checkpoint (usa script.Parent).
-- Requisito: crea una Part en el lugar del mapa donde quieras el checkpoint.
--
-- Qué hace: cuando el personaje de un jugador toca esta Part, guarda su
-- posición en ServerStorage. La próxima vez que ese jugador reaparezca
-- (por ejemplo, tras caer o morir), su personaje se teletransporta al
-- último checkpoint que tocó, en vez de al punto de aparición original.

local checkpointPart = script.Parent

local function onCheckpointTouched(hit)
	local character = hit.Parent
	local player = game.Players:GetPlayerFromCharacter(character)
	if not player then
		return
	end

	local checkpointData = game.ServerStorage:FindFirstChild("CheckpointData")
	if not checkpointData then
		checkpointData = Instance.new("Model")
		checkpointData.Name = "CheckpointData"
		checkpointData.Parent = game.ServerStorage
	end

	local playerCheckpoint = checkpointData:FindFirstChild(tostring(player.UserId))
	if not playerCheckpoint then
		playerCheckpoint = Instance.new("ObjectValue")
		playerCheckpoint.Name = tostring(player.UserId)
		playerCheckpoint.Parent = checkpointData

		player.CharacterAdded:Connect(function(character)
			local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
			local savedCheckpoint = playerCheckpoint.Value
			if savedCheckpoint then
				humanoidRootPart.CFrame = savedCheckpoint.CFrame + Vector3.new(0, 4, 0)
			end
		end)
	end

	playerCheckpoint.Value = checkpointPart
end

checkpointPart.Touched:Connect(onCheckpointTouched)
