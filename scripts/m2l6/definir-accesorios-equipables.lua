-- Definir accesorios equipables (gafas, sombrero, alas) — Módulo 2, Lección 6
--
-- Ubicación: ServerScriptService (script de configuración que corre una
-- vez al iniciar el juego, no atado a ningún objeto).
--
-- CÓMO USARLO:
-- 1. Inserta este script en ServerScriptService.
-- 2. Añade o edita entradas en la tabla ACCESORIOS de abajo (necesitas
--    el MeshId/TextureId de cada accesorio, visibles en sus propiedades
--    tras insertarlo una vez desde el Toolbox para copiarlos).
-- 3. Usa "equipar-accesorio.lua" (con el mismo NOMBRE) para colocarlo.
--
-- Qué hace: construye cada accesorio como Accessory+Part+Attachment+
-- SpecialMesh y lo deja listo en ReplicatedStorage para ser clonado.

local ACCESORIOS = {
	{
		nombre = "HPGlasses",
		attachment = "FaceFrontAttachment",
		posicionAttachment = Vector3.new(0, -0.24, -0.45),
		meshId = "rbxassetid://22053998",
		textureId = "rbxassetid://22053986",
		escala = Vector3.new(1, 1.3, 1),
	},
	{
		nombre = "lPHat",
		attachment = "HatAttachment",
		posicionAttachment = Vector3.new(0, 0, 0),
		meshId = "rbxassetid://101099213",
		textureId = "rbxassetid://101098928",
		escala = Vector3.new(1, 1, 1),
	},
}

local function crearAccesorio(datos)
	local accesorio = Instance.new("Accessory")
	accesorio.Name = datos.nombre

	local handle = Instance.new("Part")
	handle.Name = "Handle"
	handle.Size = Vector3.new(1, 1.6, 1)
	handle.Parent = accesorio

	local attachment = Instance.new("Attachment")
	attachment.Name = datos.attachment
	attachment.Position = datos.posicionAttachment
	attachment.Parent = handle

	local mesh = Instance.new("SpecialMesh")
	mesh.Name = "Mesh"
	mesh.Scale = datos.escala
	mesh.MeshId = datos.meshId
	mesh.TextureId = datos.textureId
	mesh.Parent = handle

	accesorio.Parent = game.ReplicatedStorage
end

for _, datos in ACCESORIOS do
	crearAccesorio(datos)
end
