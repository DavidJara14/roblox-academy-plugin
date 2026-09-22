-- Fuego intermitente por tiempo — Módulo 1, Lección 9
--
-- Ubicación: ServerScriptService.
-- Requisito: una Part en Workspace nombrada exactamente Torch, con un
-- efecto Fire como hijo (pestaña Model > Effects > Fire).
--
-- Qué hace: enciende el fuego 3 segundos, lo apaga 2 segundos, y repite
-- indefinidamente.

local Workspace = game:GetService("Workspace")

local SEGUNDOS_ENCENDIDO = 3
local SEGUNDOS_APAGADO = 2

local fire = Workspace:WaitForChild("Torch"):WaitForChild("Fire")

while true do
	fire.Enabled = true
	task.wait(SEGUNDOS_ENCENDIDO)
	fire.Enabled = false
	task.wait(SEGUNDOS_APAGADO)
end
