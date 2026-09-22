--[[
	Timeclub Academy — Catálogo de Scripts (v1.0.0)

	Plugin de Roblox Studio para el curso de diseño de videojuegos.

	Cómo funciona en esta versión:
	- El catálogo (manifest.json) y el código de cada script viven en un
	  repositorio público de GitHub, no dentro de este archivo. El plugin
	  los descarga con HttpService cada vez que el profesor pulsa
	  "Sincronizar", así que actualizar contenido es solo hacer un
	  `git push` al repositorio — no hace falta republicar el plugin.
	- v1.0 NO filtra el catálogo por alumno: cualquiera que tenga este
	  plugin instalado ve los mismos scripts. El control de acceso por
	  alumno (vía la plataforma del curso) queda para una versión futura.
	- Cada entrada del catálogo indica dónde debe insertarse el script
	  (ServerScriptService o la Part seleccionada) y qué objetos debe
	  crear el alumno a mano de antemano — en v1.0 no hay modelos
	  embebidos, solo scripts + instrucciones.

	Para actualizar la URL del repositorio, cambia REPO_RAW_BASE_URL.
]]

local ChangeHistoryService = game:GetService("ChangeHistoryService")
local HttpService = game:GetService("HttpService")
local Selection = game:GetService("Selection")
local ServerScriptService = game:GetService("ServerScriptService")

-------------------------------------------------
-- Configuración
-------------------------------------------------
local REPO_RAW_BASE_URL = "https://raw.githubusercontent.com/DavidJara14/roblox-academy-plugin/main/"
local MANIFEST_URL = REPO_RAW_BASE_URL .. "manifest.json"

-------------------------------------------------
-- Toolbar + widget
-------------------------------------------------
local toolbar = plugin:CreateToolbar("Timeclub Academy")
local toggleButton = toolbar:CreateButton(
	"Catálogo de scripts",
	"Scripts disponibles para las lecciones del curso",
	""
)

local widgetInfo = DockWidgetPluginGuiInfo.new(
	Enum.InitialDockState.Right,
	false,
	false,
	360,
	600,
	300,
	400
)

local widget = plugin:CreateDockWidgetPluginGui("TimeclubAcademyCatalogWidget", widgetInfo)
widget.Title = "Timeclub Academy"
widget.Name = "TimeclubAcademyCatalogWidget"

toggleButton.Click:Connect(function()
	widget.Enabled = not widget.Enabled
	toggleButton:SetActive(widget.Enabled)
end)

widget:GetPropertyChangedSignal("Enabled"):Connect(function()
	toggleButton:SetActive(widget.Enabled)
end)

-------------------------------------------------
-- UI base
-------------------------------------------------
local STATUS_BAR_HEIGHT = 56

local statusBar = Instance.new("Frame")
statusBar.Size = UDim2.new(1, 0, 0, STATUS_BAR_HEIGHT)
statusBar.BackgroundColor3 = Color3.fromRGB(40, 60, 80)
statusBar.BorderSizePixel = 0
statusBar.Parent = widget

local statusCorner = Instance.new("UICorner")
statusCorner.CornerRadius = UDim.new(0, 6)
statusCorner.Parent = statusBar

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -104, 1, -12)
statusLabel.Position = UDim2.new(0, 8, 0, 6)
statusLabel.BackgroundTransparency = 1
statusLabel.Font = Enum.Font.SourceSans
statusLabel.TextSize = 13
statusLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.TextYAlignment = Enum.TextYAlignment.Center
statusLabel.TextWrapped = true
statusLabel.Text = "Sin sincronizar. Pulsa \"Sincronizar\" para cargar el catálogo."
statusLabel.Parent = statusBar

local syncButton = Instance.new("TextButton")
syncButton.Size = UDim2.new(0, 90, 0, 30)
syncButton.Position = UDim2.new(1, -98, 0.5, -15)
syncButton.BackgroundColor3 = Color3.fromRGB(80, 130, 190)
syncButton.Font = Enum.Font.SourceSansBold
syncButton.TextSize = 13
syncButton.TextColor3 = Color3.fromRGB(255, 255, 255)
syncButton.Text = "Sincronizar"
syncButton.Parent = statusBar

local syncButtonCorner = Instance.new("UICorner")
syncButtonCorner.CornerRadius = UDim.new(0, 6)
syncButtonCorner.Parent = syncButton

local root = Instance.new("ScrollingFrame")
root.Size = UDim2.new(1, 0, 1, -(STATUS_BAR_HEIGHT + 6))
root.Position = UDim2.new(0, 0, 0, STATUS_BAR_HEIGHT + 6)
root.CanvasSize = UDim2.new(0, 0, 0, 0)
root.AutomaticCanvasSize = Enum.AutomaticSize.Y
root.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
root.BorderSizePixel = 0
root.ScrollBarThickness = 6
root.Parent = widget

local listLayout = Instance.new("UIListLayout")
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Padding = UDim.new(0, 6)
listLayout.Parent = root

local padding = Instance.new("UIPadding")
padding.PaddingTop = UDim.new(0, 8)
padding.PaddingBottom = UDim.new(0, 8)
padding.PaddingLeft = UDim.new(0, 8)
padding.PaddingRight = UDim.new(0, 8)
padding.Parent = root

local order = 0
local function nextOrder()
	order = order + 1
	return order
end

local function clearRows()
	for _, child in root:GetChildren() do
		if child:IsA("Frame") or child:IsA("TextLabel") then
			child:Destroy()
		end
	end
	order = 0
end

local function flashButton(button, text, duration)
	local original = button.Text
	button.Text = text
	task.delay(duration or 1.2, function()
		if button and button.Parent then
			button.Text = original
		end
	end)
end

local function sectionHeader(text)
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, 0, 0, 26)
	label.BackgroundTransparency = 1
	label.Font = Enum.Font.SourceSansBold
	label.TextSize = 15
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Text = text
	label.LayoutOrder = nextOrder()
	label.Parent = root
end

-------------------------------------------------
-- Insertar un script del catálogo
-------------------------------------------------
local function fetchScriptSource(entry)
	local ok, response = pcall(function()
		return HttpService:GetAsync(REPO_RAW_BASE_URL .. entry.file)
	end)
	if not ok then
		return nil, tostring(response)
	end
	return response, nil
end

local function findExistingChild(parent, name)
	return parent:FindFirstChild(name)
end

local function insertScript(entry, statusCallback)
	local source, err = fetchScriptSource(entry)
	if not source then
		statusCallback("Error descargando el script: " .. tostring(err))
		return
	end

	local targetParent
	if entry.targetParent == "SelectedPart" then
		local selection = Selection:Get()
		if #selection ~= 1 then
			statusCallback("Selecciona exactamente una Part en el Explorer antes de insertar este script.")
			return
		end
		targetParent = selection[1]
	elseif entry.targetParent == "ServerScriptService" then
		targetParent = ServerScriptService
	else
		statusCallback("Ubicación de destino desconocida: " .. tostring(entry.targetParent))
		return
	end

	ChangeHistoryService:SetWaypoint("Antes de insertar " .. entry.scriptInstanceName)

	local existing = findExistingChild(targetParent, entry.scriptInstanceName)
	if existing then
		existing:Destroy()
	end

	local newScript = Instance.new("Script")
	newScript.Name = entry.scriptInstanceName
	newScript.Source = source
	newScript.Parent = targetParent

	Selection:Set({ newScript })
	ChangeHistoryService:SetWaypoint("Insertado " .. entry.scriptInstanceName)

	statusCallback(("\"%s\" insertado en %s."):format(entry.name, targetParent:GetFullName()))
end

-------------------------------------------------
-- Renderizar una fila de script
-------------------------------------------------
local function scriptRow(entry)
	local row = Instance.new("Frame")
	row.Size = UDim2.new(1, 0, 0, 0)
	row.AutomaticSize = Enum.AutomaticSize.Y
	row.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	row.BorderSizePixel = 0
	row.LayoutOrder = nextOrder()
	row.Parent = root

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 6)
	corner.Parent = row

	local rowPadding = Instance.new("UIPadding")
	rowPadding.PaddingTop = UDim.new(0, 8)
	rowPadding.PaddingBottom = UDim.new(0, 8)
	rowPadding.PaddingLeft = UDim.new(0, 8)
	rowPadding.PaddingRight = UDim.new(0, 8)
	rowPadding.Parent = row

	local rowLayout = Instance.new("UIListLayout")
	rowLayout.SortOrder = Enum.SortOrder.LayoutOrder
	rowLayout.Padding = UDim.new(0, 4)
	rowLayout.Parent = row

	local title = Instance.new("TextLabel")
	title.Size = UDim2.new(1, 0, 0, 20)
	title.BackgroundTransparency = 1
	title.Font = Enum.Font.SourceSansBold
	title.TextSize = 14
	title.TextColor3 = Color3.fromRGB(255, 255, 255)
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.Text = (entry.tested and "" or "⚠ No probado — ") .. entry.name
	title.LayoutOrder = 1
	title.Parent = row

	local desc = Instance.new("TextLabel")
	desc.Size = UDim2.new(1, 0, 0, 0)
	desc.AutomaticSize = Enum.AutomaticSize.Y
	desc.BackgroundTransparency = 1
	desc.Font = Enum.Font.SourceSans
	desc.TextSize = 12
	desc.TextColor3 = Color3.fromRGB(210, 210, 210)
	desc.TextXAlignment = Enum.TextXAlignment.Left
	desc.TextYAlignment = Enum.TextYAlignment.Top
	desc.TextWrapped = true
	desc.Text = entry.description or ""
	desc.LayoutOrder = 2
	desc.Parent = row

	local requirementsText = "Antes de insertar, crea/selecciona:\n"
	if entry.requiredObjects and #entry.requiredObjects > 0 then
		for _, requirement in entry.requiredObjects do
			requirementsText = requirementsText .. "• " .. requirement .. "\n"
		end
	else
		requirementsText = requirementsText .. "• (Sin requisitos adicionales)\n"
	end
	if entry.notes then
		requirementsText = requirementsText .. "\n⚠ " .. entry.notes
	end

	local requirements = Instance.new("TextLabel")
	requirements.Size = UDim2.new(1, 0, 0, 0)
	requirements.AutomaticSize = Enum.AutomaticSize.Y
	requirements.BackgroundTransparency = 1
	requirements.Font = Enum.Font.SourceSansItalic
	requirements.TextSize = 11
	requirements.TextColor3 = Color3.fromRGB(180, 190, 200)
	requirements.TextXAlignment = Enum.TextXAlignment.Left
	requirements.TextYAlignment = Enum.TextYAlignment.Top
	requirements.TextWrapped = true
	requirements.Text = requirementsText
	requirements.LayoutOrder = 3
	requirements.Parent = row

	local buttonRow = Instance.new("Frame")
	buttonRow.Size = UDim2.new(1, 0, 0, 30)
	buttonRow.BackgroundTransparency = 1
	buttonRow.LayoutOrder = 4
	buttonRow.Parent = row

	local insertButton = Instance.new("TextButton")
	insertButton.Size = UDim2.new(0, 90, 0, 30)
	insertButton.Position = UDim2.new(0, 0, 0, 0)
	insertButton.BackgroundColor3 = Color3.fromRGB(60, 140, 90)
	insertButton.Font = Enum.Font.SourceSansBold
	insertButton.TextSize = 13
	insertButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	insertButton.Text = "Insertar"
	insertButton.Parent = buttonRow

	local insertButtonCorner = Instance.new("UICorner")
	insertButtonCorner.CornerRadius = UDim.new(0, 6)
	insertButtonCorner.Parent = insertButton

	insertButton.MouseButton1Click:Connect(function()
		insertButton.Text = "..."
		insertScript(entry, function(message)
			statusLabel.Text = message
			flashButton(insertButton, "Insertar", 0.1)
		end)
	end)
end

-------------------------------------------------
-- Sincronización con el catálogo
-------------------------------------------------
local isSyncing = false

local function renderCatalog(scripts)
	clearRows()

	if not scripts or #scripts == 0 then
		sectionHeader("El catálogo está vacío.")
		return
	end

	table.sort(scripts, function(a, b)
		if a.lesson == b.lesson then
			return a.name < b.name
		end
		return a.lesson < b.lesson
	end)

	local lastLesson = nil
	for _, entry in scripts do
		if entry.lesson ~= lastLesson then
			sectionHeader(("Módulo %d, Lección %d — %s"):format(entry.module, entry.lesson, entry.lessonTitle or ""))
			lastLesson = entry.lesson
		end
		scriptRow(entry)
	end
end

local function sync()
	if isSyncing then
		return
	end
	isSyncing = true
	syncButton.Text = "..."
	statusLabel.Text = "Sincronizando catálogo..."

	task.spawn(function()
		local okReq, response = pcall(function()
			return HttpService:GetAsync(MANIFEST_URL)
		end)

		if not okReq then
			statusLabel.Text = "Error de conexión: " .. tostring(response)
			isSyncing = false
			syncButton.Text = "Sincronizar"
			return
		end

		local okJson, data = pcall(function()
			return HttpService:JSONDecode(response)
		end)

		if not okJson or not data.scripts then
			statusLabel.Text = "El catálogo respondió algo que no pude leer (JSON inválido)."
			isSyncing = false
			syncButton.Text = "Sincronizar"
			return
		end

		renderCatalog(data.scripts)
		statusLabel.Text = ("Catálogo v%s cargado: %d scripts disponibles."):format(
			tostring(data.version or "?"),
			#data.scripts
		)

		isSyncing = false
		syncButton.Text = "Sincronizar"
	end)
end

syncButton.MouseButton1Click:Connect(sync)

widget:GetPropertyChangedSignal("Enabled"):Connect(function()
	if widget.Enabled and order == 0 then
		sync()
	end
end)
