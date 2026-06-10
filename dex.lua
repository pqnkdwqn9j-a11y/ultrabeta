-- =====================================================
-- ULTRA DEX EXPLORER — by SkilerBost
-- Стандалон версия (можно запускать отдельно)
-- =====================================================

if not game:IsLoaded() then game.Loaded:Wait() end
if getgenv().ULTRA_DEX_LOADED then return end
getgenv().ULTRA_DEX_LOADED = true

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local Selection = game:GetService("Selection")
local RunService = game:GetService("RunService")

local LP = Players.LocalPlayer
local Mouse = LP:GetMouse()

local function GetRoot()
    local ok, r = pcall(function() return gethui() end)
    return (ok and r) or CoreGui
end

-- Очистка старых
for _, g in ipairs(GetRoot():GetChildren()) do
    if tostring(g.Name):find("ULTRA_DEX") then pcall(function() g:Destroy() end) end
end

-- ════════ ТЕМА ════════
local TH = {
    bg        = Color3.fromRGB(12, 12, 22),
    panel     = Color3.fromRGB(16, 16, 30),
    item      = Color3.fromRGB(20, 20, 38),
    itemHover = Color3.fromRGB(28, 28, 50),
    selected  = Color3.fromRGB(0, 100, 180),
    accent    = Color3.fromRGB(0, 170, 255),
    text      = Color3.fromRGB(220, 220, 240),
    dim       = Color3.fromRGB(120, 120, 150),
    border    = Color3.fromRGB(35, 35, 60),
    danger    = Color3.fromRGB(255, 60, 60),
    success   = Color3.fromRGB(0, 220, 100),
    warn      = Color3.fromRGB(255, 180, 0),
}

-- Иконки по классам (Unicode символы)
local ClassIcons = {
    Folder              = "📁",
    Workspace           = "🌍",
    Players             = "👥",
    Player              = "👤",
    Part                = "🟦",
    MeshPart            = "🟪",
    Model               = "📦",
    Script              = "📜",
    LocalScript         = "📃",
    ModuleScript        = "📋",
    RemoteEvent         = "📡",
    RemoteFunction      = "📞",
    BindableEvent       = "🔔",
    Sound               = "🔊",
    Decal               = "🖼️",
    Texture             = "🎨",
    Tool                = "🔧",
    Accessory           = "🎩",
    Humanoid            = "🧍",
    Camera              = "📷",
    Light               = "💡",
    PointLight          = "💡",
    SpotLight           = "🔦",
    Animation           = "🎬",
    Attachment          = "🔗",
    BillboardGui        = "💬",
    SurfaceGui          = "🖥️",
    ScreenGui           = "📱",
    Frame               = "▭",
    TextLabel           = "T",
    TextButton          = "🔘",
    ImageLabel          = "🖼️",
    ImageButton          = "🖱️",
    ReplicatedStorage   = "📦",
    ServerStorage       = "🗄️",
    StarterPack         = "🎒",
    StarterGui          = "📺",
    Lighting            = "💡",
    SoundService        = "🎵",
}

local function GetIcon(class)
    return ClassIcons[class] or "❓"
end

-- ════════ ГЛАВНЫЙ GUI ════════
local DexGui = Instance.new("ScreenGui")
DexGui.Name = "ULTRA_DEX"
DexGui.IgnoreGuiInset = true
DexGui.DisplayOrder = 100000
DexGui.ResetOnSpawn = false
DexGui.Parent = GetRoot()

local MainOpen = true

-- ОСНОВНОЕ ОКНО
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, 700, 0, 500)
Main.Position = UDim2.new(0.5, -350, 0.5, -250)
Main.BackgroundColor3 = TH.bg
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.Parent = DexGui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = TH.accent
MainStroke.Thickness = 1.5

-- Анимация обводки
task.spawn(function()
    local colors = {TH.accent, Color3.fromRGB(130, 50, 255), Color3.fromRGB(255, 50, 100), TH.accent}
    local i = 1
    while DexGui.Parent do
        TweenService:Create(MainStroke, TweenInfo.new(2, Enum.EasingStyle.Sine), {Color = colors[i]}):Play()
        i = i % #colors + 1
        task.wait(2)
    end
end)

-- ШАПКА
local Header = Instance.new("Frame", Main)
Header.Size = UDim2.new(1, 0, 0, 36)
Header.BackgroundColor3 = TH.panel
Header.BorderSizePixel = 0
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", Header)
Title.Size = UDim2.new(0, 250, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "🔍  ULTRA DEX EXPLORER"
Title.TextColor3 = TH.accent
Title.TextSize = 14
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left

local SubTitle = Instance.new("TextLabel", Header)
SubTitle.Size = UDim2.new(0, 200, 1, 0)
SubTitle.Position = UDim2.new(1, -240, 0, 0)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "SkilerBost • v1.0"
SubTitle.TextColor3 = TH.dim
SubTitle.TextSize = 10
SubTitle.Font = Enum.Font.Gotham
SubTitle.TextXAlignment = Enum.TextXAlignment.Right

local CloseBtn = Instance.new("TextButton", Header)
CloseBtn.Size = UDim2.new(0, 26, 0, 26)
CloseBtn.Position = UDim2.new(1, -32, 0.5, -13)
CloseBtn.BackgroundColor3 = Color3.fromRGB(60, 20, 20)
CloseBtn.TextColor3 = Color3.new(1, 1, 1)
CloseBtn.Text = "✕"
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 12
CloseBtn.BorderSizePixel = 0
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 5)
CloseBtn.MouseButton1Click:Connect(function() MainOpen = false end)

-- ПОИСК
local SearchBg = Instance.new("Frame", Main)
SearchBg.Size = UDim2.new(0.35, -10, 0, 28)
SearchBg.Position = UDim2.new(0, 8, 0, 44)
SearchBg.BackgroundColor3 = TH.panel
SearchBg.BorderSizePixel = 0
Instance.new("UICorner", SearchBg).CornerRadius = UDim.new(0, 6)
Instance.new("UIStroke", SearchBg).Color = TH.border

local SearchIcon = Instance.new("TextLabel", SearchBg)
SearchIcon.Size = UDim2.new(0, 24, 1, 0)
SearchIcon.BackgroundTransparency = 1
SearchIcon.Text = "🔍"
SearchIcon.TextSize = 12
SearchIcon.Font = Enum.Font.Gotham

local SearchBox = Instance.new("TextBox", SearchBg)
SearchBox.Size = UDim2.new(1, -28, 1, 0)
SearchBox.Position = UDim2.new(0, 24, 0, 0)
SearchBox.BackgroundTransparency = 1
SearchBox.Text = ""
SearchBox.PlaceholderText = "Search instances..."
SearchBox.PlaceholderColor3 = TH.dim
SearchBox.TextColor3 = TH.text
SearchBox.TextSize = 12
SearchBox.Font = Enum.Font.Gotham
SearchBox.TextXAlignment = Enum.TextXAlignment.Left
SearchBox.ClearTextOnFocus = false

-- ЛЕВАЯ ПАНЕЛЬ (дерево)
local TreePanel = Instance.new("Frame", Main)
TreePanel.Size = UDim2.new(0.35, -10, 1, -118)
TreePanel.Position = UDim2.new(0, 8, 0, 78)
TreePanel.BackgroundColor3 = TH.panel
TreePanel.BorderSizePixel = 0
Instance.new("UICorner", TreePanel).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", TreePanel).Color = TH.border

local TreeScroll = Instance.new("ScrollingFrame", TreePanel)
TreeScroll.Size = UDim2.new(1, -4, 1, -4)
TreeScroll.Position = UDim2.new(0, 2, 0, 2)
TreeScroll.BackgroundTransparency = 1
TreeScroll.BorderSizePixel = 0
TreeScroll.ScrollBarThickness = 4
TreeScroll.ScrollBarImageColor3 = TH.accent
TreeScroll.CanvasSize = UDim2.new(0, 0, 0, 0)

-- ПРАВАЯ ПАНЕЛЬ (свойства)
local PropPanel = Instance.new("Frame", Main)
PropPanel.Size = UDim2.new(0.65, -10, 1, -118)
PropPanel.Position = UDim2.new(0.35, 0, 0, 78)
PropPanel.BackgroundColor3 = TH.panel
PropPanel.BorderSizePixel = 0
Instance.new("UICorner", PropPanel).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", PropPanel).Color = TH.border

-- Шапка свойств
local PropHeader = Instance.new("Frame", PropPanel)
PropHeader.Size = UDim2.new(1, 0, 0, 30)
PropHeader.BackgroundColor3 = TH.item
PropHeader.BorderSizePixel = 0
Instance.new("UICorner", PropHeader).CornerRadius = UDim.new(0, 8)

local PropTitle = Instance.new("TextLabel", PropHeader)
PropTitle.Size = UDim2.new(1, -100, 1, 0)
PropTitle.Position = UDim2.new(0, 10, 0, 0)
PropTitle.BackgroundTransparency = 1
PropTitle.Text = "Select an instance"
PropTitle.TextColor3 = TH.accent
PropTitle.TextSize = 12
PropTitle.Font = Enum.Font.GothamBold
PropTitle.TextXAlignment = Enum.TextXAlignment.Left
PropTitle.TextTruncate = Enum.TextTruncate.AtEnd

local CopyPathBtn = Instance.new("TextButton", PropHeader)
CopyPathBtn.Size = UDim2.new(0, 40, 0, 22)
CopyPathBtn.Position = UDim2.new(1, -90, 0.5, -11)
CopyPathBtn.BackgroundColor3 = Color3.fromRGB(30, 60, 110)
CopyPathBtn.TextColor3 = Color3.new(1, 1, 1)
CopyPathBtn.Text = "📋"
CopyPathBtn.Font = Enum.Font.GothamBold
CopyPathBtn.TextSize = 11
CopyPathBtn.BorderSizePixel = 0
Instance.new("UICorner", CopyPathBtn).CornerRadius = UDim.new(0, 5)

local DeleteBtn = Instance.new("TextButton", PropHeader)
DeleteBtn.Size = UDim2.new(0, 40, 0, 22)
DeleteBtn.Position = UDim2.new(1, -45, 0.5, -11)
DeleteBtn.BackgroundColor3 = Color3.fromRGB(110, 30, 30)
DeleteBtn.TextColor3 = Color3.new(1, 1, 1)
DeleteBtn.Text = "🗑"
DeleteBtn.Font = Enum.Font.GothamBold
DeleteBtn.TextSize = 11
DeleteBtn.BorderSizePixel = 0
Instance.new("UICorner", DeleteBtn).CornerRadius = UDim.new(0, 5)

-- Скролл свойств
local PropScroll = Instance.new("ScrollingFrame", PropPanel)
PropScroll.Size = UDim2.new(1, -4, 1, -34)
PropScroll.Position = UDim2.new(0, 2, 0, 32)
PropScroll.BackgroundTransparency = 1
PropScroll.BorderSizePixel = 0
PropScroll.ScrollBarThickness = 4
PropScroll.ScrollBarImageColor3 = TH.accent
PropScroll.CanvasSize = UDim2.new(0, 0, 0, 0)

-- НИЖНЯЯ ПАНЕЛЬ (консоль)
local Console = Instance.new("Frame", Main)
Console.Size = UDim2.new(1, -16, 0, 32)
Console.Position = UDim2.new(0, 8, 1, -40)
Console.BackgroundColor3 = TH.panel
Console.BorderSizePixel = 0
Instance.new("UICorner", Console).CornerRadius = UDim.new(0, 6)
Instance.new("UIStroke", Console).Color = TH.border

local ConsoleIcon = Instance.new("TextLabel", Console)
ConsoleIcon.Size = UDim2.new(0, 30, 1, 0)
ConsoleIcon.BackgroundTransparency = 1
ConsoleIcon.Text = ">_"
ConsoleIcon.TextColor3 = TH.success
ConsoleIcon.TextSize = 12
ConsoleIcon.Font = Enum.Font.Code

local ConsoleBox = Instance.new("TextBox", Console)
ConsoleBox.Size = UDim2.new(1, -100, 1, 0)
ConsoleBox.Position = UDim2.new(0, 30, 0, 0)
ConsoleBox.BackgroundTransparency = 1
ConsoleBox.Text = ""
ConsoleBox.PlaceholderText = "print('Hello'); workspace.Part:Destroy()  -- press Enter"
ConsoleBox.PlaceholderColor3 = TH.dim
ConsoleBox.TextColor3 = TH.text
ConsoleBox.TextSize = 12
ConsoleBox.Font = Enum.Font.Code
ConsoleBox.TextXAlignment = Enum.TextXAlignment.Left
ConsoleBox.ClearTextOnFocus = false

local ExecBtn = Instance.new("TextButton", Console)
ExecBtn.Size = UDim2.new(0, 60, 0, 22)
ExecBtn.Position = UDim2.new(1, -68, 0.5, -11)
ExecBtn.BackgroundColor3 = TH.accent
ExecBtn.TextColor3 = Color3.new(1, 1, 1)
ExecBtn.Text = "RUN ▶"
ExecBtn.Font = Enum.Font.GothamBold
ExecBtn.TextSize = 11
ExecBtn.BorderSizePixel = 0
Instance.new("UICorner", ExecBtn).CornerRadius = UDim.new(0, 5)

-- ════════ ЛОГИКА ════════

local SelectedInstance = nil
local ExpandedNodes = {}
local NodeButtons = {} -- [instance] = button
local SearchText = ""

-- Уведомления
local function Notify(text, color)
    local n = Instance.new("Frame", DexGui)
    n.Size = UDim2.new(0, 250, 0, 40)
    n.Position = UDim2.new(0.5, -125, 0, -50)
    n.BackgroundColor3 = TH.panel
    n.BorderSizePixel = 0
    Instance.new("UICorner", n).CornerRadius = UDim.new(0, 8)
    local s = Instance.new("UIStroke", n)
    s.Color = color or TH.accent
    s.Thickness = 1.5

    local t = Instance.new("TextLabel", n)
    t.Size = UDim2.new(1, -10, 1, 0)
    t.Position = UDim2.new(0, 5, 0, 0)
    t.BackgroundTransparency = 1
    t.Text = text
    t.TextColor3 = color or TH.accent
    t.TextSize = 12
    t.Font = Enum.Font.GothamMedium
    t.TextWrapped = true

    TweenService:Create(n, TweenInfo.new(0.4, Enum.EasingStyle.Back), {Position = UDim2.new(0.5, -125, 0, 15)}):Play()
    task.wait(2)
    TweenService:Create(n, TweenInfo.new(0.3), {Position = UDim2.new(0.5, -125, 0, -50)}):Play()
    task.wait(0.4)
    n:Destroy()
end

-- Безопасное получение полного пути
local function GetFullPath(obj)
    local ok, path = pcall(function() return obj:GetFullName() end)
    return ok and path or tostring(obj)
end

-- Безопасное получение детей
local function SafeGetChildren(obj)
    local ok, children = pcall(function() return obj:GetChildren() end)
    return ok and children or {}
end

-- ════════ ДЕРЕВО ОБЪЕКТОВ ════════

local TreeY = 0
local TreeButtons = {}

local function ClearTree()
    for _, b in ipairs(TreeScroll:GetChildren()) do b:Destroy() end
    TreeButtons = {}
    NodeButtons = {}
    TreeY = 0
end

local function CreateTreeNode(obj, depth)
    if not obj then return end

    local btn = Instance.new("TextButton", TreeScroll)
    btn.Size = UDim2.new(1, -8, 0, 22)
    btn.Position = UDim2.new(0, 4, 0, TreeY)
    btn.BackgroundColor3 = TH.item
    btn.BackgroundTransparency = 0.3
    btn.BorderSizePixel = 0
    btn.Text = ""
    btn.AutoButtonColor = false
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)

    -- Стрелка раскрытия
    local children = SafeGetChildren(obj)
    local hasChildren = #children > 0

    local arrow = Instance.new("TextLabel", btn)
    arrow.Size = UDim2.new(0, 14, 1, 0)
    arrow.Position = UDim2.new(0, depth * 12, 0, 0)
    arrow.BackgroundTransparency = 1
    arrow.Text = hasChildren and (ExpandedNodes[obj] and "▼" or "▶") or " "
    arrow.TextColor3 = TH.dim
    arrow.TextSize = 9
    arrow.Font = Enum.Font.Gotham

    -- Иконка класса
    local icon = Instance.new("TextLabel", btn)
    icon.Size = UDim2.new(0, 18, 1, 0)
    icon.Position = UDim2.new(0, depth * 12 + 14, 0, 0)
    icon.BackgroundTransparency = 1
    icon.Text = GetIcon(obj.ClassName)
    icon.TextSize = 11
    icon.Font = Enum.Font.Gotham

    -- Название
    local nameLbl = Instance.new("TextLabel", btn)
    nameLbl.Size = UDim2.new(1, -(depth * 12 + 38), 1, 0)
    nameLbl.Position = UDim2.new(0, depth * 12 + 34, 0, 0)
    nameLbl.BackgroundTransparency = 1
    nameLbl.Text = obj.Name
    nameLbl.TextColor3 = TH.text
    nameLbl.TextSize = 11
    nameLbl.Font = Enum.Font.Gotham
    nameLbl.TextXAlignment = Enum.TextXAlignment.Left
    nameLbl.TextTruncate = Enum.TextTruncate.AtEnd

    -- Подсветка выбранного
    if SelectedInstance == obj then
        btn.BackgroundColor3 = TH.selected
        btn.BackgroundTransparency = 0
    end

    -- Hover эффект
    btn.MouseEnter:Connect(function()
        if SelectedInstance ~= obj then
            TweenService:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = TH.itemHover, BackgroundTransparency = 0}):Play()
        end
    end)
    btn.MouseLeave:Connect(function()
        if SelectedInstance ~= obj then
            TweenService:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = TH.item, BackgroundTransparency = 0.3}):Play()
        end
    end)

    -- Клик
    btn.MouseButton1Click:Connect(function()
        -- Выбор объекта
        SelectedInstance = obj

        -- Перерисовка дерева (обновить подсветку)
        for _, b in pairs(TreeButtons) do
            if b.obj == obj then
                b.btn.BackgroundColor3 = TH.selected
                b.btn.BackgroundTransparency = 0
            else
                b.btn.BackgroundColor3 = TH.item
                b.btn.BackgroundTransparency = 0.3
            end
        end

        -- Обновить панель свойств
        ShowProperties(obj)
    end)

    -- Двойной клик / клик на стрелку — раскрыть
    btn.MouseButton2Click:Connect(function()
        if hasChildren then
            ExpandedNodes[obj] = not ExpandedNodes[obj]
            RefreshTree()
        end
    end)

    -- Клик на стрелку
    local arrowBtn = Instance.new("TextButton", btn)
    arrowBtn.Size = UDim2.new(0, 14, 1, 0)
    arrowBtn.Position = UDim2.new(0, depth * 12, 0, 0)
    arrowBtn.BackgroundTransparency = 1
    arrowBtn.Text = ""
    arrowBtn.MouseButton1Click:Connect(function()
        if hasChildren then
            ExpandedNodes[obj] = not ExpandedNodes[obj]
            RefreshTree()
        end
    end)

    TreeY = TreeY + 23
    table.insert(TreeButtons, {btn = btn, obj = obj})
    NodeButtons[obj] = btn

    -- Дети
    if ExpandedNodes[obj] and hasChildren then
        for _, child in ipairs(children) do
            CreateTreeNode(child, depth + 1)
        end
    end
end

function RefreshTree()
    ClearTree()

    -- Корневые объекты
    local roots = {
        Workspace = workspace,
        Players = Players,
        Lighting = game:GetService("Lighting"),
        ReplicatedStorage = game:GetService("ReplicatedStorage"),
        ReplicatedFirst = game:GetService("ReplicatedFirst"),
        StarterGui = game:GetService("StarterGui"),
        StarterPack = game:GetService("StarterPack"),
        StarterPlayer = game:GetService("StarterPlayer"),
        SoundService = game:GetService("SoundService"),
        Teams = game:GetService("Teams"),
    }

    -- Фильтр по поиску
    local function MatchesSearch(obj)
        if SearchText == "" then return true end
        return string.find(string.lower(obj.Name), string.lower(SearchText), 1, true) ~= nil
    end

    -- Рекурсивный поиск
    local function FindMatching(obj, depth)
        local matches = MatchesSearch(obj)
        local children = SafeGetChildren(obj)
        local hasMatchingChild = false

        if SearchText ~= "" then
            for _, ch in ipairs(children) do
                if FindMatching(ch, depth + 1) then
                    hasMatchingChild = true
                    ExpandedNodes[obj] = true
                end
            end
        end

        if matches or hasMatchingChild then
            CreateTreeNode(obj, depth)
            return true
        end
        return false
    end

    if SearchText ~= "" then
        for name, obj in pairs(roots) do
            FindMatching(obj, 0)
        end
    else
        for name, obj in pairs(roots) do
            CreateTreeNode(obj, 0)
        end
    end

    TreeScroll.CanvasSize = UDim2.new(0, 0, 0, TreeY + 10)
end

-- ════════ ПАНЕЛЬ СВОЙСТВ ════════

local PropY = 0

local function ClearProps()
    for _, c in ipairs(PropScroll:GetChildren()) do c:Destroy() end
    PropY = 4
end

local function AddPropRow(name, value, obj, propName, canEdit)
    local row = Instance.new("Frame", PropScroll)
    row.Size = UDim2.new(1, -8, 0, 26)
    row.Position = UDim2.new(0, 4, 0, PropY)
    row.BackgroundColor3 = TH.item
    row.BackgroundTransparency = 0.5
    row.BorderSizePixel = 0
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 4)

    local lb = Instance.new("TextLabel", row)
    lb.Size = UDim2.new(0.4, 0, 1, 0)
    lb.Position = UDim2.new(0, 8, 0, 0)
    lb.BackgroundTransparency = 1
    lb.Text = name
    lb.TextColor3 = TH.dim
    lb.TextSize = 11
    lb.Font = Enum.Font.GothamMedium
    lb.TextXAlignment = Enum.TextXAlignment.Left

    if canEdit then
        local box = Instance.new("TextBox", row)
        box.Size = UDim2.new(0.6, -10, 1, -6)
        box.Position = UDim2.new(0.4, 0, 0, 3)
        box.BackgroundColor3 = TH.bg
        box.TextColor3 = TH.text
        box.TextSize = 11
        box.Font = Enum.Font.Code
        box.Text = tostring(value)
        box.ClearTextOnFocus = false
        box.BorderSizePixel = 0
        box.TextXAlignment = Enum.TextXAlignment.Left
        Instance.new("UICorner", box).CornerRadius = UDim.new(0, 4)

        box.FocusLost:Connect(function(enter)
            if enter then
                pcall(function()
                    local curVal = obj[propName]
                    local newVal = box.Text

                    -- Конвертация по типу
                    if typeof(curVal) == "number" then
                        newVal = tonumber(newVal) or curVal
                    elseif typeof(curVal) == "boolean" then
                        newVal = newVal:lower() == "true"
                    elseif typeof(curVal) == "string" then
                        -- оставляем строкой
                    elseif typeof(curVal) == "Vector3" then
                        local x, y, z = newVal:match("([-%d%.]+)[,%s]+([-%d%.]+)[,%s]+([-%d%.]+)")
                        if x then newVal = Vector3.new(tonumber(x), tonumber(y), tonumber(z))
                        else newVal = curVal end
                    elseif typeof(curVal) == "Color3" then
                        local r, g, b = newVal:match("([%d%.]+)[,%s]+([%d%.]+)[,%s]+([%d%.]+)")
                        if r then
                            r, g, b = tonumber(r), tonumber(g), tonumber(b)
                            if r > 1 or g > 1 or b > 1 then
                                newVal = Color3.fromRGB(r, g, b)
                            else
                                newVal = Color3.new(r, g, b)
                            end
                        else newVal = curVal end
                    else
                        Notify("Type not supported: "..typeof(curVal), TH.warn)
                        box.Text = tostring(curVal)
                        return
                    end

                    obj[propName] = newVal
                    Notify("✓ "..propName.." = "..tostring(newVal), TH.success)
                end)
            end
        end)
    else
        local lb2 = Instance.new("TextLabel", row)
        lb2.Size = UDim2.new(0.6, -10, 1, 0)
        lb2.Position = UDim2.new(0.4, 0, 0, 0)
        lb2.BackgroundTransparency = 1
        lb2.Text = tostring(value)
        lb2.TextColor3 = TH.text
        lb2.TextSize = 11
        lb2.Font = Enum.Font.Code
        lb2.TextXAlignment = Enum.TextXAlignment.Left
        lb2.TextTruncate = Enum.TextTruncate.AtEnd
    end

    PropY = PropY + 29
end

local function AddSection(text)
    local s = Instance.new("TextLabel", PropScroll)
    s.Size = UDim2.new(1, -8, 0, 20)
    s.Position = UDim2.new(0, 4, 0, PropY)
    s.BackgroundColor3 = TH.bg
    s.BorderSizePixel = 0
    s.Text = "  ━━ "..text.." ━━"
    s.TextColor3 = TH.accent
    s.TextSize = 11
    s.Font = Enum.Font.GothamBold
    s.TextXAlignment = Enum.TextXAlignment.Left
    Instance.new("UICorner", s).CornerRadius = UDim.new(0, 4)
    PropY = PropY + 24
end

function ShowProperties(obj)
    ClearProps()
    if not obj then return end

    PropTitle.Text = "📦  "..obj.Name.." ("..obj.ClassName..")"

    -- Базовые свойства
    AddSection("BASIC")
    AddPropRow("Name", obj.Name, obj, "Name", true)
    AddPropRow("ClassName", obj.ClassName, obj, "ClassName", false)
    AddPropRow("Parent", obj.Parent and obj.Parent.Name or "nil", obj, "Parent", false)
    AddPropRow("FullName", GetFullPath(obj), obj, "FullName", false)

    pcall(function()
        if obj:IsA("BasePart") then
            AddSection("TRANSFORM")
            AddPropRow("Position", tostring(obj.Position), obj, "Position", true)
            AddPropRow("Size", tostring(obj.Size), obj, "Size", true)
            AddPropRow("Orientation", tostring(obj.Orientation), obj, "Orientation", true)

            AddSection("APPEARANCE")
            AddPropRow("Color", tostring(obj.Color), obj, "Color", true)
            AddPropRow("Transparency", obj.Transparency, obj, "Transparency", true)
            AddPropRow("Material", tostring(obj.Material), obj, "Material", false)
            AddPropRow("Reflectance", obj.Reflectance, obj, "Reflectance", true)

            AddSection("PHYSICS")
            AddPropRow("Anchored", obj.Anchored, obj, "Anchored", true)
            AddPropRow("CanCollide", obj.CanCollide, obj, "CanCollide", true)
            AddPropRow("Massless", obj.Massless, obj, "Massless", true)
        end

        if obj:IsA("Humanoid") then
            AddSection("HUMANOID")
            AddPropRow("Health", obj.Health, obj, "Health", true)
            AddPropRow("MaxHealth", obj.MaxHealth, obj, "MaxHealth", true)
            AddPropRow("WalkSpeed", obj.WalkSpeed, obj, "WalkSpeed", true)
            AddPropRow("JumpPower", obj.JumpPower, obj, "JumpPower", true)
            AddPropRow("HipHeight", obj.HipHeight, obj, "HipHeight", true)
        end

        if obj:IsA("Player") then
            AddSection("PLAYER")
            AddPropRow("DisplayName", obj.DisplayName, obj, "DisplayName", false)
            AddPropRow("UserId", obj.UserId, obj, "UserId", false)
            AddPropRow("AccountAge", obj.AccountAge, obj, "AccountAge", false)
            AddPropRow("Team", obj.Team and obj.Team.Name or "nil", obj, "Team", false)
        end

        if obj:IsA("Sound") then
            AddSection("SOUND")
            AddPropRow("SoundId", obj.SoundId, obj, "SoundId", true)
            AddPropRow("Volume", obj.Volume, obj, "Volume", true)
            AddPropRow("Pitch", obj.Pitch, obj, "Pitch", true)
            AddPropRow("Playing", obj.Playing, obj, "Playing", true)
            AddPropRow("Looped", obj.Looped, obj, "Looped", true)
        end

        if obj:IsA("Decal") or obj:IsA("Texture") then
            AddSection("TEXTURE")
            AddPropRow("Texture", obj.Texture, obj, "Texture", true)
            AddPropRow("Transparency", obj.Transparency, obj, "Transparency", true)
            AddPropRow("Color3", tostring(obj.Color3), obj, "Color3", true)
        end

        if obj:IsA("GuiObject") then
            AddSection("GUI")
            AddPropRow("Size", tostring(obj.Size), obj, "Size", true)
            AddPropRow("Position", tostring(obj.Position), obj, "Position", true)
            AddPropRow("Visible", obj.Visible, obj, "Visible", true)
            AddPropRow("BackgroundColor3", tostring(obj.BackgroundColor3), obj, "BackgroundColor3", true)
            AddPropRow("BackgroundTransparency", obj.BackgroundTransparency, obj, "BackgroundTransparency", true)
        end

        if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
            AddPropRow("Text", obj.Text, obj, "Text", true)
            AddPropRow("TextColor3", tostring(obj.TextColor3), obj, "TextColor3", true)
            AddPropRow("TextSize", obj.TextSize, obj, "TextSize", true)
        end

        if obj:IsA("Light") then
            AddSection("LIGHT")
            AddPropRow("Brightness", obj.Brightness, obj, "Brightness", true)
            AddPropRow("Color", tostring(obj.Color), obj, "Color", true)
            AddPropRow("Range", obj.Range, obj, "Range", true)
            AddPropRow("Enabled", obj.Enabled, obj, "Enabled", true)
        end
    end)

    AddSection("CHILDREN ("..#SafeGetChildren(obj)..")")
    for _, ch in ipairs(SafeGetChildren(obj)) do
        local row = Instance.new("TextButton", PropScroll)
        row.Size = UDim2.new(1, -8, 0, 22)
        row.Position = UDim2.new(0, 4, 0, PropY)
        row.BackgroundColor3 = TH.item
        row.BackgroundTransparency = 0.5
        row.BorderSizePixel = 0
        row.Text = "  "..GetIcon(ch.ClassName).."  "..ch.Name.."  ("..ch.ClassName..")"
        row.TextColor3 = TH.text
        row.TextSize = 11
        row.Font = Enum.Font.Gotham
        row.TextXAlignment = Enum.TextXAlignment.Left
        Instance.new("UICorner", row).CornerRadius = UDim.new(0, 4)

        row.MouseButton1Click:Connect(function()
            SelectedInstance = ch
            -- Раскрываем родителей в дереве
            local p = ch.Parent
            while p do ExpandedNodes[p] = true; p = p.Parent end
            RefreshTree()
            ShowProperties(ch)
        end)

        PropY = PropY + 24
    end

    PropScroll.CanvasSize = UDim2.new(0, 0, 0, PropY + 10)
end

-- ════════ КНОПКИ ДЕЙСТВИЙ ════════

CopyPathBtn.MouseButton1Click:Connect(function()
    if SelectedInstance then
        local path = GetFullPath(SelectedInstance)
        local ok = pcall(function() setclipboard(path) end)
        if ok then
            Notify("📋 Path copied!", TH.success)
        else
            Notify("Clipboard not available", TH.warn)
        end
        print("[ULTRA DEX] Path:", path)
    end
end)

DeleteBtn.MouseButton1Click:Connect(function()
    if SelectedInstance then
        local name = SelectedInstance.Name
        local ok = pcall(function() SelectedInstance:Destroy() end)
        if ok then
            Notify("🗑 Deleted: "..name, TH.danger)
            SelectedInstance = nil
            ClearProps()
            PropTitle.Text = "Select an instance"
            RefreshTree()
        else
            Notify("Cannot delete!", TH.warn)
        end
    end
end)

-- ════════ КОНСОЛЬ ════════

local function ExecuteCode(code)
    if code == "" then return end
    local fn, err = loadstring(code)
    if not fn then
        Notify("Error: "..tostring(err), TH.danger)
        warn("[ULTRA DEX] Compile error:", err)
        return
    end
    local ok, result = pcall(fn)
    if not ok then
        Notify("Error: "..tostring(result), TH.danger)
        warn("[ULTRA DEX] Runtime error:", result)
    else
        Notify("✓ Executed", TH.success)
        if result ~= nil then print("[ULTRA DEX] Result:", result) end
    end
end

ExecBtn.MouseButton1Click:Connect(function() ExecuteCode(ConsoleBox.Text) end)
ConsoleBox.FocusLost:Connect(function(enter)
    if enter then ExecuteCode(ConsoleBox.Text) end
end)

-- ════════ ПОИСК ════════

SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
    SearchText = SearchBox.Text
    RefreshTree()
end)

-- ════════ КНОПКА ВЫБОРА МЫШКОЙ ════════

local PickBtn = Instance.new("TextButton", Header)
PickBtn.Size = UDim2.new(0, 60, 0, 24)
PickBtn.Position = UDim2.new(1, -160, 0.5, -12)
PickBtn.BackgroundColor3 = Color3.fromRGB(30, 110, 60)
PickBtn.TextColor3 = Color3.new(1, 1, 1)
PickBtn.Text = "🎯 PICK"
PickBtn.Font = Enum.Font.GothamBold
PickBtn.TextSize = 10
PickBtn.BorderSizePixel = 0
Instance.new("UICorner", PickBtn).CornerRadius = UDim.new(0, 5)

PickBtn.MouseButton1Click:Connect(function()
    Notify("🎯 Click on any object", TH.warn)
    local conn
    conn = UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            conn:Disconnect()
            local target = Mouse.Target
            if target then
                SelectedInstance = target
                local p = target.Parent
                while p do ExpandedNodes[p] = true; p = p.Parent end
                RefreshTree()
                ShowProperties(target)
                Notify("✓ Selected: "..target.Name, TH.success)
            else
                Notify("Nothing selected", TH.warn)
            end
        end
    end)
end)

-- ════════ INPUT ════════

UserInputService.InputBegan:Connect(function(i, gpe)
    if gpe then return end
    if i.KeyCode == Enum.KeyCode.RightControl then
        MainOpen = not MainOpen
    end
end)

-- Видимость
task.spawn(function()
    while DexGui.Parent do
        Main.Visible = MainOpen
        task.wait(0.1)
    end
end)

-- Автообновление дерева раз в 3 сек (для появления новых объектов)
task.spawn(function()
    while DexGui.Parent do
        task.wait(3)
        if MainOpen and SearchText == "" then
            local oldExpanded = ExpandedNodes
            RefreshTree()
        end
    end
end)

-- Старт
RefreshTree()

Notify("🔍 ULTRA DEX loaded! RightCtrl = toggle", TH.success)
print("[ULTRA DEX EXPLORER] Loaded by SkilerBost")
print("[ULTRA DEX] Press RightCtrl to toggle menu")
