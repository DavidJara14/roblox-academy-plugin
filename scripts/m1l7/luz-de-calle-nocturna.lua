-- Luz de calle automática (según la hora) — Módulo 1, Lección 7
--
-- Ubicación: script independiente en Workspace (controla Lighting
-- globalmente además de la farola, así que no vive dentro de ella).
-- Requisito: una Part en Workspace nombrada exactamente Sphere, con un
-- SpotLight como hijo (la farola construida en la lección: Block +
-- Cylinder + Sphere, con el SpotLight adjunto a la esfera).
--
-- Qué hace: incluye su propio ciclo día/noche (igual que
-- "ciclo-dia-noche.lua") y además enciende el SpotLight de la farola
-- entre las 16:00 y las 6:00, apagándolo el resto del día.
--
-- ⚠️ Este script YA INCLUYE el ciclo de ClockTime — no lo actives junto
-- con "ciclo-dia-noche.lua" en el mismo lugar, o ambos competirán por
-- la misma propiedad Lighting.ClockTime.

local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")

local HORA_ENCENDIDO = 16
local HORA_APAGADO = 6
local INCREMENTO_POR_TICK = 0.01

local spotLight = Workspace:WaitForChild("Sphere"):WaitForChild("SpotLight")

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
