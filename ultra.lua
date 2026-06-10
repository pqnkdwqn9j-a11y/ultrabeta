-- =====================================================
-- ULTRA BETA 2026 — OPTIMIZED v4
-- SkilerBost Premium Edition
-- =====================================================

if not game:IsLoaded() then game.Loaded:Wait() end
if getgenv().ULTRA_BETA_LOADED then return end
getgenv().ULTRA_BETA_LOADED = true

local TweenService     = game:GetService("TweenService")
local RunService       = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Players          = game:GetService("Players")
local Workspace        = game:GetService("Workspace")
local CoreGui          = game:GetService("CoreGui")
local Lighting         = game:GetService("Lighting")
local TeleportService  = game:GetService("TeleportService")

local LP    = Players.LocalPlayer
local Cam   = Workspace.CurrentCamera
local Mouse = LP:GetMouse()

-- Кеш функций
local mClamp = math.clamp
local mFloor = math.floor
local mSqrt  = math.sqrt
local mHuge  = math.huge
local mRand  = math.random
local tIns   = table.insert
local V3     = Vector3.new
local V2     = Vector2.new
local CF     = CFrame.new
local CFLook = CFrame.lookAt
local UD2    = UDim2.new
local C3     = Color3.new
local C3RGB  = Color3.fromRGB

repeat task.wait() until LP:FindFirstChild("PlayerGui")

local function GetRoot()
    local ok, r = pcall(function() return gethui() end)
    return (ok and r) or CoreGui
end

for _, g in ipairs(GetRoot():GetChildren()) do
    if tostring(g.Name):find("ULTRA") then pcall(function() g:Destroy() end) end
end

local DrawOK   = pcall(function() local t = Drawing.new("Line"); t:Remove() end)
local HasClick = pcall(function() return mouse1click end)
local HasHook  = pcall(function() return hookmetamethod end) and typeof(hookmetamethod) == "function"
local HasNewCC = pcall(function() return newcclosure end)

-- ════ FOV CIRCLE ════
local FOVCircle = nil
if DrawOK then
    pcall(function()
        FOVCircle = Drawing.new("Circle")
        FOVCircle.Color = C3RGB(0, 220, 255)
        FOVCircle.Thickness = 2
        FOVCircle.NumSides = 50
        FOVCircle.Radius = 200
        FOVCircle.Filled = false
        FOVCircle.Visible = false
        FOVCircle.Transparency = 0.6
    end)
end

-- ════════ ЗАСТАВКА ════════
local BootGui = Instance.new("ScreenGui")
BootGui.Name = "ULTRA_Boot"
BootGui.IgnoreGuiInset = true
BootGui.DisplayOrder = 999999
BootGui.ResetOnSpawn = false
BootGui.Parent = GetRoot()

local Bg = Instance.new("Frame")
Bg.Size = UD2(1,0,1,0)
Bg.BackgroundColor3 = C3RGB(5,5,14)
Bg.BorderSizePixel = 0
Bg.Parent = BootGui

local function MakeRing(size, color, thick)
    local f = Instance.new("Frame", Bg)
    f.Size = UD2(0,size,0,size)
    f.Position = UD2(0.5,-size/2,0.37,-size/2)
    f.BackgroundTransparency = 1
    Instance.new("UICorner",f).CornerRadius = UDim.new(1,0)
    local s = Instance.new("UIStroke",f); s.Color = color; s.Thickness = thick
    return f
end

local R1 = MakeRing(240, C3RGB(0,200,255), 2.5)
local R2 = MakeRing(180, C3RGB(255,50,100), 2)
local R3 = MakeRing(295, C3RGB(130,60,255), 1.2)

local BootActive = true
task.spawn(function()
    while BootActive do
        R1.Rotation = R1.Rotation + 1.3
        R2.Rotation = R2.Rotation - 2
        R3.Rotation = R3.Rotation + 0.8
        task.wait()
    end
end)

local TitleLbl = Instance.new("TextLabel", Bg)
TitleLbl.Size = UD2(0,420,0,95)
TitleLbl.Position = UD2(0.5,-210,0.36,-42)
TitleLbl.BackgroundTransparency = 1
TitleLbl.Text = "ULTRA"
TitleLbl.TextColor3 = C3RGB(0,200,255)
TitleLbl.TextSize = 88
TitleLbl.Font = Enum.Font.GothamBlack

local SubLbl = Instance.new("TextLabel", Bg)
SubLbl.Size = UD2(0,420,0,24)
SubLbl.Position = UD2(0.5,-210,0.36,56)
SubLbl.BackgroundTransparency = 1
SubLbl.Text = "SkilerBost Premium  •  BETA 2026"
SubLbl.TextColor3 = C3RGB(140,140,175)
SubLbl.TextSize = 15
SubLbl.Font = Enum.Font.GothamMedium

-- Вычисления (как раньше)
local Calcs = {
    "0xDEADC0DE", "∑(n²)", "∫f(x)dx", "lim→∞", "Δt=0.016",
    "hookmetamethod", "getgc()", "math.huge", "√256", "sin(π)",
    "RSA-2048", "AES-256", "0xFF", "Vector3.new", "CFrame.new",
    "RaycastResult", "FireServer()", "Matrix4x4", "Quaternion",
    "newcclosure", "readfile()", "writefile()", "0b10101", "∇f(x,y)"
}

task.spawn(function()
    while BootActive do
        local l = Instance.new("TextLabel", Bg)
        l.BackgroundTransparency = 1
        l.Text = Calcs[mRand(1, #Calcs)]
        l.TextColor3 = C3RGB(mRand(80,255), mRand(80,255), mRand(80,255))
        l.TextSize = mRand(11, 18)
        l.Font = Enum.Font.Code
        l.Position = UD2(mRand(3,95)/100, 0, mRand(5,92)/100, 0)
        TweenService:Create(l, TweenInfo.new(3, Enum.EasingStyle.Linear), {
            Position = UD2(l.Position.X.Scale, 0, l.Position.Y.Scale - 0.12, 0),
            TextTransparency = 1
        }):Play()
        task.delay(3, function() pcall(function() l:Destroy() end) end)
        task.wait(0.18)
    end
end)

-- Факты
local Facts = {
    "🎯 Loading aimbot...",
    "🛡️ Loading anti-detect...",
    "👁️ Preparing ESP...",
    "💀 Building hitbox...",
    "⚡ SkilerBost ULTRA...",
    "🔑 Verifying license..."
}

local FactLbl = Instance.new("TextLabel", Bg)
FactLbl.Size = UD2(1,0,0,25)
FactLbl.Position = UD2(0,0,0.85,0)
FactLbl.BackgroundTransparency = 1
FactLbl.TextColor3 = C3RGB(80,180,255)
FactLbl.TextSize = 13
FactLbl.Font = Enum.Font.Gotham
FactLbl.Text = Facts[1]

task.spawn(function()
    local i = 1
    while BootActive do
        FactLbl.Text = Facts[i]
        task.wait(1.5)
        i = i % #Facts + 1
    end
end)

local BarBg = Instance.new("Frame", Bg)
BarBg.Size = UD2(0,440,0,5)
BarBg.Position = UD2(0.5,-220,0.7,0)
BarBg.BackgroundColor3 = C3RGB(18,18,32)
BarBg.BorderSizePixel = 0
Instance.new("UICorner",BarBg).CornerRadius = UDim.new(1,0)

local BarFill = Instance.new("Frame", BarBg)
BarFill.Size = UD2(0,0,1,0)
BarFill.BackgroundColor3 = C3RGB(0,200,255)
BarFill.BorderSizePixel = 0
Instance.new("UICorner",BarFill).CornerRadius = UDim.new(1,0)

local PctLbl = Instance.new("TextLabel", BarBg)
PctLbl.Size = UD2(0,60,0,18)
PctLbl.Position = UD2(0.5,-30,0,9)
PctLbl.BackgroundTransparency = 1
PctLbl.TextColor3 = C3RGB(100,200,255)
PctLbl.TextSize = 12
PctLbl.Font = Enum.Font.GothamMedium
PctLbl.Text = "0%"

TweenService:Create(BarFill, TweenInfo.new(3.5, Enum.EasingStyle.Linear), {Size = UD2(1,0,1,0)}):Play()
task.spawn(function()
    for i = 1, 100 do task.wait(0.035); PctLbl.Text = i.."%" end
end)
task.wait(3.6)

TitleLbl.Text = "LANGUAGE"
TitleLbl.TextSize = 42
SubLbl.Text = "Русский / English"
BarBg.Visible = false
FactLbl.Visible = false
R1.Visible = false
R2.Visible = false
R3.Visible = false

local function MakeLangBtn(text, posX)
    local b = Instance.new("TextButton", Bg)
    b.Size = UD2(0,195,0,56)
    b.Position = UD2(0.5,posX,0.53,0)
    b.BackgroundColor3 = C3RGB(20,20,42)
    b.TextColor3 = C3(1,1,1)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 18
    b.Text = text
    b.BorderSizePixel = 0
    Instance.new("UICorner",b).CornerRadius = UDim.new(0,10)
    Instance.new("UIStroke",b).Color = C3RGB(0,150,255)
    return b
end

local BtnRu = MakeLangBtn("RU Русский", -205)
local BtnEn = MakeLangBtn("EN English", 10)

local Lang = nil
BtnRu.MouseButton1Click:Connect(function() Lang = "ru" end)
BtnEn.MouseButton1Click:Connect(function() Lang = "en" end)
repeat task.wait() until Lang

BootActive = false
TweenService:Create(Bg, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
task.wait(0.5)
BootGui:Destroy()

-- ════ КЛЮЧИ ════
local ValidKeys = {}
for i = 1, 200 do ValidKeys[string.format("ULTRA-BETA-%04d-2026", i)] = true end

local KeyFile = "ULTRA_BETA_KEY.txt"
local SavedKey = nil
pcall(function() if readfile then SavedKey = readfile(KeyFile):gsub("%s+","") end end)

if not (SavedKey and ValidKeys[SavedKey]) then
    local KGui = Instance.new("ScreenGui", GetRoot())
    KGui.Name = "ULTRA_Key"; KGui.IgnoreGuiInset = true
    KGui.DisplayOrder = 999998; KGui.ResetOnSpawn = false

    local KBg = Instance.new("Frame", KGui)
    KBg.Size = UD2(1,0,1,0); KBg.BackgroundColor3 = C3RGB(5,5,15); KBg.BorderSizePixel = 0

    local Panel = Instance.new("Frame", KBg)
    Panel.Size = UD2(0,460,0,320); Panel.Position = UD2(0.5,-230,0.5,-160)
    Panel.BackgroundColor3 = C3RGB(11,11,24); Panel.BorderSizePixel = 0
    Instance.new("UICorner", Panel).CornerRadius = UDim.new(0,14)
    Instance.new("UIStroke", Panel).Color = C3RGB(0,150,255)

    local T1 = Instance.new("TextLabel", Panel)
    T1.Size = UD2(1,0,0,50); T1.Position = UD2(0,0,0,15)
    T1.BackgroundTransparency = 1; T1.Text = "ULTRA BETA"
    T1.TextColor3 = C3RGB(0,200,255); T1.TextSize = 22; T1.Font = Enum.Font.GothamBlack

    local D1 = Instance.new("TextLabel", Panel)
    D1.Size = UD2(1,-30,0,50); D1.Position = UD2(0,15,0,70)
    D1.BackgroundTransparency = 1
    D1.Text = Lang == "ru" and "Введите ключ\nULTRA-BETA-XXXX-2026" or "Enter key\nULTRA-BETA-XXXX-2026"
    D1.TextColor3 = C3RGB(140,140,170); D1.TextSize = 12
    D1.Font = Enum.Font.Gotham; D1.TextWrapped = true

    local IBox = Instance.new("Frame", Panel)
    IBox.Size = UD2(1,-40,0,42); IBox.Position = UD2(0,20,0,140)
    IBox.BackgroundColor3 = C3RGB(8,8,18); IBox.BorderSizePixel = 0
    Instance.new("UICorner", IBox).CornerRadius = UDim.new(0,8)
    Instance.new("UIStroke", IBox).Color = C3RGB(40,40,70)

    local IField = Instance.new("TextBox", IBox)
    IField.Size = UD2(1,-18,1,0); IField.Position = UD2(0,9,0,0)
    IField.BackgroundTransparency = 1; IField.Text = ""
    IField.PlaceholderText = "ULTRA-BETA-0001-2026"
    IField.PlaceholderColor3 = C3RGB(55,55,80)
    IField.TextColor3 = C3RGB(220,220,255)
    IField.TextSize = 15; IField.Font = Enum.Font.Code
    IField.ClearTextOnFocus = false

    local ABtn = Instance.new("TextButton", Panel)
    ABtn.Size = UD2(1,-40,0,42); ABtn.Position = UD2(0,20,0,195)
    ABtn.BackgroundColor3 = C3RGB(0,120,255); ABtn.TextColor3 = C3(1,1,1)
    ABtn.Font = Enum.Font.GothamBold; ABtn.TextSize = 15
    ABtn.Text = Lang == "ru" and "АКТИВИРОВАТЬ" or "ACTIVATE"
    ABtn.BorderSizePixel = 0
    Instance.new("UICorner", ABtn).CornerRadius = UDim.new(0,8)

    local Stat = Instance.new("TextLabel", Panel)
    Stat.Size = UD2(1,-30,0,22); Stat.Position = UD2(0,15,0,250)
    Stat.BackgroundTransparency = 1; Stat.Text = ""
    Stat.TextSize = 12; Stat.Font = Enum.Font.GothamMedium

    local Ok = false
    ABtn.MouseButton1Click:Connect(function()
        local k = IField.Text:gsub("%s+",""):upper()
        if ValidKeys[k] then
            Stat.Text = "OK"; Stat.TextColor3 = C3RGB(0,255,100)
            pcall(function() if writefile then writefile(KeyFile, k) end end)
            task.wait(0.6); Ok = true
        else
            Stat.Text = Lang == "ru" and "Неверный ключ" or "Invalid key"
            Stat.TextColor3 = C3RGB(255,80,80)
        end
    end)
    IField.FocusLost:Connect(function(e) if e then ABtn.MouseButton1Click:Fire() end end)
    repeat task.wait() until Ok
    KGui:Destroy()
end

-- ════ КОНФИГ ════
local C = {
    Aim    = {On=false, Part="Head", FOV=200, Smooth=6, Team=false, Mode="Hold", Pred=0.12, ShowFOV=true},
    Silent = {On=false, Part="Head"},
    ESP    = {On=false, Box=true, Name=true, HP=true, Dist=true, Team=false, Max=2500},
    HB     = {On=false, Size=15, Vis=true},
    Gun    = {RapidFire=false, RapidSpeed=30, AutoFire=false, InfAmmo=false},
    WS     = {On=false, Val=16},
    JP     = {On=false, Val=50},
    NF=false, IJ=false, NC=false,
    Fly    = {On=false, Sp=50},
    MenuOpen = true
}

-- ════ АНТИДЕТЕКТ + SILENT AIM в ОДНОМ хуке (главная оптимизация!) ════
local SilentTarget = nil

if HasHook then
    pcall(function()
        local wrap = HasNewCC and newcclosure or function(f) return f end

        -- ОДИН хук __index вместо двух
        local OldIndex
        OldIndex = hookmetamethod(game, "__index", wrap(function(self, key)
            -- Silent Aim (только если включён И есть цель)
            if C.Silent.On and SilentTarget and self == Mouse then
                if key == "Hit" then return SilentTarget.CFrame end
                if key == "Target" then return SilentTarget end
            end
            -- Антидетект Humanoid
            if (key == "WalkSpeed" or key == "JumpPower") and not checkcaller() then
                if typeof(self) == "Instance" and self:IsA("Humanoid") then
                    if key == "WalkSpeed" then return 16 end
                    if key == "JumpPower" then return 50 end
                end
            end
            return OldIndex(self, key)
        end))

        -- Хук __namecall ТОЛЬКО для Silent Aim
        local OldNamecall
        OldNamecall = hookmetamethod(game, "__namecall", wrap(function(self, ...)
            if C.Silent.On and SilentTarget then
                local method = getnamecallmethod()
                if method == "FireServer" or method == "InvokeServer" then
                    local args = {...}
                    local pos = SilentTarget.Position
                    local cf = SilentTarget.CFrame
                    local changed = false
                    for i, arg in ipairs(args) do
                        if typeof(arg) == "Vector3" then
                            args[i] = pos; changed = true
                        elseif typeof(arg) == "CFrame" then
                            args[i] = cf; changed = true
                        end
                    end
                    if changed then return OldNamecall(self, unpack(args)) end
                end
            end
            return OldNamecall(self, ...)
        end))
    end)
end

-- ════ КЕШ ИГРОКОВ ════
local PCache = {}
local function RebuildCache()
    PCache = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP then tIns(PCache, p) end
    end
end
RebuildCache()
Players.PlayerAdded:Connect(function(plr)
    RebuildCache()
    plr.CharacterAdded:Connect(function()
        task.wait(1.5)
        if C.ESP.On then
            -- создаём ESP только если нужно
            task.spawn(function() CreateESP(plr) end)
        end
    end)
end)
Players.PlayerRemoving:Connect(function(plr)
    RebuildCache()
    RemoveESP(plr)
    RestoreHB(plr)
end)

-- ════ ВСПОМОГАТЕЛЬНЫЕ ════
local function GetPart(char, partName)
    if not char then return nil end
    local p = char:FindFirstChild(partName)
    if p and p:IsA("BasePart") then return p end
    if partName == "Torso" then
        p = char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso")
        if p then return p end
    end
    return char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart")
end

local function GetClosest(fov, partName)
    if not Cam then return nil end
    local best, bestD = nil, fov or mHuge
    local vp = Cam.ViewportSize
    local cx, cy = vp.X * 0.5, vp.Y * 0.5

    for i = 1, #PCache do
        local p = PCache[i]
        if p then
            local ch = p.Character
            if ch then
                local hum = ch:FindFirstChildOfClass("Humanoid")
                if hum and hum.Health > 0 then
                    if not (C.Aim.Team and LP.Team and p.Team == LP.Team) then
                        local part = GetPart(ch, partName or "Head")
                        if part then
                            local sv, onS = Cam:WorldToViewportPoint(part.Position)
                            if onS then
                                local dx = sv.X - cx
                                local dy = sv.Y - cy
                                local d = mSqrt(dx*dx + dy*dy)
                                if d < bestD then bestD = d; best = part end
                            end
                        end
                    end
                end
            end
        end
    end
    return best
end

-- ════ ХИТБОКСЫ ════
local HBData = {}

function RestoreHB(plr)
    local d = HBData[plr]
    if d and d.head and d.head.Parent then
        pcall(function()
            d.head.Size = d.origSize
            d.head.Transparency = d.origTrans
            d.head.Material = d.origMat
            d.head.CanCollide = true
        end)
    end
    HBData[plr] = nil
end

local function ApplyHB(plr)
    if plr == LP or not C.HB.On then RestoreHB(plr); return end
    local ch = plr.Character; if not ch then return end
    local hum = ch:FindFirstChildOfClass("Humanoid")
    if not hum or hum.Health <= 0 then RestoreHB(plr); return end
    local head = ch:FindFirstChild("Head")
    if not head or not head:IsA("BasePart") then return end

    if not HBData[plr] or HBData[plr].head ~= head then
        RestoreHB(plr)
        HBData[plr] = {
            head = head,
            origSize = head.Size,
            origTrans = head.Transparency,
            origMat = head.Material
        }
    end
end

local function CleanAllHB()
    for plr, _ in pairs(HBData) do RestoreHB(plr) end
end

-- ════ ESP ════
local ESPCache = {}

function RemoveESP(plr)
    local d = ESPCache[plr]
    if d then
        pcall(function() if d.hl then d.hl:Destroy() end end)
        pcall(function() if d.bb then d.bb:Destroy() end end)
        ESPCache[plr] = nil
    end
end

local function CleanESP()
    for plr, _ in pairs(ESPCache) do RemoveESP(plr) end
end

function CreateESP(plr)
    if plr == LP then return end
    RemoveESP(plr)
    local ch = plr.Character; if not ch then return end
    local hum = ch:FindFirstChildOfClass("Humanoid")
    local hrp = ch:FindFirstChild("HumanoidRootPart")
    if not hum or not hrp then return end
    local head = ch:FindFirstChild("Head")
    local data = {}

    local hl = Instance.new("Highlight")
    hl.FillColor = C3RGB(255,0,50)
    hl.FillTransparency = 0.5
    hl.OutlineColor = C3RGB(255,255,255)
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.Adornee = ch
    pcall(function() hl.Parent = CoreGui end)
    data.hl = hl

    local bb = Instance.new("BillboardGui")
    bb.Adornee = head or hrp
    bb.Size = UD2(0,200,0,80)
    bb.StudsOffset = V3(0,3.5,0)
    bb.AlwaysOnTop = true
    bb.LightInfluence = 0
    bb.MaxDistance = C.ESP.Max
    pcall(function() bb.Parent = CoreGui end)

    local nl = Instance.new("TextLabel", bb)
    nl.Size = UD2(1,0,0,14); nl.BackgroundTransparency = 1
    nl.TextColor3 = C3(1,1,1); nl.TextStrokeTransparency = 0
    nl.TextSize = 13; nl.Font = Enum.Font.GothamBold
    nl.Text = plr.DisplayName

    local hpBg = Instance.new("Frame", bb)
    hpBg.Size = UD2(0.78,0,0,5); hpBg.Position = UD2(0.11,0,0,18)
    hpBg.BackgroundColor3 = C3RGB(35,35,35); hpBg.BorderSizePixel = 0
    Instance.new("UICorner",hpBg).CornerRadius = UDim.new(1,0)

    local hpFill = Instance.new("Frame", hpBg)
    hpFill.Size = UD2(1,0,1,0); hpFill.BackgroundColor3 = C3RGB(0,255,0); hpFill.BorderSizePixel = 0
    Instance.new("UICorner",hpFill).CornerRadius = UDim.new(1,0)

    local ht = Instance.new("TextLabel", bb)
    ht.Size = UD2(1,0,0,13); ht.Position = UD2(0,0,0,26)
    ht.BackgroundTransparency = 1; ht.TextColor3 = C3RGB(0,255,100)
    ht.TextStrokeTransparency = 0; ht.TextSize = 11
    ht.Font = Enum.Font.GothamMedium; ht.Text = "100 HP"

    local dl = Instance.new("TextLabel", bb)
    dl.Size = UD2(1,0,0,13); dl.Position = UD2(0,0,0,40)
    dl.BackgroundTransparency = 1; dl.TextColor3 = C3RGB(180,180,255)
    dl.TextStrokeTransparency = 0; dl.TextSize = 11
    dl.Font = Enum.Font.Gotham; dl.Text = "0m"

    data.bb = bb; data.nameLbl = nl; data.hpBg = hpBg; data.hpFill = hpFill
    data.hpText = ht; data.distLbl = dl
    ESPCache[plr] = data
end

for _, plr in ipairs(Players:GetPlayers()) do
    if plr ~= LP then
        plr.CharacterAdded:Connect(function()
            task.wait(1.5)
            if C.ESP.On then CreateESP(plr) end
        end)
    end
end

-- ════ GUN ════
local RapidOn, LmbHeld = false, false
local CTools, LastT = {}, 0

local function RefreshTools()
    CTools = {}
    if not LP.Character then return end
    for _, t in ipairs(LP.Character:GetChildren()) do
        if t:IsA("Tool") then
            local evs = {}
            for _, d in ipairs(t:GetDescendants()) do
                if d:IsA("RemoteEvent") then
                    local n = d.Name:lower()
                    if n:find("shoot") or n:find("fire") or n:find("attack") then
                        tIns(evs, d)
                    end
                end
            end
            tIns(CTools, {tool=t, events=evs})
        end
    end
end

local function DoFire()
    if HasClick then pcall(mouse1click) end
    if tick()-LastT > 1 then LastT = tick(); RefreshTools() end
    local mp = Mouse.Hit and Mouse.Hit.Position or Vector3.zero
    for _, e in ipairs(CTools) do
        if e.tool and e.tool.Parent then
            pcall(function() e.tool:Activate() end)
            for _, ev in ipairs(e.events) do pcall(function() ev:FireServer(mp) end) end
        end
    end
end

local function StartRapid()
    if RapidOn then return end
    RapidOn = true
    task.spawn(function()
        while RapidOn do
            if not (C.Gun.RapidFire or (C.Gun.AutoFire and LmbHeld)) then break end
            DoFire()
            task.wait(C.Gun.RapidSpeed/1000)
        end
        RapidOn = false
    end)
end
local function StopRapid() RapidOn = false end

-- ════ FLY ════
local FBV, FBG
local function DoFly(on)
    pcall(function()
        local ch = LP.Character
        local hrp = ch.HumanoidRootPart
        local hum = ch:FindFirstChildOfClass("Humanoid")
        if on then
            hum.PlatformStand = true
            FBV = Instance.new("BodyVelocity"); FBV.Velocity = Vector3.zero
            FBV.MaxForce = Vector3.one * 9e9; FBV.Parent = hrp
            FBG = Instance.new("BodyGyro"); FBG.P = 9e4
            FBG.MaxTorque = Vector3.one * 9e9; FBG.CFrame = hrp.CFrame; FBG.Parent = hrp
        else
            if FBV then FBV:Destroy(); FBV = nil end
            if FBG then FBG:Destroy(); FBG = nil end
            hum.PlatformStand = false
        end
    end)
end

-- ════════ ГЛАВНЫЕ ЦИКЛЫ ════════
local AimActive = false
local HBTimer, NCTimer, ESPTimer, HBApplyTimer = 0, 0, 0, 0

RunService.Heartbeat:Connect(function(dt)
    -- Fly
    if C.Fly.On and FBV and FBG and Cam then
        local mv = Vector3.zero
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then mv = mv + Cam.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then mv = mv - Cam.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then mv = mv - Cam.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then mv = mv + Cam.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then mv = mv + Vector3.yAxis end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then mv = mv - Vector3.yAxis end
        FBV.Velocity = mv * C.Fly.Sp
        FBG.CFrame = Cam.CFrame
    end

    -- Speed / Jump
    local ch = LP.Character
    if ch then
        local hum = ch:FindFirstChildOfClass("Humanoid")
        if hum then
            if C.WS.On then hum.WalkSpeed = C.WS.Val end
            if C.JP.On then hum.JumpPower = C.JP.Val end
            if C.NF then
                hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
                hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
            end
        end

        -- NoClip раз в 0.5 сек
        if C.NC then
            NCTimer = NCTimer + dt
            if NCTimer > 0.5 then
                NCTimer = 0
                for _, p in ipairs(ch:GetDescendants()) do
                    if p:IsA("BasePart") then p.CanCollide = false end
                end
            end
        end
    end

    -- Хитбокс — апдейт размера (только проверка, не перебор)
    if C.HB.On then
        HBTimer = HBTimer + dt
        if HBTimer > 0.2 then -- раз в 0.2 сек
            HBTimer = 0
            local size = C.HB.Size
            local vis = C.HB.Vis
            local sv = V3(size, size, size)
            for plr, d in pairs(HBData) do
                if d.head and d.head.Parent then
                    if d.head.Size.X < size - 0.5 then
                        pcall(function()
                            d.head.Size = sv
                            d.head.Transparency = vis and 0.5 or 1
                            if vis then d.head.Material = Enum.Material.ForceField end
                            d.head.CanCollide = false
                        end)
                    end
                end
            end
        end

        -- Применение хитбокса для новых игроков (раз в 2 сек)
        HBApplyTimer = HBApplyTimer + dt
        if HBApplyTimer > 2 then
            HBApplyTimer = 0
            for i = 1, #PCache do
                if not HBData[PCache[i]] then
                    ApplyHB(PCache[i])
                end
            end
        end
    end
end)

-- RENDERSTEPPED — только то что критично для FPS
RunService.RenderStepped:Connect(function()
    Cam = Workspace.CurrentCamera
    if not Cam then return end

    -- FOV Circle
    if FOVCircle then
        if (C.Aim.On or C.Silent.On) and C.Aim.ShowFOV then
            FOVCircle.Visible = true
            FOVCircle.Radius = C.Aim.FOV
            FOVCircle.Position = V2(Cam.ViewportSize.X * 0.5, Cam.ViewportSize.Y * 0.5)
        else
            FOVCircle.Visible = false
        end
    end

    -- Silent Aim — обновляем цель только раз в 0.05 сек (20 FPS)
    -- Aimbot — нужно каждый кадр для плавности
    if C.Aim.On and (C.Aim.Mode == "Always" or AimActive) then
        local best = GetClosest(C.Aim.FOV, C.Aim.Part)
        if best then
            local tp = best.Position
            if C.Aim.Pred > 0 then
                local vel = best.AssemblyLinearVelocity or Vector3.zero
                if vel.Magnitude > 0 then tp = tp + vel * C.Aim.Pred end
            end
            local smooth = mClamp(1/C.Aim.Smooth, 0.05, 1)
            Cam.CFrame = Cam.CFrame:Lerp(CFLook(Cam.CFrame.Position, tp), smooth)
        end
    end
end)

-- Silent Target update — отдельный таск, реже
task.spawn(function()
    while true do
        if C.Silent.On then
            SilentTarget = GetClosest(C.Aim.FOV, C.Silent.Part)
        else
            SilentTarget = nil
        end
        task.wait(0.05)
    end
end)

-- ESP — отдельный цикл, обновление 8 раз в секунду
task.spawn(function()
    while true do
        if C.ESP.On then
            local myHRP = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
            for plr, data in pairs(ESPCache) do
                local ch = plr.Character
                if not ch then
                    if data.hl then data.hl.Enabled = false end
                    if data.bb then data.bb.Enabled = false end
                else
                    local hum = ch:FindFirstChildOfClass("Humanoid")
                    local hrp = ch:FindFirstChild("HumanoidRootPart")
                    if not hum or not hrp then
                        if data.hl then data.hl.Enabled = false end
                        if data.bb then data.bb.Enabled = false end
                    elseif C.ESP.Team and LP.Team and plr.Team == LP.Team then
                        if data.hl then data.hl.Enabled = false end
                        if data.bb then data.bb.Enabled = false end
                    else
                        local dist = myHRP and (myHRP.Position - hrp.Position).Magnitude or 0
                        if dist > C.ESP.Max then
                            if data.hl then data.hl.Enabled = false end
                            if data.bb then data.bb.Enabled = false end
                        else
                            local pct = hum.Health / math.max(hum.MaxHealth, 1)
                            if data.hl then
                                data.hl.Enabled = C.ESP.Box
                                data.hl.FillColor = pct > 0.6 and C3RGB(0,200,80) or (pct > 0.3 and C3RGB(255,180,0) or C3RGB(255,40,40))
                            end
                            if data.bb then
                                data.bb.Enabled = true
                                if data.nameLbl then data.nameLbl.Visible = C.ESP.Name end
                                if data.hpBg then data.hpBg.Visible = C.ESP.HP end
                                if data.hpFill then
                                    data.hpFill.Size = UD2(mClamp(pct,0,1),0,1,0)
                                    data.hpFill.BackgroundColor3 = pct > 0.6 and C3RGB(0,255,0) or (pct > 0.3 and C3RGB(255,200,0) or C3RGB(255,50,50))
                                end
                                if data.hpText then
                                    data.hpText.Visible = C.ESP.HP
                                    data.hpText.Text = mFloor(hum.Health).."/"..mFloor(hum.MaxHealth).." HP"
                                end
                                if data.distLbl then
                                    data.distLbl.Visible = C.ESP.Dist
                                    data.distLbl.Text = mFloor(dist).."m"
                                end
                            end
                        end
                    end
                end
            end
        else
            for _, data in pairs(ESPCache) do
                if data.hl then data.hl.Enabled = false end
                if data.bb then data.bb.Enabled = false end
            end
        end
        task.wait(0.125) -- 8 FPS обновление ESP
    end
end)

-- ════ INPUT ════
UserInputService.InputBegan:Connect(function(i, gpe)
    if gpe then return end
    if i.UserInputType == Enum.UserInputType.MouseButton2 then
        if C.Aim.Mode == "Hold" then AimActive = true
        elseif C.Aim.Mode == "Toggle" then AimActive = not AimActive end
        if C.Gun.RapidFire then StartRapid() end
    end
    if i.UserInputType == Enum.UserInputType.MouseButton1 then
        LmbHeld = true
        if C.Gun.AutoFire then StartRapid() end
    end
    if C.IJ and i.KeyCode == Enum.KeyCode.Space and LP.Character then
        pcall(function() LP.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping) end)
    end
    if i.KeyCode == Enum.KeyCode.RightShift then C.MenuOpen = not C.MenuOpen end
end)

UserInputService.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton2 then
        if C.Aim.Mode == "Hold" then AimActive = false end
        if C.Gun.RapidFire then StopRapid() end
    end
    if i.UserInputType == Enum.UserInputType.MouseButton1 then
        LmbHeld = false
        if C.Gun.AutoFire then StopRapid() end
    end
end)

LP.CharacterAdded:Connect(function()
    CTools = {}; LastT = 0
    if C.Fly.On then task.wait(1); DoFly(true) end
end)

-- ════════ МЕНЮ ════════
local TH = {
    bg=C3RGB(9,9,20), hdr=C3RGB(7,7,16),
    item=C3RGB(16,16,34), accent=C3RGB(0,170,255),
    text=C3RGB(215,215,238), dim=C3RGB(105,105,140),
    togOn=C3RGB(0,210,100), togOff=C3RGB(42,42,62),
    slBg=C3RGB(22,22,44), slFg=C3RGB(0,170,255),
    sec=C3RGB(0,170,255)
}

local L = Lang == "ru" and {
    tabs={"Боевой","Оружие","Визуал","Движение","Инфо"},
    aimOn="Аимбот (камера)", aMode="Режим", aPart="Часть",
    aFOV="Радиус FOV", aSmooth="Плавность", aPred="Предсказание",
    aFovC="Круг FOV", aTeam="Команда",
    silOn="Silent Aim", silPart="Часть Silent",
    hbOn="Хитбокс головы", hbSz="Размер", hbVis="Красный",
    espOn="Включить ESP", espBox="Обводка", espName="Имя",
    espHP="HP", espDist="Дистанция", espMax="Макс. дистанция",
    fb="Полная яркость",
    wsOn="WalkSpeed", wsVal="Значение", jpOn="JumpPower", jpVal="Значение",
    nf="Без урона", ij="Беск. прыжок", nc="NoClip",
    flyOn="Полёт", flySp="Скорость",
    gAmmo="Беск. патроны", gRap="Rapid Fire", gAuto="Auto Fire",
    gSpd="Скорость (мс)", gTest="Тест",
    unload="Выгрузить", rejoin="Перезайти"
} or {
    tabs={"Combat","Gun","Visual","Move","Info"},
    aimOn="Aimbot (camera)", aMode="Mode", aPart="Part",
    aFOV="FOV Radius", aSmooth="Smoothness", aPred="Prediction",
    aFovC="FOV Circle", aTeam="Team Check",
    silOn="Silent Aim", silPart="Silent Part",
    hbOn="Head Hitbox", hbSz="Size", hbVis="Red overlay",
    espOn="Enable ESP", espBox="Highlight", espName="Name",
    espHP="HP Bar", espDist="Distance", espMax="Max Distance",
    fb="FullBright",
    wsOn="WalkSpeed", wsVal="Value", jpOn="JumpPower", jpVal="Value",
    nf="No Fall Damage", ij="Inf Jump", nc="Noclip",
    flyOn="Fly", flySp="Speed",
    gAmmo="Inf Ammo", gRap="Rapid Fire", gAuto="Auto Fire",
    gSpd="Speed (ms)", gTest="Test Fire",
    unload="Unload", rejoin="Rejoin"
}

local MenuGui = Instance.new("ScreenGui", GetRoot())
MenuGui.Name = "ULTRA_Menu"
MenuGui.IgnoreGuiInset = true
MenuGui.DisplayOrder = 10000
MenuGui.ResetOnSpawn = false

local Win = Instance.new("Frame", MenuGui)
Win.Size = UD2(0,530,0,500)
Win.Position = UD2(0.5,-265,0.5,-250)
Win.BackgroundColor3 = TH.bg
Win.BorderSizePixel = 0
Win.Active = true
Win.Draggable = true
Instance.new("UICorner", Win).CornerRadius = UDim.new(0,12)
Instance.new("UIStroke", Win).Color = TH.accent

local Hdr = Instance.new("Frame", Win)
Hdr.Size = UD2(1,0,0,40)
Hdr.BackgroundColor3 = TH.hdr
Hdr.BorderSizePixel = 0
Instance.new("UICorner", Hdr).CornerRadius = UDim.new(0,12)

local HT = Instance.new("TextLabel", Hdr)
HT.Size = UD2(0,200,1,0); HT.Position = UD2(0,14,0,0)
HT.BackgroundTransparency = 1; HT.Text = "ULTRA BETA"
HT.TextColor3 = TH.accent; HT.TextSize = 18
HT.Font = Enum.Font.GothamBlack; HT.TextXAlignment = Enum.TextXAlignment.Left

local CB = Instance.new("TextButton", Hdr)
CB.Size = UD2(0,28,0,28); CB.Position = UD2(1,-34,0.5,-14)
CB.BackgroundColor3 = C3RGB(55,15,15); CB.TextColor3 = C3(1,1,1)
CB.Text = "X"; CB.TextSize = 13; CB.Font = Enum.Font.GothamBold
CB.BorderSizePixel = 0
Instance.new("UICorner", CB).CornerRadius = UDim.new(0,6)
CB.MouseButton1Click:Connect(function() C.MenuOpen = false end)

local TB = Instance.new("Frame", Win)
TB.Size = UD2(1,0,0,30); TB.Position = UD2(0,0,0,40)
TB.BackgroundColor3 = C3RGB(7,7,16); TB.BorderSizePixel = 0
Instance.new("UIListLayout", TB).FillDirection = Enum.FillDirection.Horizontal

local Content = Instance.new("ScrollingFrame", Win)
Content.Size = UD2(1,-6,1,-76); Content.Position = UD2(0,3,0,72)
Content.BackgroundTransparency = 1; Content.BorderSizePixel = 0
Content.ScrollBarThickness = 3; Content.ScrollBarImageColor3 = TH.accent
Content.CanvasSize = UD2(0,0,0,0)

local Y = 0
local function RC() for _,c in ipairs(Content:GetChildren()) do c:Destroy() end; Y=6 end
local function SC() Content.CanvasSize = UD2(0,0,0,Y+14) end

local function Sec(text)
    local f = Instance.new("Frame", Content)
    f.Size = UD2(1,-16,0,20); f.Position = UD2(0,8,0,Y); f.BackgroundTransparency = 1
    local ln = Instance.new("Frame", f); ln.Size = UD2(1,0,0,1); ln.Position = UD2(0,0,0.5,0)
    ln.BackgroundColor3 = TH.sec; ln.BackgroundTransparency = 0.65; ln.BorderSizePixel = 0
    local lb = Instance.new("TextLabel", f); lb.AutomaticSize = Enum.AutomaticSize.X
    lb.Size = UD2(0,0,1,0); lb.Position = UD2(0,4,0,0); lb.BackgroundColor3 = TH.bg
    lb.BorderSizePixel = 0; lb.Text = "  "..text.."  "
    lb.TextColor3 = TH.sec; lb.TextSize = 11; lb.Font = Enum.Font.GothamBold
    Y = Y + 24
end

local function Tog(text, state, cb)
    local f = Instance.new("Frame", Content)
    f.Size = UD2(1,-16,0,30); f.Position = UD2(0,8,0,Y)
    f.BackgroundColor3 = TH.item; f.BorderSizePixel = 0
    Instance.new("UICorner", f).CornerRadius = UDim.new(0,7)
    local lb = Instance.new("TextLabel", f); lb.Size = UD2(1,-58,1,0); lb.Position = UD2(0,10,0,0)
    lb.BackgroundTransparency = 1; lb.Text = text; lb.TextColor3 = TH.text
    lb.TextSize = 12; lb.Font = Enum.Font.Gotham; lb.TextXAlignment = Enum.TextXAlignment.Left
    local tbg = Instance.new("Frame", f); tbg.Size = UD2(0,38,0,19); tbg.Position = UD2(1,-46,0.5,-9.5)
    tbg.BackgroundColor3 = state and TH.togOn or TH.togOff; tbg.BorderSizePixel = 0
    Instance.new("UICorner", tbg).CornerRadius = UDim.new(1,0)
    local dot = Instance.new("Frame", tbg); dot.Size = UD2(0,15,0,15)
    dot.Position = state and UD2(1,-17,0.5,-7.5) or UD2(0,2,0.5,-7.5)
    dot.BackgroundColor3 = C3(1,1,1); dot.BorderSizePixel = 0
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1,0)
    local cur = state
    local btn = Instance.new("TextButton", f); btn.Size = UD2(1,0,1,0); btn.BackgroundTransparency = 1; btn.Text = ""
    btn.MouseButton1Click:Connect(function()
        cur = not cur
        TweenService:Create(tbg, TweenInfo.new(0.15), {BackgroundColor3 = cur and TH.togOn or TH.togOff}):Play()
        TweenService:Create(dot, TweenInfo.new(0.15), {Position = cur and UD2(1,-17,0.5,-7.5) or UD2(0,2,0.5,-7.5)}):Play()
        cb(cur)
    end)
    Y = Y + 33
end

local function Sld(text, mn, mx, def, cb)
    local f = Instance.new("Frame", Content)
    f.Size = UD2(1,-16,0,46); f.Position = UD2(0,8,0,Y)
    f.BackgroundColor3 = TH.item; f.BorderSizePixel = 0
    Instance.new("UICorner", f).CornerRadius = UDim.new(0,7)
    local lb = Instance.new("TextLabel", f); lb.Size = UD2(0.65,0,0,18); lb.Position = UD2(0,10,0,3)
    lb.BackgroundTransparency = 1; lb.Text = text; lb.TextColor3 = TH.text
    lb.TextSize = 11; lb.Font = Enum.Font.Gotham; lb.TextXAlignment = Enum.TextXAlignment.Left
    local vl = Instance.new("TextLabel", f); vl.Size = UD2(0.32,0,0,18); vl.Position = UD2(0.66,0,0,3)
    vl.BackgroundTransparency = 1; vl.Text = tostring(def); vl.TextColor3 = TH.accent
    vl.TextSize = 13; vl.Font = Enum.Font.GothamBold; vl.TextXAlignment = Enum.TextXAlignment.Right
    local sbg = Instance.new("Frame", f); sbg.Size = UD2(1,-20,0,7); sbg.Position = UD2(0,10,0,29)
    sbg.BackgroundColor3 = TH.slBg; sbg.BorderSizePixel = 0
    Instance.new("UICorner", sbg).CornerRadius = UDim.new(1,0)
    local sfl = Instance.new("Frame", sbg); sfl.Size = UD2(mClamp((def-mn)/(mx-mn),0,1),0,1,0)
    sfl.BackgroundColor3 = TH.slFg; sfl.BorderSizePixel = 0
    Instance.new("UICorner", sfl).CornerRadius = UDim.new(1,0)
    local dr = false
    local sb = Instance.new("TextButton", sbg); sb.Size = UD2(1,0,3,4); sb.Position = UD2(0,0,-1,0)
    sb.BackgroundTransparency = 1; sb.Text = ""
    local function upd(mx2)
        local abs = sbg.AbsolutePosition; local sz = sbg.AbsoluteSize
        local rel = mClamp((mx2-abs.X)/sz.X, 0, 1)
        local val = mFloor(mn + (mx-mn) * rel)
        sfl.Size = UD2(rel,0,1,0); vl.Text = tostring(val); cb(val)
    end
    sb.MouseButton1Down:Connect(function() dr = true end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then dr = false end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if dr and i.UserInputType == Enum.UserInputType.MouseMovement then upd(i.Position.X) end
    end)
    sb.MouseButton1Click:Connect(function() upd(UserInputService:GetMouseLocation().X) end)
    Y = Y + 49
end

local function Drp(text, opts, def, cb)
    local f = Instance.new("Frame", Content)
    f.Size = UD2(1,-16,0,30); f.Position = UD2(0,8,0,Y)
    f.BackgroundColor3 = TH.item; f.BorderSizePixel = 0
    Instance.new("UICorner", f).CornerRadius = UDim.new(0,7)
    local lb = Instance.new("TextLabel", f); lb.Size = UD2(0.5,0,1,0); lb.Position = UD2(0,10,0,0)
    lb.BackgroundTransparency = 1; lb.Text = text; lb.TextColor3 = TH.text
    lb.TextSize = 12; lb.Font = Enum.Font.Gotham; lb.TextXAlignment = Enum.TextXAlignment.Left
    local idx = 1
    for i, o in ipairs(opts) do if o == def then idx = i end end
    local btn = Instance.new("TextButton", f); btn.Size = UD2(0.46,0,0,22); btn.Position = UD2(0.52,0,0.5,-11)
    btn.BackgroundColor3 = C3RGB(24,24,46); btn.TextColor3 = TH.accent
    btn.TextSize = 11; btn.Font = Enum.Font.GothamMedium
    btn.Text = "< "..opts[idx].." >"; btn.BorderSizePixel = 0
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,5)
    btn.MouseButton1Click:Connect(function()
        idx = idx % #opts + 1
        btn.Text = "< "..opts[idx].." >"; cb(opts[idx])
    end)
    Y = Y + 33
end

local function Btn(text, col, cb)
    local b = Instance.new("TextButton", Content)
    b.Size = UD2(1,-16,0,34); b.Position = UD2(0,8,0,Y)
    b.BackgroundColor3 = col or TH.item; b.TextColor3 = TH.text
    b.TextSize = 12; b.Font = Enum.Font.GothamMedium
    b.Text = text; b.BorderSizePixel = 0
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,7)
    b.MouseButton1Click:Connect(cb)
    Y = Y + 37
end

local Pages = {}

Pages.Combat = function()
    Sec("AIMBOT")
    Tog(L.aimOn, false, function(v) C.Aim.On = v end)
    Drp(L.aMode, {"Hold","Toggle","Always"}, "Hold", function(v) C.Aim.Mode = v end)
    Drp(L.aPart, {"Head","HumanoidRootPart","Torso"}, "Head", function(v) C.Aim.Part = v end)
    Sld(L.aFOV, 50, 800, 200, function(v) C.Aim.FOV = v end)
    Sld(L.aSmooth, 1, 20, 6, function(v) C.Aim.Smooth = v end)
    Sld(L.aPred, 0, 50, 12, function(v) C.Aim.Pred = v/100 end)
    Tog(L.aFovC, true, function(v) C.Aim.ShowFOV = v end)
    Tog(L.aTeam, false, function(v) C.Aim.Team = v end)
    Sec("SILENT AIM")
    Tog(L.silOn, false, function(v) C.Silent.On = v end)
    Drp(L.silPart, {"Head","HumanoidRootPart","Torso"}, "Head", function(v) C.Silent.Part = v end)
    Sec("HITBOX")
    Tog(L.hbOn, false, function(v)
        C.HB.On = v
        if v then for i=1,#PCache do ApplyHB(PCache[i]) end
        else CleanAllHB() end
    end)
    Sld(L.hbSz, 5, 30, 15, function(v) C.HB.Size = v end)
    Tog(L.hbVis, true, function(v) C.HB.Vis = v end)
end

Pages.Gun = function()
    Sec("AMMO")
    Tog(L.gAmmo, false, function(v) C.Gun.InfAmmo = v end)
    Sec("RAPID FIRE")
    Tog(L.gRap, false, function(v) C.Gun.RapidFire = v; if not v then StopRapid() end end)
    Tog(L.gAuto, false, function(v) C.Gun.AutoFire = v; if not v then StopRapid() end end)
    Sld(L.gSpd, 10, 200, 30, function(v) C.Gun.RapidSpeed = v end)
    Btn("▶ "..L.gTest, TH.item, DoFire)
end

Pages.Visual = function()
    Sec("ESP")
    Tog(L.espOn, false, function(v)
        C.ESP.On = v
        if v then for i=1,#PCache do if PCache[i].Character then CreateESP(PCache[i]) end end
        else CleanESP() end
    end)
    Tog(L.espBox, true, function(v) C.ESP.Box = v end)
    Tog(L.espName, true, function(v) C.ESP.Name = v end)
    Tog(L.espHP, true, function(v) C.ESP.HP = v end)
    Tog(L.espDist, true, function(v) C.ESP.Dist = v end)
    Sld(L.espMax, 100, 5000, 2500, function(v) C.ESP.Max = v end)
    Sec("WORLD")
    Tog(L.fb, false, function(v) pcall(function()
        if v then
            Lighting.Brightness = 3; Lighting.ClockTime = 14
            Lighting.FogEnd = 1e9; Lighting.GlobalShadows = false
            Lighting.Ambient = C3RGB(180,180,180)
        else
            Lighting.GlobalShadows = true; Lighting.Brightness = 1
            Lighting.Ambient = C3(0,0,0)
        end
    end) end)
end

Pages.Move = function()
    Sec("SPEED")
    Tog(L.wsOn, false, function(v) C.WS.On = v end)
    Sld(L.wsVal, 16, 200, 16, function(v) C.WS.Val = v end)
    Tog(L.jpOn, false, function(v) C.JP.On = v end)
    Sld(L.jpVal, 50, 300, 50, function(v) C.JP.Val = v end)
    Sec("MISC")
    Tog(L.nf, false, function(v) C.NF = v end)
    Tog(L.ij, false, function(v) C.IJ = v end)
    Tog(L.nc, false, function(v) C.NC = v end)
    Sec("FLY")
    Tog(L.flyOn, false, function(v) C.Fly.On = v; DoFly(v) end)
    Sld(L.flySp, 10, 300, 50, function(v) C.Fly.Sp = v end)
end

Pages.Info = function()
    Sec("ACTIONS")
    Btn(L.rejoin, C3RGB(18,38,75), function() TeleportService:Teleport(game.PlaceId, LP) end)
    Btn(L.unload, C3RGB(48,14,14), function()
        StopRapid(); CleanAllHB(); CleanESP(); DoFly(false)
        if FOVCircle then pcall(function() FOVCircle:Remove() end) end
        SilentTarget = nil
        MenuGui:Destroy()
        getgenv().ULTRA_BETA_LOADED = nil
    end)
    Sec("INFO")
    local info = Instance.new("TextLabel", Content)
    info.Size = UD2(1,-16,0,120); info.Position = UD2(0,8,0,Y)
    info.BackgroundColor3 = C3RGB(13,11,26); info.BorderSizePixel = 0
    Instance.new("UICorner", info).CornerRadius = UDim.new(0,7)
    info.Text = "ULTRA BETA 2026\nSkilerBost Premium\n\nOPTIMIZED v4:\n- ESP в отдельном task\n- Один __index hook\n- Кеш игроков\n\nRightShift = меню"
    info.TextColor3 = TH.dim; info.TextSize = 11
    info.Font = Enum.Font.Gotham; info.TextWrapped = true
    info.TextYAlignment = Enum.TextYAlignment.Top
    Y = Y + 125
end

local PageKeys = {"Combat","Gun","Visual","Move","Info"}
local TabBtns = {}

for i, k in ipairs(PageKeys) do
    local tb = Instance.new("TextButton", TB)
    tb.Size = UD2(1/#PageKeys, 0, 1, 0)
    tb.BackgroundColor3 = i == 1 and TH.accent or C3RGB(10,10,20)
    tb.BackgroundTransparency = i == 1 and 0 or 0.4
    tb.TextColor3 = C3(1,1,1); tb.TextSize = 11
    tb.Font = Enum.Font.GothamMedium; tb.Text = L.tabs[i]
    tb.BorderSizePixel = 0; tb.LayoutOrder = i
    TabBtns[k] = tb
    tb.MouseButton1Click:Connect(function()
        for n, b in pairs(TabBtns) do
            b.BackgroundColor3 = n == k and TH.accent or C3RGB(10,10,20)
            b.BackgroundTransparency = n == k and 0 or 0.4
        end
        RC()
        if Pages[k] then Pages[k]() end
        SC()
    end)
end

RC(); Pages.Combat(); SC()

task.spawn(function()
    while MenuGui.Parent do
        Win.Visible = C.MenuOpen
        task.wait(0.15)
    end
end)

print("[ULTRA BETA 2026] v4 OPTIMIZED Loaded!")
print("[ULTRA BETA 2026] Hooks: "..(HasHook and "OK" or "DISABLED"))
print("[ULTRA BETA 2026] RightShift = menu")
