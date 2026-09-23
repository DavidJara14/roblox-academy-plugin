-- Cambiar Material al tocar — Módulo 1, Lección 5
--
-- Ubicación: dentro de la Part que quieras convertir en botón (usa
-- script.Parent). Funciona con cualquier Part, no necesita un nombre
-- específico ni que existan otras Parts.
--
-- Qué hace: al tocar esta Part, cambia su Material a Neon.

local NUEVO_MATERIAL = Enum.Material.Neon

local boton = script.Parent

local function onBotonTocado()
	boton.Material = NUEVO_MATERIAL
end

boton.Touched:Connect(onBotonTocado)
