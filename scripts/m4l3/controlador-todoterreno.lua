-- Controlador del vehículo todoterreno (ATV) — Módulo 4, Lección 3
--
-- Ubicación: Script dentro del modelo "QuadBike" (script.Parent).
--
-- CÓMO USARLO (requiere esta jerarquía exacta dentro de "QuadBike"):
-- 1. VehicleSeat (soldado a la Part "Base").
-- 2. rear_axle y front_axle (Models), cada uno con:
--      wheel_axle (Part) > CylindricalConstraint_l, CylindricalConstraint_r
--    configurados como motor (AngularActuatorType = Motor).
-- 2. Selecciona el modelo "QuadBike" e inserta este script.
-- 3. Presiona Play y conduce con WASD desde el VehicleSeat.
--
-- Qué hace: traduce el input del VehicleSeat (dirección/aceleración)
-- en velocidad angular de los 4 motores (CylindricalConstraint) para
-- avanzar, retroceder y girar; si el vehículo se voltea, se
-- autoendereza tras 1 segundo.
--
-- Correcciones sobre el script original de la diapositiva:
-- - Había un wait() extra dentro de las ramas de giro, además del
--   wait() del bucle principal — el input se procesaba a la mitad de
--   velocidad mientras se giraba respecto a ir recto. Se eliminó el
--   wait() interno.
-- - Los comentarios originales tenían SteerFloat/ThrottleFloat al
--   revés (decían que SteerFloat era adelante/atrás); el código en sí
--   siempre los usó bien, solo se corrigió el comentario.
-- - Se eliminaron dos variables sin uso (MaxSpeed, currentVelocity).

local quadBike = script.Parent
local vehicleSeat = quadBike.VehicleSeat
local rearAxle = quadBike.rear_axle
local frontAxle = quadBike.front_axle

local motorLB = rearAxle.wheel_axle.CylindricalConstraint_l
local motorRB = rearAxle.wheel_axle.CylindricalConstraint_r
local motorLF = frontAxle.wheel_axle.CylindricalConstraint_l
local motorRF = frontAxle.wheel_axle.CylindricalConstraint_r

local TORQUE_MAX = 1000000
local ROTATE_VEL = 50

motorLB.MotorMaxTorque = TORQUE_MAX
motorRB.MotorMaxTorque = TORQUE_MAX
motorLF.MotorMaxTorque = TORQUE_MAX
motorRF.MotorMaxTorque = TORQUE_MAX

local function establecerVelocidadMotores(vel)
	motorLF.AngularVelocity = vel
	motorLB.AngularVelocity = vel
	-- Los motores del lado derecho giran al revés que los del
	-- izquierdo para que las 4 ruedas avancen en la misma dirección.
	motorRF.AngularVelocity = -vel
	motorRB.AngularVelocity = -vel
end

while true do
	local steerFloat = vehicleSeat.SteerFloat -- Izquierda/derecha, -1 a 1
	local throttle = vehicleSeat.ThrottleFloat -- Adelante/atrás, -1 a 1

	if steerFloat == 0 then
		establecerVelocidadMotores(throttle * ROTATE_VEL)
	elseif steerFloat < 0 then
		motorLB.AngularVelocity = -0.7 * ROTATE_VEL
		motorRB.AngularVelocity = -ROTATE_VEL
		motorLF.AngularVelocity = -0.7 * ROTATE_VEL
		motorRF.AngularVelocity = -ROTATE_VEL
	else
		motorLB.AngularVelocity = ROTATE_VEL
		motorRB.AngularVelocity = 0.7 * ROTATE_VEL
		motorLF.AngularVelocity = ROTATE_VEL
		motorRF.AngularVelocity = 0.7 * ROTATE_VEL
	end

	if vehicleSeat.Orientation.Z > 90 or vehicleSeat.Orientation.Z < -90 then
		task.wait(1)
		vehicleSeat.CFrame = CFrame.new(vehicleSeat.Position) * CFrame.Angles(0, vehicleSeat.Orientation.Y, 0)
	end

	task.wait()
end
