-- Fuego intermitente por tiempo — Módulo 1, Lección 9
--
-- Ubicación: dentro de la Part de la antorcha (usa script.Parent).
-- Requisito: esa Part debe tener un efecto Fire como hijo (pestaña
-- Model > Effects > Fire) antes de insertar este script.
--
-- Qué hace: enciende el fuego 3 segundos, lo apaga 2 segundos, y repite
-- indefinidamente.

local SEGUNDOS_ENCENDIDO = 3
local SEGUNDOS_APAGADO = 2

local antorcha = script.Parent
local fuego = antorcha:WaitForChild("Fire")

while true do
	fuego.Enabled = true
	task.wait(SEGUNDOS_ENCENDIDO)
	fuego.Enabled = false
	task.wait(SEGUNDOS_APAGADO)
end
