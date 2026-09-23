-- Barra de salud — Módulo 2, Lección 9
--
-- Ubicación: LocalScript dentro del Frame "Healthbar" (usa
-- script.Parent), dentro de un ScreenGui en StarterGui. Usa
-- Players.LocalPlayer, exclusivo de cliente.
--
-- CÓMO USARLO:
-- 1. Crea un ScreenGui en StarterGui con un Frame "Healthbar" que
--    contenga dos Frames hijos: "Back" (rojo, de fondo) y "Front"
--    (verde, encima, mismo tamaño/posición que Back).
-- 2. Selecciona "Healthbar" e inserta este script.
--
-- Qué hace: ajusta el ancho y color de "Front" según el porcentaje de
-- salud del jugador (verde > 40%, amarillo 10-40%, rojo < 10%).

local player = game.Players.LocalPlayer
local healthFill = script.Parent.Front

local function onHealthChanged()
	local humanoid = player.Character.Humanoid
	local percent = humanoid.Health / humanoid.MaxHealth
	healthFill.Size = UDim2.new(percent, 0, 1, 0)
	if percent < 0.1 then
		healthFill.BackgroundColor3 = Color3.new(1, 0, 0)
	elseif percent < 0.4 then
		healthFill.BackgroundColor3 = Color3.new(1, 1, 0)
	else
		healthFill.BackgroundColor3 = Color3.new(0, 1, 0)
	end
end

local function onCharacterAdded(character)
	local humanoid = character:WaitForChild("Humanoid")
	humanoid.HealthChanged:Connect(onHealthChanged)
	onHealthChanged()
end

player.CharacterAdded:Connect(onCharacterAdded)
if player.Character then
	onCharacterAdded(player.Character)
end
