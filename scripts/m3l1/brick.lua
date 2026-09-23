-- Brick: crear ladrillos al hacer clic — Módulo 3, Lección 1
--
-- Ubicación: LocalScript dentro de la Tool "Brick" (script.Parent).
--
-- CÓMO USARLO:
-- 1. Crea una Tool en StarterPack, renómbrala "Brick" y asegúrate de que
--    tenga una Part llamada "Handle" (obligatorio para que aparezca en
--    la mano del jugador).
-- 2. Selecciona la Tool "Brick" e inserta este script.
-- 3. Presiona Play, equipa la herramienta y haz clic.
--
-- Qué hace: cada clic crea un ladrillo de color aleatorio junto al
-- jugador que la usa.
--
-- Nota: al ser LocalScript, el ladrillo creado solo lo ve el jugador
-- que lo generó — no se replica a los demás clientes. Es una
-- limitación de diseño de esta lección (se resuelve en M3L3 con
-- RemoteEvent), no un error.

local tool = script.Parent

local function crearLadrillo()
	local character = game.Players.LocalPlayer.Character
	local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
	if not humanoidRootPart then
		return
	end

	local brick = Instance.new("Part")
	brick.Position = humanoidRootPart.Position + Vector3.new(10, 0, 0)
	brick.BrickColor = BrickColor.Random()
	brick.Parent = workspace
end

tool.Activated:Connect(crearLadrillo)
