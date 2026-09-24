-- Aparición de un objeto al tocar una Part — Módulo 1, Lección 9
--
-- Ubicación: dentro de la Part disparadora (usa script.Parent). Funciona
-- con cualquier Part.
-- Requisito: un Model (por ejemplo, insertado desde el Toolbox) puesto
-- directamente dentro de ServerStorage (no en Workspace), nombrado
-- exactamente SorpresaModel — al estar en ServerStorage ya empieza
-- escondido, sin necesidad de moverlo al iniciar el juego.
--
-- Qué hace: cuando el jugador toca esta Part, el modelo SorpresaModel
-- se mueve de ServerStorage a Workspace y aparece. Un Model no tiene
-- una propiedad Transparency propia — por eso, para mostrarlo, se
-- cambia su propiedad Parent en vez de intentar volverlo transparente.
--
-- Nota: reacciona a cualquier cosa que toque la Part disparadora, no
-- solo a personajes — se mantiene simple a propósito.
--
-- Para experimentar: prueba usar otro Model del Toolbox, o cambiar el
-- tamaño/forma de esta Part para que el área de activación sea más
-- grande o más chica.

local modelo = game.ServerStorage.SorpresaModel

local function onTriggerTouched(hit)
	local character = hit.Parent
	if character and modelo.Parent ~= game.Workspace then
		modelo.Parent = game.Workspace
	end
end

script.Parent.Touched:Connect(onTriggerTouched)
