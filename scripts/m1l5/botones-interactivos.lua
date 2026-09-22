-- Botones interactivos (Material + Color + Transparencia) — Módulo 1, Lección 5
--
-- Ubicación: ServerScriptService.
-- Requisito: crea 3 Parts en Workspace y renómbralas exactamente
-- Button1, Button2 y Button3.
--
-- Qué hace: al tocar cada botón, cambia su Material, su BrickColor y
-- (en el caso de Button1) su Transparency. Cada botón usa su propia
-- función para no repetir el error típico de esta lección: si dos
-- botones comparten el nombre de función, solo el último se conecta
-- de verdad al evento Touched del otro.

local Workspace = game:GetService("Workspace")

local function onButton1Touched()
	local button1 = Workspace:FindFirstChild("Button1")
	if not button1 then
		return
	end
	button1.Material = Enum.Material.Neon
	button1.BrickColor = BrickColor.new("Lime green")
	button1.Transparency = 0.5
end

local function onButton2Touched()
	local button2 = Workspace:FindFirstChild("Button2")
	if not button2 then
		return
	end
	button2.Material = Enum.Material.Neon
	button2.BrickColor = BrickColor.new(1020)
end

local function onButton3Touched()
	local button3 = Workspace:FindFirstChild("Button3")
	if not button3 then
		return
	end
	button3.Material = Enum.Material.Neon
	button3.BrickColor = BrickColor.new("Bright blue")
end

local button1 = Workspace:WaitForChild("Button1")
local button2 = Workspace:WaitForChild("Button2")
local button3 = Workspace:WaitForChild("Button3")

button1.Touched:Connect(onButton1Touched)
button2.Touched:Connect(onButton2Touched)
button3.Touched:Connect(onButton3Touched)
