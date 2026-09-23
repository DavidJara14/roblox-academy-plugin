-- Aparición de un objeto al tocar una Part — Módulo 1, Lección 9
--
-- Ubicación: script independiente en Workspace (coordina un Model y
-- una Part disparadora, así que no vive dentro de ninguno de los dos).
-- Requisito: un Model en Workspace (por ejemplo, insertado desde el
-- Toolbox) nombrado exactamente SorpresaModel, y una Part disparadora en
-- Workspace nombrada exactamente SorpresaTrigger.
--
-- Qué hace: al iniciar, esconde el modelo moviéndolo a ServerStorage.
-- Cuando el jugador toca la Part disparadora, el modelo reaparece en
-- Workspace. Un Model no tiene una propiedad Transparency propia — por
-- eso, para ocultarlo o mostrarlo, se cambia su propiedad Parent en vez
-- de intentar volverlo transparente.
--
-- Nota: solo reacciona si lo que toca la Part disparadora es un
-- personaje (tiene un Humanoid).

local ServerStorage = game:GetService("ServerStorage")
local Workspace = game:GetService("Workspace")

local modelo = Workspace:WaitForChild("SorpresaModel")
modelo.Parent = ServerStorage

local function onTriggerTouched(hit)
	local character = hit.Parent
	if not (character and character:FindFirstChild("Humanoid")) then
		return
	end
	if modelo.Parent ~= Workspace then
		modelo.Parent = Workspace
	end
end

local trigger = Workspace:WaitForChild("SorpresaTrigger")
trigger.Touched:Connect(onTriggerTouched)
