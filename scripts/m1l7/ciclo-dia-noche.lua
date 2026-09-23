-- Ciclo día/noche — Módulo 1, Lección 7
--
-- Ubicación: script independiente en Workspace (no está atado a
-- ninguna Part en particular, así que no aplica insertarlo dentro de
-- una — es una mecánica global del lugar).
-- Requisito: ninguno además de Lighting, que ya existe en cualquier lugar.
--
-- Qué hace: incrementa la hora del día (Lighting.ClockTime, de 0 a 24)
-- indefinidamente, generando el ciclo día/noche. Ajusta INCREMENTO_POR_TICK
-- y SEGUNDOS_ENTRE_TICKS para hacer el ciclo más rápido o más lento.
--
-- ⚠️ Solo debe existir UN script cambiando Lighting.ClockTime a la vez.
-- Si además usas el script "luz-de-calle-nocturna.lua" (que ya incluye
-- su propio ciclo de ClockTime), no actives los dos al mismo tiempo:
-- competirían por la misma propiedad.
--
-- Para experimentar: en las propiedades de Lighting prueba también
-- Brightness, Ambient y ColorShift_Top/Bottom para cambiar cómo se ve
-- la luz durante el ciclo.

local Lighting = game:GetService("Lighting")

local INCREMENTO_POR_TICK = 0.01
local SEGUNDOS_ENTRE_TICKS = 2

local horaDelDia = 0

while true do
	Lighting.ClockTime = horaDelDia
	horaDelDia += INCREMENTO_POR_TICK
	if horaDelDia > 24 then
		horaDelDia = 0
	end
	task.wait(SEGUNDOS_ENTRE_TICKS)
end
