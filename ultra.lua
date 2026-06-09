-- =====================================================
-- ULTRA BETA 2026 — FULL SINGLE FILE
-- SkilerBost Premium Edition
-- loadstring(game:HttpGet("YOUR_RAW_LINK"))()
-- =====================================================

if not game:IsLoaded() then game.Loaded:Wait() end
if getgenv().ULTRA_BETA_LOADED then return end
getgenv().ULTRA_BETA_LOADED = true

-- ══ СЕРВИСЫ ══
local TweenService      = game:GetService("TweenService")
local RunService        = game:GetService("RunService")
local UserInputService  = game:GetService("UserInputService")
local Players           = game:GetService("Players")
local Workspace         = game:GetService("Workspace")
local CoreGui           = game:GetService("CoreGui")
local Lighting          = game:GetService("Lighting")
local TeleportService   = game:GetService("TeleportService")
local HttpService       = game:GetService("HttpService")

local LP    = Players.LocalPlayer
local Cam   = Workspace.CurrentCamera
local Mouse = LP:GetMouse()

repeat task.wait() until LP:FindFirstChild("PlayerGui")

-- ══ ROOT ══
local function GetRoot()
    local ok, r = pcall(function() return gethui() end)
    return (ok and r) or CoreGui
end

-- Чистка
for _, g in ipairs(GetRoot():GetChildren()) do
    if tostring(g.Name):find("ULTRA") then pcall(function() g:Destroy() end) end
end

-- ══ ПРОВЕРКИ ══
local DrawOK   = pcall(function() local t = Drawing.new("Line"); t:Remove() end)
local HasClick = pcall(function() return mouse1click end)
local HasGC    = pcall(function() return getgc end) and typeof(getgc) == "function"
local HasHook  = pcall(function() return hookmetamethod end) and typeof(hookmetamethod) == "function"
local HasNewCC = pcall(function() return newcclosure end)

-- ══════════════════════════════════════════════════════════════
-- FOV CIRCLE (первым делом!)
-- ══════════════════════════════════════════════════════════════
local FOVCircle = nil
if DrawOK then
    pcall(function()
        FOVCircle = Drawing.new("Circle")
        FOVCircle.Color       = Color3.fromRGB(0, 220, 255)
        FOVCircle.Thickness   = 2
        FOVCircle.NumSides    = 100
        FOVCircle.Radius      = 200
        FOVCircle.Filled      = false
        FOVCircle.Visible     = false
        FOVCircle.Transparency = 0.5
    end)
end

-- ══════════════════════════════════════════════════════════════
-- ЗАСТАВКА
-- ══════════════════════════════════════════════════════════════
local BootGui = Instance.new("ScreenGui")
BootGui.Name           = "ULTRA_Boot"
BootGui.IgnoreGuiInset = true
BootGui.DisplayOrder   = 999999
BootGui.ResetOnSpawn   = false
BootGui.Parent         = GetRoot()

local Bg = Instance.new("Frame")
Bg.Size             = UDim2.new(1,0,1,0)
Bg.BackgroundColor3 = Color3.fromRGB(5,5,14)
Bg.BorderSizePixel  = 0
Bg.Parent           = BootGui

local function MakeRing(size, color, thick)
    local f = Instance.new("Frame", Bg)
    f.Size                  = UDim2.new(0,size,0,size)
    f.Position              = UDim2.new(0.5,-size/2, 0.37,-size/2)
    f.BackgroundTransparency = 1
    Instance.new("UICorner",f).CornerRadius = UDim.new(1,0)
    local s = Instance.new("UIStroke",f)
    s.Color     = color
    s.Thickness = thick
    return f
end

local Ring1 = MakeRing(240, Color3.fromRGB(0,200,255),   2.5)
local Ring2 = MakeRing(180, Color3.fromRGB(255,50,100),  2)
local Ring3 = MakeRing(295, Color3.fromRGB(130,60,255),  1.2)

task.spawn(function()
    while BootGui.Parent do
        Ring1.Rotation = Ring1.Rotation + 1.3
        Ring2.Rotation = Ring2.Rotation - 2
        Ring3.Rotation = Ring3.Rotation + 0.8
        task.wait()
    end
end)

local TitleLbl = Instance.new("TextLabel", Bg)
TitleLbl.Size               = UDim2.new(0,420,0,95)
TitleLbl.Position           = UDim2.new(0.5,-210,0.36,-42)
TitleLbl.BackgroundTransparency = 1
TitleLbl.Text               = "ULTRA"
TitleLbl.TextColor3         = Color3.fromRGB(0,200,255)
TitleLbl.TextSize           = 88
TitleLbl.Font               = Enum.Font.GothamBlack

local SubLbl = Instance.new("TextLabel", Bg)
SubLbl.Size                 = UDim2.new(0,420,0,24)
SubLbl.Position             = UDim2.new(0.5,-210,0.36,56)
SubLbl.BackgroundTransparency = 1
SubLbl.Text                 = "SkilerBost Premium  •  BETA 2026"
SubLbl.TextColor3           = Color3.fromRGB(140,140,175)
SubLbl.TextSize             = 15
SubLbl.Font                 = Enum.Font.GothamMedium

task.spawn(function()
    while BootGui.Parent do
        TweenService:Create(TitleLbl,TweenInfo.new(1.6,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),
            {TextColor3=Color3.fromRGB(80,140,255)}):Play()
        task.wait(1.6)
        TweenService:Create(TitleLbl,TweenInfo.new(1.6,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),
            {TextColor3=Color3.fromRGB(0,220,255)}):Play()
        task.wait(1.6)
    end
end)

-- Плавающие вычисления
local Calcs = {
    "0xDEADC0DE","∑(n²)","∫f(x)dx","lim→∞","Δt=0.016","hookmetamethod",
    "getgc()","math.huge","√256","sin(π)","RSA-2048","AES-256","0xFF",
    "Vector3.new","CFrame.new","RaycastResult","FireServer()","Matrix4x4",
    "Quaternion","newcclosure","readfile()","writefile()","0b10101","∇f(x,y)"
}

task.spawn(function()
    while BootGui.Parent do
        local l = Instance.new("TextLabel", Bg)
        l.BackgroundTransparency = 1
        l.Text      = Calcs[math.random(1,#Calcs)]
        l.TextColor3 = Color3.fromRGB(math.random(80,255),math.random(80,255),math.random(80,255))
        l.TextSize  = math.random(11,18)
        l.Font      = Enum.Font.Code
        l.Position  = UDim2.new(math.random(3,95)/100,0,math.random(5,92)/100,0)
        TweenService:Create(l,TweenInfo.new(3.5,Enum.EasingStyle.Linear),{
            Position         = UDim2.new(l.Position.X.Scale,0,l.Position.Y.Scale-0.13,0),
            TextTransparency = 1
        }):Play()
        task.delay(3.6, function() pcall(function() l:Destroy() end) end)
        task.wait(0.17)
    end
end)

-- Факты
local Facts = {
    "🎯 Initializing aimbot engine...","🛡️ Loading anti-detect...","👁️ Preparing ESP...",
    "💀 Building hitbox overlay...","⚡ ULTRA BETA 2026...","🔑 Verifying license...",
    "⚠️ BETA: Updates coming soon!"
}
local FactLbl = Instance.new("TextLabel", Bg)
FactLbl.Size               = UDim2.new(1,0,0,26)
FactLbl.Position           = UDim2.new(0,0,0.84,0)
FactLbl.BackgroundTransparency = 1
FactLbl.TextColor3         = Color3.fromRGB(80,180,255)
FactLbl.TextSize           = 13
FactLbl.Font               = Enum.Font.Gotham
FactLbl.Text               = Facts[1]

task.spawn(function()
    local i = 1
    while BootGui.Parent do
        TweenService:Create(FactLbl,TweenInfo.new(0.4),{TextTransparency=0}):Play()
        FactLbl.Text = Facts[i]
        task.wait(2.2)
        TweenService:Create(FactLbl,TweenInfo.new(0.4),{TextTransparency=1}):Play()
        task.wait(0.5)
        i = i%#Facts+1
    end
end)

-- Прогресс бар
local BarBg = Instance.new("Frame", Bg)
BarBg.Size              = UDim2.new(0,450,0,6)
BarBg.Position          = UDim2.new(0.5,-225,0.7,0)
BarBg.BackgroundColor3  = Color3.fromRGB(18,18,34)
BarBg.BorderSizePixel   = 0
Instance.new("UICorner",BarBg).CornerRadius = UDim.new(1,0)

local BarFill = Instance.new("Frame", BarBg)
BarFill.Size            = UDim2.new(0,0,1,0)
BarFill.BackgroundColor3 = Color3.fromRGB(0,200,255)
BarFill.BorderSizePixel = 0
Instance.new("UICorner",BarFill).CornerRadius = UDim.new(1,0)

local PctLbl = Instance.new("TextLabel", BarBg)
PctLbl.Size             = UDim2.new(0,60,0,20)
PctLbl.Position         = UDim2.new(0.5,-30,0,10)
PctLbl.BackgroundTransparency = 1
PctLbl.TextColor3       = Color3.fromRGB(100,200,255)
PctLbl.TextSize         = 13
PctLbl.Font             = Enum.Font.GothamMedium
PctLbl.Text             = "0%"

TweenService:Create(BarFill,TweenInfo.new(4.5,Enum.EasingStyle.Linear),{Size=UDim2.new(1,0,1,0)}):Play()
task.spawn(function()
    for i = 1,100 do task.wait(0.045); PctLbl.Text = i.."%" end
end)

task.wait(5)

-- ══ ВЫБОР ЯЗЫКА ══
TitleLbl.Text     = "SELECT LANGUAGE"
TitleLbl.TextSize = 42
SubLbl.Text       = "Выберите язык  /  Choose language"
BarBg.Visible     = false
FactLbl.Visible   = false
Ring1.Visible     = false
Ring2.Visible     = false
Ring3.Visible     = false

local function MakeLangBtn(text, posX)
    local b = Instance.new("TextButton", Bg)
    b.Size              = UDim2.new(0,195,0,56)
    b.Position          = UDim2.new(0.5,posX,0.53,0)
    b.BackgroundColor3  = Color3.fromRGB(20,20,42)
    b.TextColor3        = Color3.new(1,1,1)
    b.Font              = Enum.Font.GothamBold
    b.TextSize          = 18
    b.Text              = text
    b.BorderSizePixel   = 0
    Instance.new("UICorner",b).CornerRadius = UDim.new(0,10)
    local st = Instance.new("UIStroke",b)
    st.Color = Color3.fromRGB(0,150,255); st.Thickness = 1.5
    b.MouseEnter:Connect(function()
        TweenService:Create(b,TweenInfo.new(0.15),{BackgroundColor3=Color3.fromRGB(0,100,210)}):Play()
    end)
    b.MouseLeave:Connect(function()
        TweenService:Create(b,TweenInfo.new(0.15),{BackgroundColor3=Color3.fromRGB(20,20,42)}):Play()
    end)
    return b
end

local BtnRu = MakeLangBtn("🇷🇺  Русский", -205)
local BtnEn = MakeLangBtn("🇺🇸  English",   10)

local Lang = nil
BtnRu.MouseButton1Click:Connect(function() Lang = "ru" end)
BtnEn.MouseButton1Click:Connect(function() Lang = "en" end)
repeat task.wait() until Lang

TweenService:Create(Bg,TweenInfo.new(0.5),{BackgroundTransparency=1}):Play()
for _,v in ipairs(Bg:GetChildren()) do
    pcall(function()
        TweenService:Create(v,TweenInfo.new(0.4),{TextTransparency=1,BackgroundTransparency=1}):Play()
    end)
end
task.wait(0.6)
BootGui:Destroy()

-- ══════════════════════════════════════════════════════════════
-- СИСТЕМА КЛЮЧЕЙ
-- ══════════════════════════════════════════════════════════════
local ValidKeys = {}
for i = 1,200 do ValidKeys[string.format("ULTRA-BETA-%04d-2026",i)] = true end

local KeyFile  = "ULTRA_BETA_KEY.txt"
local SavedKey = nil
pcall(function() if readfile then SavedKey = readfile(KeyFile):gsub("%s+","") end end)
local KeyOK = SavedKey and ValidKeys[SavedKey]

local KT = {
    ru = {
        title="ULTRA BETA — Система ключей",
        beta="⚠️ БЕТА ВЕРСИЯ — Скрипт в разработке",
        desc="Введите лицензионный ключ.\nКлюч сохраняется на устройство.\nФормат: ULTRA-BETA-XXXX-2026",
        ph="ULTRA-BETA-0001-2026",
        btn="АКТИВИРОВАТЬ",
        ok="✅ Ключ принят! Загрузка...",
        err="❌ Неверный ключ! ",
        err2="🚫 Слишком много попыток!",
        empty="❗ Введите ключ!",
        footer="ULTRA BETA 2026  •  SkilerBost  •  200 лицензий"
    },
    en = {
        title="ULTRA BETA — Key System",
        beta="⚠️ BETA VERSION — Script under development",
        desc="Enter your license key to activate.\nKey is saved to your device.\nFormat: ULTRA-BETA-XXXX-2026",
        ph="ULTRA-BETA-0001-2026",
        btn="ACTIVATE",
        ok="✅ Key accepted! Loading...",
        err="❌ Invalid key! ",
        err2="🚫 Too many attempts!",
        empty="❗ Enter a key!",
        footer="ULTRA BETA 2026  •  SkilerBost  •  200 licenses"
    }
}
local K = KT[Lang]

if not KeyOK then
    local KGui = Instance.new("ScreenGui", GetRoot())
    KGui.Name           = "ULTRA_Key"
    KGui.IgnoreGuiInset = true
    KGui.DisplayOrder   = 999998
    KGui.ResetOnSpawn   = false

    local KBg = Instance.new("Frame", KGui)
    KBg.Size            = UDim2.new(1,0,1,0)
    KBg.BackgroundColor3 = Color3.fromRGB(5,5,15)
    KBg.BorderSizePixel = 0

    -- Частицы
    task.spawn(function()
        while KGui.Parent do
            local d = Instance.new("Frame", KBg)
            d.Size              = UDim2.new(0,math.random(2,5),0,math.random(2,5))
            d.Position          = UDim2.new(math.random(0,100)/100,0,1.05,0)
            d.BackgroundColor3  = Color3.fromRGB(0,math.random(130,255),255)
            d.BackgroundTransparency = math.random(30,60)/100
            d.BorderSizePixel   = 0
            Instance.new("UICorner",d).CornerRadius = UDim.new(1,0)
            TweenService:Create(d,TweenInfo.new(math.random(3,7),Enum.EasingStyle.Linear),{
                Position=UDim2.new(d.Position.X.Scale,0,-0.05,0),BackgroundTransparency=1
            }):Play()
            task.delay(7,function() pcall(function() d:Destroy() end) end)
            task.wait(0.13)
        end
    end)

    -- Вычисления на фоне
    task.spawn(function()
        while KGui.Parent do
            local l = Instance.new("TextLabel", KBg)
            l.BackgroundTransparency = 1
            l.Text      = Calcs[math.random(1,#Calcs)]
            l.TextColor3 = Color3.fromRGB(math.random(50,160),math.random(50,160),math.random(100,255))
            l.TextSize  = math.random(10,15)
            l.Font      = Enum.Font.Code
            l.Position  = UDim2.new(math.random(2,95)/100,0,math.random(5,92)/100,0)
            TweenService:Create(l,TweenInfo.new(4,Enum.EasingStyle.Linear),{
                Position=UDim2.new(l.Position.X.Scale,0,l.Position.Y.Scale-0.1,0),TextTransparency=1
            }):Play()
            task.delay(4,function() pcall(function() l:Destroy() end) end)
            task.wait(0.24)
        end
    end)

    local Panel = Instance.new("Frame", KBg)
    Panel.Size              = UDim2.new(0,470,0,430)
    Panel.Position          = UDim2.new(0.5,-235,0.5,-215)
    Panel.BackgroundColor3  = Color3.fromRGB(11,11,24)
    Panel.BorderSizePixel   = 0
    Instance.new("UICorner",Panel).CornerRadius = UDim.new(0,14)

    local PS = Instance.new("UIStroke",Panel); PS.Thickness = 2
    local PSG = Instance.new("UIGradient",PS)
    PSG.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0,Color3.fromRGB(0,150,255)),
        ColorSequenceKeypoint.new(0.33,Color3.fromRGB(120,50,255)),
        ColorSequenceKeypoint.new(0.66,Color3.fromRGB(255,50,100)),
        ColorSequenceKeypoint.new(1,Color3.fromRGB(0,150,255))
    })
    task.spawn(function()
        local r=0 while KGui.Parent do r=(r+1)%360 PSG.Rotation=r task.wait(0.02) end
    end)

    -- Замок
    local LockIcon = Instance.new("TextLabel",Panel)
    LockIcon.Size=UDim2.new(0,70,0,70); LockIcon.Position=UDim2.new(0.5,-35,0,15)
    LockIcon.BackgroundTransparency=1; LockIcon.Text="🔒"; LockIcon.TextSize=52; LockIcon.Font=Enum.Font.GothamBold

    local function KLabel(text,posY,h,color,bold)
        local l=Instance.new("TextLabel",Panel)
        l.Size=UDim2.new(1,-30,0,h); l.Position=UDim2.new(0,15,0,posY)
        l.BackgroundTransparency=1; l.Text=text; l.TextColor3=color or Color3.fromRGB(200,200,220)
        l.TextSize=h>26 and 20 or 12; l.Font=bold and Enum.Font.GothamBlack or Enum.Font.Gotham
        l.TextWrapped=true; l.TextXAlignment=Enum.TextXAlignment.Center
        return l
    end

    KLabel(K.title,90,28,Color3.fromRGB(0,200,255),true)
    KLabel(K.beta,120,18,Color3.fromRGB(255,180,0),false)
    KLabel(K.desc,142,52,Color3.fromRGB(120,120,155),false)

    local IBox = Instance.new("Frame",Panel)
    IBox.Size=UDim2.new(1,-40,0,44); IBox.Position=UDim2.new(0,20,0,202)
    IBox.BackgroundColor3=Color3.fromRGB(8,8,18); IBox.BorderSizePixel=0
    Instance.new("UICorner",IBox).CornerRadius=UDim.new(0,9)
    local IBS=Instance.new("UIStroke",IBox); IBS.Thickness=1.5; IBS.Color=Color3.fromRGB(40,40,70)

    local IField=Instance.new("TextBox",IBox)
    IField.Size=UDim2.new(1,-18,1,0); IField.Position=UDim2.new(0,9,0,0)
    IField.BackgroundTransparency=1; IField.Text=""; IField.PlaceholderText=K.ph
    IField.PlaceholderColor3=Color3.fromRGB(55,55,80); IField.TextColor3=Color3.fromRGB(220,220,255)
    IField.TextSize=16; IField.Font=Enum.Font.Code; IField.ClearTextOnFocus=false

    IField.Focused:Connect(function() TweenService:Create(IBS,TweenInfo.new(0.2),{Color=Color3.fromRGB(0,150,255)}):Play() end)
    IField.FocusLost:Connect(function() TweenService:Create(IBS,TweenInfo.new(0.2),{Color=Color3.fromRGB(40,40,70)}):Play() end)

    local ABtn=Instance.new("TextButton",Panel)
    ABtn.Size=UDim2.new(1,-40,0,44); ABtn.Position=UDim2.new(0,20,0,256)
    ABtn.BackgroundColor3=Color3.fromRGB(0,120,255); ABtn.TextColor3=Color3.new(1,1,1)
    ABtn.Font=Enum.Font.GothamBold; ABtn.TextSize=16; ABtn.Text=K.btn; ABtn.BorderSizePixel=0
    Instance.new("UICorner",ABtn).CornerRadius=UDim.new(0,9)
    ABtn.MouseEnter:Connect(function() TweenService:Create(ABtn,TweenInfo.new(0.15),{BackgroundColor3=Color3.fromRGB(0,160,255)}):Play() end)
    ABtn.MouseLeave:Connect(function() TweenService:Create(ABtn,TweenInfo.new(0.15),{BackgroundColor3=Color3.fromRGB(0,120,255)}):Play() end)

    local StatLbl=KLabel("",305,22,Color3.fromRGB(255,80,80),false)
    local AttBg=Instance.new("Frame",Panel)
    AttBg.Size=UDim2.new(1,-40,0,3); AttBg.Position=UDim2.new(0,20,0,332)
    AttBg.BackgroundColor3=Color3.fromRGB(20,20,40); AttBg.BorderSizePixel=0
    Instance.new("UICorner",AttBg).CornerRadius=UDim.new(1,0)
    local AttFill=Instance.new("Frame",AttBg)
    AttFill.Size=UDim2.new(1,0,1,0); AttFill.BackgroundColor3=Color3.fromRGB(0,200,100); AttFill.BorderSizePixel=0
    Instance.new("UICorner",AttFill).CornerRadius=UDim.new(1,0)
    KLabel(K.footer,398,14,Color3.fromRGB(40,40,60),false)

    local Attempts=0; local MaxAtt=5; local KeyAccepted=false

    ABtn.MouseButton1Click:Connect(function()
        if not ABtn.Active then return end
        local key=IField.Text:gsub("%s+",""):upper()
        if key=="" then StatLbl.Text=K.empty; StatLbl.TextColor3=Color3.fromRGB(255,180,0); return end
        Attempts=Attempts+1
        local left=math.max(0,(MaxAtt-Attempts)/MaxAtt)
        TweenService:Create(AttFill,TweenInfo.new(0.3),{
            Size=UDim2.new(left,0,1,0),
            BackgroundColor3=left>0.5 and Color3.fromRGB(0,200,100) or (left>0.2 and Color3.fromRGB(255,180,0) or Color3.fromRGB(255,50,50))
        }):Play()
        if Attempts>MaxAtt then StatLbl.Text=K.err2; StatLbl.TextColor3=Color3.fromRGB(255,50,50); ABtn.Active=false; return end
        if ValidKeys[key] then
            StatLbl.Text=K.ok; StatLbl.TextColor3=Color3.fromRGB(0,255,100)
            LockIcon.Text="🔓"; ABtn.Active=false; ABtn.BackgroundColor3=Color3.fromRGB(0,170,80); ABtn.Text="✅"
            IBS.Color=Color3.fromRGB(0,255,100)
            pcall(function() if writefile then writefile(KeyFile,key) end end)
            task.wait(1.2); KeyAccepted=true
        else
            StatLbl.Text=K.err..Attempts.."/"..MaxAtt; StatLbl.TextColor3=Color3.fromRGB(255,80,80)
            IBS.Color=Color3.fromRGB(255,50,50)
            task.spawn(function()
                for i=1,8 do Panel.Position=UDim2.new(0.5,-235+(i%2==0 and 8 or -8),0.5,-215); task.wait(0.032) end
                Panel.Position=UDim2.new(0.5,-235,0.5,-215); task.wait(0.2); IBS.Color=Color3.fromRGB(40,40,70)
            end)
        end
    end)
    IField.FocusLost:Connect(function(e) if e then ABtn.MouseButton1Click:Fire() end end)
    repeat task.wait() until KeyAccepted
    TweenService:Create(KBg,TweenInfo.new(0.5),{BackgroundTransparency=1}):Play()
    for _,v in ipairs(Panel:GetDescendants()) do
        pcall(function() TweenService:Create(v,TweenInfo.new(0.4),{TextTransparency=1,BackgroundTransparency=1}):Play() end)
    end
    task.wait(0.6); KGui:Destroy()
end

-- ══════════════════════════════════════════════════════════════
-- АНТИДЕТЕКТ
-- ══════════════════════════════════════════════════════════════
if HasHook then
    pcall(function()
        local wrap = HasNewCC and newcclosure or function(f) return f end
        local OldIndex
        OldIndex = hookmetamethod(game,"__index",wrap(function(self,key)
            if not checkcaller() and typeof(self)=="Instance" and self:IsA("Humanoid") then
                if key=="WalkSpeed" then return 16 end
                if key=="JumpPower" then return 50 end
                if key=="JumpHeight" then return 7.2 end
            end
            return OldIndex(self,key)
        end))
        local OldNewIndex
        OldNewIndex = hookmetamethod(game,"__newindex",wrap(function(self,key,value)
            if not checkcaller() and typeof(self)=="Instance" and self:IsA("Humanoid") then
                if key=="WalkSpeed" or key=="JumpPower" or key=="JumpHeight" then return end
            end
            return OldNewIndex(self,key,value)
        end))
    end)
end

if HasGC then
    task.spawn(function()
        while task.wait(2) do
            pcall(function()
                for _,v in ipairs(getgc(true)) do
                    if type(v)=="table" then
                        pcall(function()
                            if rawget(v,"WalkSpeed") and type(rawget(v,"WalkSpeed"))=="number" then rawset(v,"WalkSpeed",16) end
                            if rawget(v,"JumpPower")  and type(rawget(v,"JumpPower"))=="number"  then rawset(v,"JumpPower",50)  end
                        end)
                    end
                end
            end)
        end
    end)
end

-- ══════════════════════════════════════════════════════════════
-- КОНФИГ
-- ══════════════════════════════════════════════════════════════
local C = {
    Lang = Lang,
    Aim = {On=false,Part="Head",FOV=200,Smooth=6,Team=false,Wall=false,Mode="Hold",Pred=0,ShowFOV=true},
    ESP = {On=false,Box=true,Name=true,HP=true,Dist=true,Team=false,Max=2500},
    HB  = {On=false,Size=10,Part="Head",ExpandAll=false,Vis=true},
    Gun = {RapidFire=false,RapidSpeed=30,AutoFire=false,InfAmmo=false,NoSpread=false},
    WS  = {On=false,Val=16},
    JP  = {On=false,Val=50},
    NF=false,IJ=false,NC=false,
    Fly = {On=false,Sp=50},
    Anti = {Randomize=true},
    MenuOpen = true
}

-- ══════════════════════════════════════════════════════════════
-- ХИТБОКСЫ (CFrame метод — без десинка)
-- ══════════════════════════════════════════════════════════════
local FakeParts = {}

local function ClearHB(plr)
    if FakeParts[plr] then
        for _,d in ipairs(FakeParts[plr]) do pcall(function() d.fake:Destroy() end) end
        FakeParts[plr] = nil
    end
end

local function CreateHB(plr)
    if plr==LP then return end
    ClearHB(plr)
    if not C.HB.On then return end
    local ch = plr.Character; if not ch then return end
    local hum = ch:FindFirstChildOfClass("Humanoid")
    if not hum or hum.Health<=0 then return end

    local targets = {}
    if C.HB.ExpandAll then
        for _,p in ipairs(ch:GetChildren()) do
            if p:IsA("BasePart") and p.Name~="HumanoidRootPart" then table.insert(targets,p) end
        end
    else
        local p = ch:FindFirstChild(C.HB.Part)
        if not p and C.HB.Part=="Torso" then p = ch:FindFirstChild("UpperTorso") or ch:FindFirstChild("Torso") end
        if not p then p = ch:FindFirstChild("Head") end
        if p and p:IsA("BasePart") then table.insert(targets,p) end
    end

    local list = {}
    for _,target in ipairs(targets) do
        local fake = Instance.new("Part")
        fake.Anchored       = true
        fake.CanCollide     = false
        fake.CastShadow     = false
        fake.Massless       = true
        fake.Size           = Vector3.new(C.HB.Size,C.HB.Size,C.HB.Size)
        fake.CFrame         = target.CFrame
        fake.Transparency   = C.HB.Vis and 0.35 or 1
        fake.Color          = Color3.fromRGB(255,0,60)
        fake.Material       = Enum.Material.ForceField
        fake.Name           = "ULTRA_HB"
        fake.Parent         = Workspace
        table.insert(list,{fake=fake,target=target})
    end
    FakeParts[plr] = list
end

local function UpdateHB()
    for plr,list in pairs(FakeParts) do
        local ch = plr.Character
        local hum = ch and ch:FindFirstChildOfClass("Humanoid")
        if not ch or not hum or hum.Health<=0 then ClearHB(plr); continue end
        for _,d in ipairs(list) do
            if d.fake and d.fake.Parent and d.target and d.target.Parent then
                d.fake.CFrame    = d.target.CFrame
                d.fake.Size      = Vector3.new(C.HB.Size,C.HB.Size,C.HB.Size)
                d.fake.Transparency = C.HB.Vis and 0.35 or 1
            else ClearHB(plr); break end
        end
    end
end

local function CleanAllHB()
    for plr,_ in pairs(FakeParts) do ClearHB(plr) end
    for _,obj in ipairs(Workspace:GetChildren()) do
        if obj.Name=="ULTRA_HB" then pcall(function() obj:Destroy() end) end
    end
end

local function RefreshAllHB()
    if not C.HB.On then CleanAllHB(); return end
    for _,plr in ipairs(Players:GetPlayers()) do
        if plr~=LP then
            local ch = plr.Character
            local hum = ch and ch:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health>0 then
                if not FakeParts[plr] then CreateHB(plr) end
            else ClearHB(plr) end
        end
    end
end

-- ══════════════════════════════════════════════════════════════
-- ESP
-- ══════════════════════════════════════════════════════════════
local ESPCache = {}

local function RemoveESP(plr)
    if ESPCache[plr] then
        pcall(function() if ESPCache[plr].hl then ESPCache[plr].hl:Destroy() end end)
        pcall(function() if ESPCache[plr].bb then ESPCache[plr].bb:Destroy() end end)
        ESPCache[plr] = nil
    end
end

local function CleanESP()
    for plr,_ in pairs(ESPCache) do RemoveESP(plr) end
end

local function CreateESP(plr)
    if plr==LP then return end
    RemoveESP(plr)
    local ch  = plr.Character; if not ch then return end
    local hum = ch:FindFirstChildOfClass("Humanoid")
    local hrp = ch:FindFirstChild("HumanoidRootPart")
    if not hum or not hrp then return end
    local head = ch:FindFirstChild("Head")

    local data = {}

    -- Highlight
    local hl = Instance.new("Highlight")
    hl.FillColor           = Color3.fromRGB(255,0,50)
    hl.FillTransparency    = 0.5
    hl.OutlineColor        = Color3.fromRGB(255,255,255)
    hl.OutlineTransparency = 0
    hl.DepthMode           = Enum.HighlightDepthMode.AlwaysOnTop
    hl.Adornee             = ch
    hl.Enabled             = C.ESP.On and C.ESP.Box
    pcall(function() hl.Parent = CoreGui end)
    data.hl = hl

    -- Billboard
    local bb = Instance.new("BillboardGui")
    bb.Adornee       = head or hrp
    bb.Size          = UDim2.new(0,200,0,80)
    bb.StudsOffset   = Vector3.new(0,3.5,0)
    bb.AlwaysOnTop   = true
    bb.LightInfluence = 0
    bb.MaxDistance   = C.ESP.Max
    bb.Enabled       = true
    pcall(function() bb.Parent = CoreGui end)

    local function BbLbl(text,posY,size,color,bold)
        local l = Instance.new("TextLabel",bb)
        l.Size=UDim2.new(1,0,0,size); l.Position=UDim2.new(0,0,0,posY)
        l.BackgroundTransparency=1; l.Text=text; l.TextColor3=color
        l.TextStrokeColor3=Color3.fromRGB(0,0,0); l.TextStrokeTransparency=0
        l.TextSize=size; l.Font=bold and Enum.Font.GothamBold or Enum.Font.Gotham
        return l
    end

    data.nameLbl = BbLbl(plr.DisplayName.." ["..plr.Name.."]",0,13,Color3.fromRGB(255,255,255),true)

    local hpBg = Instance.new("Frame",bb)
    hpBg.Size=UDim2.new(0.78,0,0,5); hpBg.Position=UDim2.new(0.11,0,0,16)
    hpBg.BackgroundColor3=Color3.fromRGB(35,35,35); hpBg.BorderSizePixel=0
    Instance.new("UICorner",hpBg).CornerRadius=UDim.new(1,0)
    local hpFill=Instance.new("Frame",hpBg)
    hpFill.Size=UDim2.new(1,0,1,0); hpFill.BackgroundColor3=Color3.fromRGB(0,255,0); hpFill.BorderSizePixel=0
    Instance.new("UICorner",hpFill).CornerRadius=UDim.new(1,0)
    data.hpBg   = hpBg
    data.hpFill = hpFill
    data.hpText = BbLbl("100/100 HP",24,11,Color3.fromRGB(0,255,100),false)
    data.distLbl = BbLbl("0m",38,11,Color3.fromRGB(180,180,255),false)
    data.bb   = bb
    data.char = ch
    ESPCache[plr] = data
end

local function UpdateESP()
    local myHRP = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    for plr,data in pairs(ESPCache) do
        local ch = plr.Character
        if not ch or not ch:FindFirstChildOfClass("Humanoid") or not ch:FindFirstChild("HumanoidRootPart") then
            if data.hl then data.hl.Enabled=false end
            if data.bb then data.bb.Enabled=false end
            continue
        end
        if not C.ESP.On then
            if data.hl then data.hl.Enabled=false end
            if data.bb then data.bb.Enabled=false end
            continue
        end
        if C.ESP.Team and LP.Team and plr.Team==LP.Team then
            if data.hl then data.hl.Enabled=false end
            if data.bb then data.bb.Enabled=false end
            continue
        end
        local hum  = ch:FindFirstChildOfClass("Humanoid")
        local hrp  = ch:FindFirstChild("HumanoidRootPart")
        local head = ch:FindFirstChild("Head")
        local dist = myHRP and (myHRP.Position-hrp.Position).Magnitude or 0
        if dist>C.ESP.Max then
            if data.hl then data.hl.Enabled=false end
            if data.bb then data.bb.Enabled=false end
            continue
        end
        local pct = hum.Health/math.max(hum.MaxHealth,1)
        if data.hl then
            data.hl.Enabled=C.ESP.Box; data.hl.Adornee=ch
            data.hl.FillColor=pct>0.6 and Color3.fromRGB(0,200,80) or (pct>0.3 and Color3.fromRGB(255,180,0) or Color3.fromRGB(255,40,40))
        end
        if data.bb then
            data.bb.Enabled=true; data.bb.Adornee=head or hrp; data.bb.MaxDistance=C.ESP.Max
            if data.nameLbl then data.nameLbl.Visible=C.ESP.Name end
            if data.hpBg   then data.hpBg.Visible=C.ESP.HP end
            if data.hpFill then
                data.hpFill.Size=UDim2.new(math.clamp(pct,0,1),0,1,0)
                data.hpFill.BackgroundColor3=pct>0.6 and Color3.fromRGB(0,255,0) or (pct>0.3 and Color3.fromRGB(255,200,0) or Color3.fromRGB(255,50,50))
            end
            if data.hpText then
                data.hpText.Visible=C.ESP.HP
                data.hpText.Text=math.floor(hum.Health).."/"..math.floor(hum.MaxHealth).." HP"
                data.hpText.TextColor3=pct>0.6 and Color3.fromRGB(0,255,100) or (pct>0.3 and Color3.fromRGB(255,200,0) or Color3.fromRGB(255,60,60))
            end
            if data.distLbl then data.distLbl.Visible=C.ESP.Dist; data.distLbl.Text=math.floor(dist).."m" end
        end
    end
end

-- Авто подключение
Players.PlayerAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(function()
        task.wait(0.8)
        if C.ESP.On then CreateESP(plr) end
        if C.HB.On  then CreateHB(plr)  end
    end)
end)
Players.PlayerRemoving:Connect(function(plr) RemoveESP(plr); ClearHB(plr) end)
for _,plr in ipairs(Players:GetPlayers()) do
    if plr~=LP then
        if plr.Character then CreateESP(plr) end
        plr.CharacterAdded:Connect(function()
            task.wait(0.8)
            if C.ESP.On then CreateESP(plr) end
            if C.HB.On  then CreateHB(plr)  end
        end)
    end
end

-- ══════════════════════════════════════════════════════════════
-- GUN
-- ══════════════════════════════════════════════════════════════
local RapidOn,LmbHeld = false,false
local CTools,LastT    = {},0

local function RefreshTools()
    CTools={}; if not LP.Character then return end
    for _,t in ipairs(LP.Character:GetChildren()) do
        if t:IsA("Tool") then
            local evs={}
            for _,d in ipairs(t:GetDescendants()) do
                if d:IsA("RemoteEvent") then
                    local n=d.Name:lower()
                    if n:find("shoot") or n:find("fire") or n:find("attack") then table.insert(evs,d) end
                end
            end
            table.insert(CTools,{tool=t,events=evs})
        end
    end
end

local function DoFire()
    if HasClick then pcall(mouse1click) end
    if tick()-LastT>1 then LastT=tick(); RefreshTools() end
    local mp = Mouse.Hit and Mouse.Hit.Position or Vector3.zero
    for _,e in ipairs(CTools) do
        if e.tool and e.tool.Parent then
            pcall(function() e.tool:Activate() end)
            for _,ev in ipairs(e.events) do pcall(function() ev:FireServer(mp) end) end
        end
    end
end

local function StartRapid()
    if RapidOn then return end; RapidOn=true
    task.spawn(function()
        while RapidOn do
            if not (C.Gun.RapidFire or (C.Gun.AutoFire and LmbHeld)) then break end
            DoFire(); task.wait(math.max(C.Gun.RapidSpeed/1000,0.01))
        end
        RapidOn=false
    end)
end
local function StopRapid() RapidOn=false end

local AmmoNames  = {Ammo=true,ammo=true,Clip=true,clip=true,Magazine=true,Mag=true,mag=true,Bullets=true,bullets=true,CurrentAmmo=true}
local SpreadNames = {Spread=true,spread=true,Recoil=true,recoil=true}

local function ScanAmmo()
    if not (C.Gun.InfAmmo or C.Gun.NoSpread) then return end
    local roots={}
    if LP.Character then table.insert(roots,LP.Character) end
    if LP:FindFirstChild("Backpack") then table.insert(roots,LP.Backpack) end
    for _,r in ipairs(roots) do
        for _,d in ipairs(r:GetDescendants()) do
            pcall(function()
                if d:IsA("NumberValue") or d:IsA("IntValue") then
                    if C.Gun.InfAmmo  and AmmoNames[d.Name]  and d.Value<999 then d.Value=999 end
                    if C.Gun.NoSpread and SpreadNames[d.Name] then d.Value=0 end
                end
            end)
        end
    end
end

-- ══ FLY ══
local FBV,FBG
local function DoFly(on)
    pcall(function()
        local ch=LP.Character; local hrp=ch.HumanoidRootPart; local hum=ch:FindFirstChildOfClass("Humanoid")
        if on then
            hum.PlatformStand=true
            FBV=Instance.new("BodyVelocity"); FBV.Velocity=Vector3.zero; FBV.MaxForce=Vector3.one*9e9; FBV.Parent=hrp
            FBG=Instance.new("BodyGyro"); FBG.P=9e4; FBG.MaxTorque=Vector3.one*9e9; FBG.CFrame=hrp.CFrame; FBG.Parent=hrp
        else
            if FBV then FBV:Destroy(); FBV=nil end
            if FBG then FBG:Destroy(); FBG=nil end
            hum.PlatformStand=false
        end
    end)
end

-- ══════════════════════════════════════════════════════════════
-- ГЛАВНЫЕ ЦИКЛЫ
-- ══════════════════════════════════════════════════════════════
local AimActive = false
local AmmoTimer = 0

RunService.Heartbeat:Connect(function(dt)
    -- Fly
    if C.Fly.On and FBV and FBG and Cam then
        local mv=Vector3.zero
        if UserInputService:IsKeyDown(Enum.KeyCode.W)           then mv=mv+Cam.CFrame.LookVector  end
        if UserInputService:IsKeyDown(Enum.KeyCode.S)           then mv=mv-Cam.CFrame.LookVector  end
        if UserInputService:IsKeyDown(Enum.KeyCode.A)           then mv=mv-Cam.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D)           then mv=mv+Cam.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space)       then mv=mv+Vector3.yAxis          end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then mv=mv-Vector3.yAxis          end
        FBV.Velocity=mv*C.Fly.Sp; FBG.CFrame=Cam.CFrame
    end

    -- Хитбокс — каждый кадр
    if C.HB.On then UpdateHB() end

    -- Персонаж
    local ch=LP.Character; if not ch then return end
    local hum=ch:FindFirstChildOfClass("Humanoid")
    if hum then
        if C.WS.On then hum.WalkSpeed=C.WS.Val+(C.Anti.Randomize and math.random(-5,5)/10 or 0) end
        if C.JP.On then hum.JumpPower=C.JP.Val end
        if C.NF   then hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false); hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false) end
        if C.NC   then for _,p in ipairs(ch:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide=false end end end
    end

    AmmoTimer=AmmoTimer+dt
    if AmmoTimer>0.5 then AmmoTimer=0; ScanAmmo() end
end)

-- Обновление хитбоксов раз в 1.5с
task.spawn(function()
    while task.wait(1.5) do if C.HB.On then RefreshAllHB() end end
end)

-- RenderStepped — FOV + Aimbot + ESP
local RayP = RaycastParams.new(); RayP.FilterType = Enum.RaycastFilterType.Blacklist

RunService.RenderStepped:Connect(function()
    Cam = Workspace.CurrentCamera; if not Cam then return end

    -- FOV Circle
    if FOVCircle then
        if C.Aim.On and C.Aim.ShowFOV then
            FOVCircle.Visible   = true
            FOVCircle.Radius    = C.Aim.FOV
            FOVCircle.Position  = Vector2.new(Cam.ViewportSize.X/2, Cam.ViewportSize.Y/2)
        else
            FOVCircle.Visible = false
        end
    end

    -- Aimbot
    if C.Aim.On and (C.Aim.Mode=="Always" or AimActive) then
        local best,bD = nil,C.Aim.FOV
        local cx,cy   = Cam.ViewportSize.X/2, Cam.ViewportSize.Y/2
        for _,p in ipairs(Players:GetPlayers()) do
            if p~=LP and p.Character then
                local h=p.Character:FindFirstChildOfClass("Humanoid")
                if h and h.Health>0 then
                    if C.Aim.Team and LP.Team and p.Team==LP.Team then continue end
                    local part
                    if C.Aim.Part=="Head" then part=p.Character:FindFirstChild("Head")
                    elseif C.Aim.Part=="Torso" then part=p.Character:FindFirstChild("UpperTorso") or p.Character:FindFirstChild("Torso")
                    else part=p.Character:FindFirstChild(C.Aim.Part) end
                    if not part then part=p.Character:FindFirstChild("Head") end
                    if part then
                        local sv,onS=Cam:WorldToViewportPoint(part.Position)
                        if onS then
                            local d=math.sqrt((sv.X-cx)^2+(sv.Y-cy)^2)
                            if d<bD then
                                if C.Aim.Wall then
                                    RayP.FilterDescendantsInstances={LP.Character}
                                    local r=Workspace:Raycast(Cam.CFrame.Position,(part.Position-Cam.CFrame.Position).Unit*2000,RayP)
                                    if r and not r.Instance:IsDescendantOf(p.Character) then continue end
                                end
                                bD=d; best=part
                            end
                        end
                    end
                end
            end
        end
        if best then
            local tp=best.Position
            if C.Aim.Pred>0 then
                local vel=best.AssemblyLinearVelocity or Vector3.zero
                if vel.Magnitude>0 then tp=tp+vel*C.Aim.Pred end
            end
            Cam.CFrame=Cam.CFrame:Lerp(CFrame.lookAt(Cam.CFrame.Position,tp),math.clamp(1/C.Aim.Smooth,0.02,1))
        end
    end

    UpdateESP()
end)

-- ══ INPUT ══
UserInputService.InputBegan:Connect(function(i,gpe)
    if gpe then return end
    if i.UserInputType==Enum.UserInputType.MouseButton2 then
        if C.Aim.Mode=="Hold" then AimActive=true elseif C.Aim.Mode=="Toggle" then AimActive=not AimActive end
        if C.Gun.RapidFire then StartRapid() end
    end
    if i.UserInputType==Enum.UserInputType.MouseButton1 then LmbHeld=true; if C.Gun.AutoFire then StartRapid() end end
    if C.IJ and i.KeyCode==Enum.KeyCode.Space and LP.Character then
        pcall(function() LP.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping) end)
    end
    if i.KeyCode==Enum.KeyCode.RightShift then C.MenuOpen=not C.MenuOpen end
end)
UserInputService.InputEnded:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton2 then
        if C.Aim.Mode=="Hold" then AimActive=false end
        if C.Gun.RapidFire then StopRapid() end
    end
    if i.UserInputType==Enum.UserInputType.MouseButton1 then LmbHeld=false; if C.Gun.AutoFire then StopRapid() end end
end)
LP.CharacterAdded:Connect(function()
    CTools={}; LastT=0
    if C.Fly.On then task.wait(1); DoFly(true) end
end)

-- ══════════════════════════════════════════════════════════════
-- ЛОКАЛИЗАЦИЯ МЕНЮ
-- ══════════════════════════════════════════════════════════════
local T = {
    ru = {
        title="ULTRA BETA",sub="SkilerBost • BETA 2026",
        tabs={"Боевой","Оружие","Визуал","Движение","Античит","Инфо"},
        aimSec="АИМБОТ",aimOn="Включить аимбот",aMode="Режим",aPart="Цель",
        aFOV="Радиус FOV",aSmooth="Плавность",aPred="Предсказание",
        aFovC="Показать круг FOV",aTeam="Проверка команды",aWall="Сквозь стены",
        hbSec="ХИТБОКС",hbOn="Включить хитбокс",hbSz="Размер (studs)",
        hbPt="Часть тела",hbVis="Показать красным",
        hbInfo="✅ Фейк-часть следует за головой через CFrame.\nОригинал НЕ двигается — нет десинка!\nРаботает: MM2, Da Hood и др.\n⚠️ Rivals/Arsenal = кик!",
        gSec="ПАТРОНЫ",gAmmo="Бесконечные патроны",gSpread="Без разброса/отдачи",
        gRSec="RAPID FIRE",gRap="Rapid Fire (ПКМ)",gAuto="Auto Fire (ЛКМ)",
        gSpd="Скорость (мс)",gTest="Тест выстрела",
        gWarn="⚠️ В серверных играх кикнет!",
        espSec="ESP",espOn="Включить ESP",espBox="Обводка",espName="Имя",
        espHP="HP бар",espDist="Дистанция",espTeam="Проверка команды",espMax="Макс. дистанция",
        wSec="МИР",fb="Полная яркость",
        wsSec="СКОРОСТЬ",wsOn="WalkSpeed",wsVal="Значение",jpOn="JumpPower",jpVal="Значение",
        mSec="ПРОЧЕЕ",nf="Без урона от падения",ij="Беск. прыжок",nc="NoClip",
        fSec="ПОЛЁТ",flyOn="Включить полёт",flySp="Скорость",
        acSec="ЗАЩИТА",acR="Рандомизация скорости",acH="Скрыть GUI",acStat="СТАТУС",
        iSec="О СКРИПТЕ",iText="ULTRA BETA 2026\nSkilerBost Premium Edition\n200 лицензий\n\n⚠️ БЕТА ВЕРСИЯ!\nСкрипт в активной разработке.\n\nRightShift = Меню",
        kSec="УПРАВЛЕНИЕ",kText="RightShift = Меню\nПКМ = Аимбот (Hold)\nЛКМ = Auto Fire\nSpace = Беск. прыжок",
        aSec="ДЕЙСТВИЯ",unload="⏏  Выгрузить скрипт",rejoin="🔄  Перезайти"
    },
    en = {
        title="ULTRA BETA",sub="SkilerBost • BETA 2026",
        tabs={"Combat","Gun","Visual","Move","Anti","Info"},
        aimSec="AIMBOT",aimOn="Enable Aimbot",aMode="Mode",aPart="Target Part",
        aFOV="FOV Radius",aSmooth="Smoothness",aPred="Prediction",
        aFovC="Show FOV Circle",aTeam="Team Check",aWall="Wall Check",
        hbSec="HITBOX",hbOn="Enable Hitbox",hbSz="Size (studs)",
        hbPt="Body Part",hbVis="Show red overlay",
        hbInfo="✅ Fake part follows head via CFrame.\nOriginal NOT moved — no desync!\nWorks: MM2, Da Hood etc.\n⚠️ Rivals/Arsenal = kick!",
        gSec="AMMO",gAmmo="Infinite Ammo",gSpread="No Spread/Recoil",
        gRSec="RAPID FIRE",gRap="Rapid Fire (RMB)",gAuto="Auto Fire (LMB)",
        gSpd="Speed (ms)",gTest="Test Fire",
        gWarn="⚠️ Server-sided games will kick!",
        espSec="ESP",espOn="Enable ESP",espBox="Highlight Box",espName="Player Name",
        espHP="HP Bar",espDist="Distance",espTeam="Team Check",espMax="Max Distance",
        wSec="WORLD",fb="FullBright",
        wsSec="SPEED",wsOn="WalkSpeed",wsVal="Value",jpOn="JumpPower",jpVal="Value",
        mSec="MISC",nf="No Fall Damage",ij="Infinite Jump",nc="Noclip",
        fSec="FLY",flyOn="Enable Fly",flySp="Speed",
        acSec="PROTECTION",acR="Randomize Values",acH="Hide GUI Names",acStat="STATUS",
        iSec="ABOUT",iText="ULTRA BETA 2026\nSkilerBost Premium Edition\n200 Licenses\n\n⚠️ BETA VERSION!\nScript under active development.\n\nRightShift = Menu",
        kSec="CONTROLS",kText="RightShift = Menu\nRMB = Aimbot (Hold)\nLMB = Auto Fire\nSpace = Inf Jump",
        aSec="ACTIONS",unload="⏏  Unload Script",rejoin="🔄  Rejoin Server"
    }
}
local TL = T[Lang]

-- ══════════════════════════════════════════════════════════════
-- МЕНЮ
-- ══════════════════════════════════════════════════════════════
local TH = {
    bg=Color3.fromRGB(9,9,20),hdr=Color3.fromRGB(7,7,16),
    item=Color3.fromRGB(16,16,34),accent=Color3.fromRGB(0,170,255),
    accent2=Color3.fromRGB(130,50,255),accent3=Color3.fromRGB(255,50,100),
    text=Color3.fromRGB(215,215,238),dim=Color3.fromRGB(105,105,140),
    togOn=Color3.fromRGB(0,210,100),togOff=Color3.fromRGB(42,42,62),
    slBg=Color3.fromRGB(22,22,44),slFg=Color3.fromRGB(0,170,255),
    sec=Color3.fromRGB(0,170,255),inBg=Color3.fromRGB(13,11,26),
    warn=Color3.fromRGB(255,180,0),ok=Color3.fromRGB(0,220,100),
    btnH=Color3.fromRGB(0,145,230)
}

local MenuGui = Instance.new("ScreenGui",GetRoot())
MenuGui.Name="ULTRA_Menu"; MenuGui.IgnoreGuiInset=true; MenuGui.DisplayOrder=10000; MenuGui.ResetOnSpawn=false

local Win = Instance.new("Frame",MenuGui)
Win.Name="Win"; Win.Size=UDim2.new(0,540,0,520)
Win.Position=UDim2.new(0.5,-270,0.5,-260)
Win.BackgroundColor3=TH.bg; Win.BorderSizePixel=0; Win.Active=true; Win.Draggable=true
Instance.new("UICorner",Win).CornerRadius=UDim.new(0,12)
local WS2=Instance.new("UIStroke",Win); WS2.Thickness=1.5; WS2.Color=TH.accent

task.spawn(function()
    local cols={TH.accent,TH.accent2,TH.accent3,TH.accent}; local i=1
    while MenuGui.Parent do
        TweenService:Create(WS2,TweenInfo.new(2,Enum.EasingStyle.Sine),{Color=cols[i]}):Play()
        i=i%#cols+1; task.wait(2)
    end
end)

-- Шапка
local Hdr=Instance.new("Frame",Win)
Hdr.Size=UDim2.new(1,0,0,40); Hdr.BackgroundColor3=TH.hdr; Hdr.BorderSizePixel=0
Instance.new("UICorner",Hdr).CornerRadius=UDim.new(0,12)

local HTitle=Instance.new("TextLabel",Hdr)
HTitle.Size=UDim2.new(0,200,1,0); HTitle.Position=UDim2.new(0,14,0,0)
HTitle.BackgroundTransparency=1; HTitle.Text=TL.title; HTitle.TextColor3=TH.accent
HTitle.TextSize=18; HTitle.Font=Enum.Font.GothamBlack; HTitle.TextXAlignment=Enum.TextXAlignment.Left

local HSub=Instance.new("TextLabel",Hdr)
HSub.Size=UDim2.new(0,180,1,0); HSub.Position=UDim2.new(1,-290,0,0)
HSub.BackgroundTransparency=1; HSub.Text=TL.sub; HSub.TextColor3=TH.dim
HSub.TextSize=10; HSub.Font=Enum.Font.Gotham; HSub.TextXAlignment=Enum.TextXAlignment.Right

local CloseBtn=Instance.new("TextButton",Hdr)
CloseBtn.Size=UDim2.new(0,28,0,28); CloseBtn.Position=UDim2.new(1,-34,0.5,-14)
CloseBtn.BackgroundColor3=Color3.fromRGB(55,15,15); CloseBtn.TextColor3=Color3.new(1,1,1)
CloseBtn.Text="✕"; CloseBtn.TextSize=13; CloseBtn.Font=Enum.Font.GothamBold; CloseBtn.BorderSizePixel=0
Instance.new("UICorner",CloseBtn).CornerRadius=UDim.new(0,6)
CloseBtn.MouseButton1Click:Connect(function() C.MenuOpen=false end)

-- Таб бар
local TabBar=Instance.new("Frame",Win)
TabBar.Size=UDim2.new(1,0,0,30); TabBar.Position=UDim2.new(0,0,0,40)
TabBar.BackgroundColor3=Color3.fromRGB(7,7,16); TabBar.BorderSizePixel=0
Instance.new("UIListLayout",TabBar).FillDirection=Enum.FillDirection.Horizontal

-- Контент
local Content=Instance.new("ScrollingFrame",Win)
Content.Size=UDim2.new(1,-6,1,-76); Content.Position=UDim2.new(0,3,0,72)
Content.BackgroundTransparency=1; Content.BorderSizePixel=0
Content.ScrollBarThickness=3; Content.ScrollBarImageColor3=TH.accent
Content.CanvasSize=UDim2.new(0,0,0,0); Content.ScrollingDirection=Enum.ScrollingDirection.Y

-- ══ UI КОМПОНЕНТЫ ══
local Y=0
local function RC() for _,c in ipairs(Content:GetChildren()) do c:Destroy() end; Y=6 end
local function SC() Content.CanvasSize=UDim2.new(0,0,0,Y+14) end

local function Sec(text)
    local f=Instance.new("Frame",Content); f.Size=UDim2.new(1,-16,0,20); f.Position=UDim2.new(0,8,0,Y); f.BackgroundTransparency=1
    local ln=Instance.new("Frame",f); ln.Size=UDim2.new(1,0,0,1); ln.Position=UDim2.new(0,0,0.5,0)
    ln.BackgroundColor3=TH.sec; ln.BackgroundTransparency=0.65; ln.BorderSizePixel=0
    local lb=Instance.new("TextLabel",f); lb.AutomaticSize=Enum.AutomaticSize.X
    lb.Size=UDim2.new(0,0,1,0); lb.Position=UDim2.new(0,4,0,0); lb.BackgroundColor3=TH.bg; lb.BorderSizePixel=0
    lb.Text="  "..text.."  "; lb.TextColor3=TH.sec; lb.TextSize=11; lb.Font=Enum.Font.GothamBold
    Y=Y+24
end

local function Tog(text,state,cb)
    local f=Instance.new("Frame",Content); f.Size=UDim2.new(1,-16,0,30); f.Position=UDim2.new(0,8,0,Y)
    f.BackgroundColor3=TH.item; f.BorderSizePixel=0; Instance.new("UICorner",f).CornerRadius=UDim.new(0,7)
    local lb=Instance.new("TextLabel",f); lb.Size=UDim2.new(1,-58,1,0); lb.Position=UDim2.new(0,10,0,0)
    lb.BackgroundTransparency=1; lb.Text=text; lb.TextColor3=TH.text; lb.TextSize=12; lb.Font=Enum.Font.Gotham; lb.TextXAlignment=Enum.TextXAlignment.Left
    local tbg=Instance.new("Frame",f); tbg.Size=UDim2.new(0,38,0,19); tbg.Position=UDim2.new(1,-46,0.5,-9.5)
    tbg.BackgroundColor3=state and TH.togOn or TH.togOff; tbg.BorderSizePixel=0; Instance.new("UICorner",tbg).CornerRadius=UDim.new(1,0)
    local dot=Instance.new("Frame",tbg); dot.Size=UDim2.new(0,15,0,15)
    dot.Position=state and UDim2.new(1,-17,0.5,-7.5) or UDim2.new(0,2,0.5,-7.5)
    dot.BackgroundColor3=Color3.new(1,1,1); dot.BorderSizePixel=0; Instance.new("UICorner",dot).CornerRadius=UDim.new(1,0)
    local cur=state
    local btn=Instance.new("TextButton",f); btn.Size=UDim2.new(1,0,1,0); btn.BackgroundTransparency=1; btn.Text=""
    btn.MouseButton1Click:Connect(function()
        cur=not cur
        TweenService:Create(tbg,TweenInfo.new(0.18),{BackgroundColor3=cur and TH.togOn or TH.togOff}):Play()
        TweenService:Create(dot,TweenInfo.new(0.18),{Position=cur and UDim2.new(1,-17,0.5,-7.5) or UDim2.new(0,2,0.5,-7.5)}):Play()
        cb(cur)
    end)
    Y=Y+33
end

local function Sld(text,mn,mx,def,cb)
    local f=Instance.new("Frame",Content); f.Size=UDim2.new(1,-16,0,46); f.Position=UDim2.new(0,8,0,Y)
    f.BackgroundColor3=TH.item; f.BorderSizePixel=0; Instance.new("UICorner",f).CornerRadius=UDim.new(0,7)
    local lb=Instance.new("TextLabel",f); lb.Size=UDim2.new(0.65,0,0,18); lb.Position=UDim2.new(0,10,0,3)
    lb.BackgroundTransparency=1; lb.Text=text; lb.TextColor3=TH.text; lb.TextSize=11; lb.Font=Enum.Font.Gotham; lb.TextXAlignment=Enum.TextXAlignment.Left
    local vl=Instance.new("TextLabel",f); vl.Size=UDim2.new(0.32,0,0,18); vl.Position=UDim2.new(0.66,0,0,3)
    vl.BackgroundTransparency=1; vl.Text=tostring(def); vl.TextColor3=TH.accent; vl.TextSize=13; vl.Font=Enum.Font.GothamBold; vl.TextXAlignment=Enum.TextXAlignment.Right
    local sbg=Instance.new("Frame",f); sbg.Size=UDim2.new(1,-20,0,7); sbg.Position=UDim2.new(0,10,0,29)
    sbg.BackgroundColor3=TH.slBg; sbg.BorderSizePixel=0; Instance.new("UICorner",sbg).CornerRadius=UDim.new(1,0)
    local sfl=Instance.new("Frame",sbg); sfl.Size=UDim2.new(math.clamp((def-mn)/(mx-mn),0,1),0,1,0)
    sfl.BackgroundColor3=TH.slFg; sfl.BorderSizePixel=0; Instance.new("UICorner",sfl).CornerRadius=UDim.new(1,0)
    local knob=Instance.new("Frame",sbg); knob.Size=UDim2.new(0,11,0,11); knob.AnchorPoint=Vector2.new(0.5,0.5)
    knob.Position=UDim2.new(math.clamp((def-mn)/(mx-mn),0,1),0,0.5,0)
    knob.BackgroundColor3=Color3.new(1,1,1); knob.BorderSizePixel=0; Instance.new("UICorner",knob).CornerRadius=UDim.new(1,0)
    local dr=false
    local sb=Instance.new("TextButton",sbg); sb.Size=UDim2.new(1,0,3,4); sb.Position=UDim2.new(0,0,-1,0); sb.BackgroundTransparency=1; sb.Text=""
    local function upd(mx2)
        local abs=sbg.AbsolutePosition; local sz=sbg.AbsoluteSize
        local rel=math.clamp((mx2-abs.X)/sz.X,0,1); local val=math.floor(mn+(mx-mn)*rel)
        sfl.Size=UDim2.new(rel,0,1,0); knob.Position=UDim2.new(rel,0,0.5,0); vl.Text=tostring(val); cb(val)
    end
    sb.MouseButton1Down:Connect(function() dr=true end)
    UserInputService.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then dr=false end end)
    UserInputService.InputChanged:Connect(function(i) if dr and i.UserInputType==Enum.UserInputType.MouseMovement then upd(i.Position.X) end end)
    sb.MouseButton1Click:Connect(function() upd(UserInputService:GetMouseLocation().X) end)
    Y=Y+49
end

local function Drp(text,opts,def,cb)
    local f=Instance.new("Frame",Content); f.Size=UDim2.new(1,-16,0,30); f.Position=UDim2.new(0,8,0,Y)
    f.BackgroundColor3=TH.item; f.BorderSizePixel=0; Instance.new("UICorner",f).CornerRadius=UDim.new(0,7)
    local lb=Instance.new("TextLabel",f); lb.Size=UDim2.new(0.5,0,1,0); lb.Position=UDim2.new(0,10,0,0)
    lb.BackgroundTransparency=1; lb.Text=text; lb.TextColor3=TH.text; lb.TextSize=12; lb.Font=Enum.Font.Gotham; lb.TextXAlignment=Enum.TextXAlignment.Left
    local idx=1; for i,o in ipairs(opts) do if o==def then idx=i end end
    local btn=Instance.new("TextButton",f); btn.Size=UDim2.new(0.46,0,0,22); btn.Position=UDim2.new(0.52,0,0.5,-11)
    btn.BackgroundColor3=Color3.fromRGB(24,24,46); btn.TextColor3=TH.accent; btn.TextSize=11; btn.Font=Enum.Font.GothamMedium
    btn.Text="◀  "..opts[idx].."  ▶"; btn.BorderSizePixel=0; Instance.new("UICorner",btn).CornerRadius=UDim.new(0,5)
    btn.MouseButton1Click:Connect(function()
        idx=idx%#opts+1; btn.Text="◀  "..opts[idx].."  ▶"; cb(opts[idx])
    end)
    Y=Y+33
end

local function Btn(text,col,cb)
    local b=Instance.new("TextButton",Content); b.Size=UDim2.new(1,-16,0,34); b.Position=UDim2.new(0,8,0,Y)
    b.BackgroundColor3=col or TH.item; b.TextColor3=TH.text; b.TextSize=12; b.Font=Enum.Font.GothamMedium
    b.Text=text; b.BorderSizePixel=0; Instance.new("UICorner",b).CornerRadius=UDim.new(0,7)
    local org=col or TH.item
    b.MouseEnter:Connect(function() TweenService:Create(b,TweenInfo.new(0.15),{BackgroundColor3=TH.btnH}):Play() end)
    b.MouseLeave:Connect(function() TweenService:Create(b,TweenInfo.new(0.15),{BackgroundColor3=org}):Play() end)
    b.MouseButton1Click:Connect(cb); Y=Y+37
end

local function Inf(title,body,tc)
    local ln=select(2,body:gsub("\n","\n"))+1; local h=24+ln*14+6
    local f=Instance.new("Frame",Content); f.Size=UDim2.new(1,-16,0,h); f.Position=UDim2.new(0,8,0,Y)
    f.BackgroundColor3=TH.inBg; f.BorderSizePixel=0; Instance.new("UICorner",f).CornerRadius=UDim.new(0,7)
    Instance.new("UIStroke",f).Color=Color3.fromRGB(32,32,55)
    local tl=Instance.new("TextLabel",f); tl.Size=UDim2.new(1,-10,0,16); tl.Position=UDim2.new(0,6,0,4)
    tl.BackgroundTransparency=1; tl.Text=title; tl.TextColor3=tc or TH.warn; tl.TextSize=11; tl.Font=Enum.Font.GothamBold; tl.TextXAlignment=Enum.TextXAlignment.Left
    local bl=Instance.new("TextLabel",f); bl.Size=UDim2.new(1,-10,0,h-24); bl.Position=UDim2.new(0,6,0,22)
    bl.BackgroundTransparency=1; bl.Text=body; bl.TextColor3=TH.dim; bl.TextSize=11; bl.Font=Enum.Font.Gotham
    bl.TextXAlignment=Enum.TextXAlignment.Left; bl.TextYAlignment=Enum.TextYAlignment.Top; bl.TextWrapped=true
    Y=Y+h+5
end

local function Gap(n) Y=Y+(n or 6) end

-- ══ СТРАНИЦЫ ══
local Pages={}

Pages.Combat=function()
    Sec(TL.aimSec)
    Tog(TL.aimOn,C.Aim.On,function(v) C.Aim.On=v end)
    Drp(TL.aMode,{"Hold","Toggle","Always"},"Hold",function(v) C.Aim.Mode=v end)
    Drp(TL.aPart,{"Head","HumanoidRootPart","Torso"},"Head",function(v) C.Aim.Part=v end)
    Sld(TL.aFOV,50,800,C.Aim.FOV,function(v) C.Aim.FOV=v end)
    Sld(TL.aSmooth,1,20,C.Aim.Smooth,function(v) C.Aim.Smooth=v end)
    Sld(TL.aPred,0,50,0,function(v) C.Aim.Pred=v/100 end)
    Tog(TL.aFovC,C.Aim.ShowFOV,function(v) C.Aim.ShowFOV=v end)
    Tog(TL.aTeam,C.Aim.Team,function(v) C.Aim.Team=v end)
    Tog(TL.aWall,C.Aim.Wall,function(v) C.Aim.Wall=v end)
    Gap()
    Sec(TL.hbSec)
    Tog(TL.hbOn,C.HB.On,function(v) C.HB.On=v; if v then RefreshAllHB() else CleanAllHB() end end)
    Sld(TL.hbSz,2,30,C.HB.Size,function(v) C.HB.Size=v; if C.HB.On then CleanAllHB(); RefreshAllHB() end end)
    Drp(TL.hbPt,{"Head","Torso","HumanoidRootPart","All"},"Head",function(v)
        C.HB.Part=v; C.HB.ExpandAll=(v=="All"); if C.HB.On then CleanAllHB(); RefreshAllHB() end
    end)
    Tog(TL.hbVis,C.HB.Vis,function(v) C.HB.Vis=v; if C.HB.On then CleanAllHB(); RefreshAllHB() end end)
    Inf("Info",TL.hbInfo,TH.ok)
end

Pages.Gun=function()
    Sec(TL.gSec)
    Tog(TL.gAmmo,C.Gun.InfAmmo,function(v) C.Gun.InfAmmo=v end)
    Tog(TL.gSpread,C.Gun.NoSpread,function(v) C.Gun.NoSpread=v end)
    Gap(); Sec(TL.gRSec)
    Tog(TL.gRap,C.Gun.RapidFire,function(v) C.Gun.RapidFire=v; if not v then StopRapid() end end)
    Tog(TL.gAuto,C.Gun.AutoFire,function(v) C.Gun.AutoFire=v; if not v then StopRapid() end end)
    Sld(TL.gSpd,10,200,C.Gun.RapidSpeed,function(v) C.Gun.RapidSpeed=v end)
    Btn("▶  "..TL.gTest,TH.item,DoFire)
    Inf("Warning",TL.gWarn.."\nmouse1click: "..(HasClick and "✓" or "✗").."  |  getgc: "..(HasGC and "✓" or "✗"))
end

Pages.Visual=function()
    Sec(TL.espSec)
    Tog(TL.espOn,C.ESP.On,function(v)
        C.ESP.On=v
        if v then for _,p in ipairs(Players:GetPlayers()) do if p~=LP and p.Character then CreateESP(p) end end
        else CleanESP() end
    end)
    Tog(TL.espBox,C.ESP.Box,function(v) C.ESP.Box=v end)
    Tog(TL.espName,C.ESP.Name,function(v) C.ESP.Name=v end)
    Tog(TL.espHP,C.ESP.HP,function(v) C.ESP.HP=v end)
    Tog(TL.espDist,C.ESP.Dist,function(v) C.ESP.Dist=v end)
    Tog(TL.espTeam,C.ESP.Team,function(v) C.ESP.Team=v end)
    Sld(TL.espMax,100,5000,C.ESP.Max,function(v) C.ESP.Max=v end)
    Gap(); Sec(TL.wSec)
    Tog(TL.fb,false,function(v)
        pcall(function()
            if v then Lighting.Brightness=3; Lighting.ClockTime=14; Lighting.FogEnd=1e9; Lighting.GlobalShadows=false; Lighting.Ambient=Color3.fromRGB(180,180,180)
            else Lighting.GlobalShadows=true; Lighting.Brightness=1; Lighting.Ambient=Color3.new(0,0,0) end
        end)
    end)
end

Pages.Move=function()
    Sec(TL.wsSec)
    Tog(TL.wsOn,C.WS.On,function(v) C.WS.On=v end)
    Sld(TL.wsVal,16,200,C.WS.Val,function(v) C.WS.Val=v end)
    Tog(TL.jpOn,C.JP.On,function(v) C.JP.On=v end)
    Sld(TL.jpVal,50,300,C.JP.Val,function(v) C.JP.Val=v end)
    Gap(); Sec(TL.mSec)
    Tog(TL.nf,C.NF,function(v) C.NF=v end)
    Tog(TL.ij,C.IJ,function(v) C.IJ=v end)
    Tog(TL.nc,C.NC,function(v) C.NC=v end)
    Gap(); Sec(TL.fSec)
    Tog(TL.flyOn,C.Fly.On,function(v) C.Fly.On=v; DoFly(v) end)
    Sld(TL.flySp,10,300,C.Fly.Sp,function(v) C.Fly.Sp=v end)
end

Pages.Anti=function()
    Sec(TL.acSec)
    Tog(TL.acR,C.Anti.Randomize,function(v) C.Anti.Randomize=v end)
    Tog(TL.acH,false,function(v)
        if v then pcall(function()
            for _,g in ipairs(GetRoot():GetChildren()) do
                if g:IsA("ScreenGui") and tostring(g.Name):find("ULTRA") then
                    g.Name=HttpService:GenerateGUID(false):sub(1,8)
                end
            end
        end) end
    end)
    Gap(); Sec(TL.acStat)
    Inf("Status",
        "hookmetamethod : "..(HasHook and "✅ ACTIVE" or "❌ N/A")..
        "\n__index spoof   : "..(HasHook and "✅ ON" or "❌ OFF")..
        "\n__newindex block: "..(HasHook and "✅ ON" or "❌ OFF")..
        "\ngetgc spoof     : "..(HasGC and "✅ ON" or "❌ OFF")..
        "\nDrawing API     : "..(DrawOK and "✅ YES" or "❌ NO")..
        "\nmouse1click     : "..(HasClick and "✅ YES" or "❌ NO"),TH.ok)
end

Pages.Info=function()
    Sec(TL.iSec)
    Inf("ULTRA BETA 2026",TL.iText,TH.accent)
    Gap(); Sec(TL.kSec)
    Inf("Controls",TL.kText,TH.sec)
    Gap(); Sec(TL.aSec)
    Btn(TL.rejoin,Color3.fromRGB(18,38,75),function() TeleportService:Teleport(game.PlaceId,LP) end)
    Btn(TL.unload,Color3.fromRGB(48,14,14),function()
        StopRapid(); CleanAllHB(); CleanESP(); DoFly(false)
        if FOVCircle then pcall(function() FOVCircle:Remove() end) end
        MenuGui:Destroy(); getgenv().ULTRA_BETA_LOADED=nil
    end)
end

-- ══ ТАБЫ ══
local PageKeys={"Combat","Gun","Visual","Move","Anti","Info"}
local TabBtns={}
local CurPage="Combat"

for i,k in ipairs(PageKeys) do
    local tb=Instance.new("TextButton",TabBar)
    tb.Size=UDim2.new(1/#PageKeys,0,1,0); tb.BackgroundColor3=i==1 and TH.accent or Color3.fromRGB(10,10,20)
    tb.BackgroundTransparency=i==1 and 0 or 0.4; tb.TextColor3=Color3.new(1,1,1)
    tb.TextSize=11; tb.Font=Enum.Font.GothamMedium; tb.Text=TL.tabs[i]; tb.BorderSizePixel=0; tb.LayoutOrder=i
    TabBtns[k]=tb
    tb.MouseButton1Click:Connect(function()
        CurPage=k
        for n,b in pairs(TabBtns) do
            TweenService:Create(b,TweenInfo.new(0.15),{
                BackgroundColor3=n==k and TH.accent or Color3.fromRGB(10,10,20),
                BackgroundTransparency=n==k and 0 or 0.4
            }):Play()
        end
        RC(); if Pages[k] then Pages[k]() end; SC()
    end)
end

RC(); Pages.Combat(); SC()

-- Видимость
task.spawn(function()
    while MenuGui.Parent do Win.Visible=C.MenuOpen; task.wait(0.05) end
end)

-- ══ УВЕДОМЛЕНИЕ ══
task.spawn(function()
    task.wait(0.8)
    local N=Instance.new("Frame",MenuGui)
    N.Size=UDim2.new(0,295,0,68); N.Position=UDim2.new(1,10,1,-85)
    N.BackgroundColor3=Color3.fromRGB(9,9,22); N.BorderSizePixel=0
    Instance.new("UICorner",N).CornerRadius=UDim.new(0,10)
    local NS=Instance.new("UIStroke",N); NS.Color=TH.accent; NS.Thickness=1.2
    local NT=Instance.new("TextLabel",N); NT.Size=UDim2.new(1,-10,0,22); NT.Position=UDim2.new(0,8,0,6)
    NT.BackgroundTransparency=1; NT.Text="⚡  ULTRA BETA 2026"; NT.TextColor3=TH.accent
    NT.TextSize=14; NT.Font=Enum.Font.GothamBlack; NT.TextXAlignment=Enum.TextXAlignment.Left
    local ND=Instance.new("TextLabel",N); ND.Size=UDim2.new(1,-10,0,38); ND.Position=UDim2.new(0,8,0,28)
    ND.BackgroundTransparency=1; ND.Text="Welcome, "..LP.DisplayName.."!\nBeta 2026 — License OK ✅"
    ND.TextColor3=TH.dim; ND.TextSize=11; ND.Font=Enum.Font.Gotham; ND.TextXAlignment=Enum.TextXAlignment.Left; ND.TextWrapped=true
    TweenService:Create(N,TweenInfo.new(0.5,Enum.EasingStyle.Back),{Position=UDim2.new(1,-305,1,-85)}):Play()
    task.wait(6)
    TweenService:Create(N,TweenInfo.new(0.4),{Position=UDim2.new(1,10,1,-85)}):Play()
    task.wait(0.5); N:Destroy()
end)

print("[ULTRA BETA 2026] ✅ Loaded!")
print("[ULTRA BETA 2026] FOV Circle: "..(DrawOK and "ON" or "OFF"))
print("[ULTRA BETA 2026] AntiDetect: "..(HasHook and "FULL" or "BASIC"))
print("[ULTRA BETA 2026] RightShift = toggle menu")
