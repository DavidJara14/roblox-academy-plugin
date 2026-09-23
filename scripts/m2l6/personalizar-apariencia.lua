-- Personalizar la apariencia del jugador al entrar — Módulo 2, Lección 6
--
-- Ubicación: ServerScriptService (lógica global de PlayerAdded, no atada
-- a ningún objeto — uno de los pocos casos legítimos para esta carpeta).
--
-- CÓMO USARLO:
-- 1. Inserta este script en ServerScriptService (selecciónalo antes de
--    pulsar Insertar).
-- 2. Edita los valores dentro de HumanoidDescription según quieras.
--
-- Qué hace: cuando un jugador entra, le asigna una apariencia
-- predefinida (sombrero, pelo, cara, camiseta, color de piel) antes de
-- generar su personaje.

game.Players.CharacterAutoLoads = false

local function onPlayerAdded(player)
	local humanoidDescription = Instance.new("HumanoidDescription")
	humanoidDescription.HatAccessory = 24487251
	humanoidDescription.HairAccessory = 63690008
	humanoidDescription.Face = 86487700
	humanoidDescription.GraphicTShirt = 1711661
	humanoidDescription.HeadColor = Color3.new(0, 1, 0)
	humanoidDescription.LeftArmColor = Color3.new(0, 1, 0)
	humanoidDescription.LeftLegColor = Color3.new(0, 1, 0)
	humanoidDescription.RightArmColor = Color3.new(0, 1, 0)
	humanoidDescription.RightLegColor = Color3.new(0, 1, 0)
	player:LoadCharacterWithHumanoidDescription(humanoidDescription)
end

game.Players.PlayerAdded:Connect(onPlayerAdded)
