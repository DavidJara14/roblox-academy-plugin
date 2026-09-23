-- Luz de calle automática (según la hora) — Módulo 1, Lección 7
--
-- Ubicación: dentro del contenedor de la farola (usa script.Parent),
-- que debe tener una Part llamada exactamente "Sphere" como hijo
-- directo, con un SpotLight dentro de esa Sphere.
--
-- Qué hace: incluye su propio ciclo día/noche (igual que
-- "ciclo-dia-noche.lua") y además enciende el SpotLight de la farola
-- entre las 16:00 y las 6:00, apagándolo el resto del día.
--
-- ⚠️ Este script YA INCLUYE el ciclo de ClockTime — no lo actives junto
-- con "ciclo-dia-noche.lua" en el mismo lugar, o ambos competirán por
-- la misma propiedad Lighting.ClockTime.
--
-- Para experimentar: cambia HORA_ENCENDIDO/HORA_APAGADO para que la luz
-- se encienda en otro momento del día, o INCREMENTO_POR_TICK para que
-- el ciclo sea más rápido o más lento. En las propiedades del SpotLight
-- prueba también Brightness, Range y Color.

local Lighting = game:GetService("Lighting")

local HORA_ENCENDIDO = 16
local HORA_APAGADO = 6
local INCREMENTO_POR_TICK = 0.1

local spotLight = script.Parent.Sphere.SpotLight

local horaDelDia = 0

while true do
	Lighting.ClockTime = horaDelDia
	horaDelDia += INCREMENTO_POR_TICK
	if horaDelDia > 24 then
		horaDelDia = 0
	end

	local esDeNoche = horaDelDia > HORA_ENCENDIDO or horaDelDia < HORA_APAGADO
	spotLight.Enabled = esDeNoche

	task.wait()
end
