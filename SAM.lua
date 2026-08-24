-- =============================================
-- Script: BATO ULTIMATE UI v9.0
-- Features: Working buttons, Left sidebar sections, Hide/Show toggle
-- Admin: Mohammad_kurdish73
-- Rights: BATO
-- =============================================

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local humanoid = char:WaitForChild("Humanoid")

-- ============================
-- قائمة الأدمن
-- ============================
local adminList = {
    "Mohammad_kurdish73",
}

local isAdmin = false
for _, name in ipairs(adminList) do
    if player.Name == name then
        isAdmin = true
        break
    end
end

-- ============================
-- إنشاء الواجهة
-- ============================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BatoUltimate"
screenGui.Parent = player.PlayerGui

-- خلفية
local bg = Instance.new("Frame")
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.fromRGB(5, 0, 5)
bg.Parent = screenGui

-- نجوم
for i = 1, 50 do
    local star = Instance.new("Frame")
    star.Size = UDim2.new(0, math.random(1, 3), 0, math.random(1, 3))
    star.Position = UDim2.new(math.random(), 0, math.random(), 0)
    star.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    star.BackgroundTransparency = math.random(3, 8) / 10
    star.Parent = bg
    game:GetService("RunService").RenderStepped:Connect(function()
        star.Position = UDim2.new(star.Position.X.Scale, 0, star.Position.Y.Scale + 0.001, 0)
        if star.Position.Y.Scale > 1 then
            star.Position = UDim2.new(math.random(), 0, 0, 0)
        end
    end)
end

-- ============================
-- الإطار الرئيسي
-- ============================
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 500, 0, 500)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -250)
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 0, 10)
mainFrame.BackgroundTransparency = 0.15
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.fromRGB(200, 0, 200)
mainFrame.Parent = screenGui

-- توهج
local glow = Instance.new("Frame")
glow.Size = UDim2.new(0, 520, 0, 520)
glow.Position = UDim2.new(0.5, -260, 0.5, -260)
glow.BackgroundColor3 = Color3.fromRGB(200, 0, 200)
glow.BackgroundTransparency = 0.9
glow.BorderSizePixel = 3
glow.BorderColor3 = Color3.fromRGB(200, 0, 200)
glow.Parent = screenGui

-- ============================
-- العين الحمراء
-- ============================
local eyeFrame = Instance.new("Frame")
eyeFrame.Size = UDim2.new(0, 60, 0, 60)
eyeFrame.Position = UDim2.new(0.5, -30, 0.1, 0)
eyeFrame.BackgroundTransparency = 1
eyeFrame.Parent = screenGui

local eye = Instance.new("ImageLabel")
eye.Size = UDim2.new(1, 0, 1, 0)
eye.Image = "rbxassetid://6023426926"
eye.ImageColor3 = Color3.fromRGB(255, 0, 0)
eye.BackgroundTransparency = 1
eye.Parent = eyeFrame

local eyePulse = 0
game:GetService("RunService").RenderStepped:Connect(function()
    eyePulse = eyePulse + 0.05
    local scale = 1 + math.sin(eyePulse * 5) * 0.05
    eye.Size = UDim2.new(scale, 0, scale, 0)
    eye.Position = UDim2.new(0.5 - scale/2, 0, 0.5 - scale/2, 0)
    eye.ImageTransparency = 0.3 + math.sin(eyePulse * 3) * 0.2
end)

-- ============================
-- العنوان والأزرار العلوية
-- ============================
local title = Instance.new("TextLabel")
title.Size = UDim2.new(0.7, 0, 0, 40)
title.Position = UDim2.new(0.15, 0, 0, 5)
title.Text = "🔥 BATO ULTIMATE"
title.TextColor3 = Color3.fromRGB(200, 0, 200)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.BackgroundTransparency = 1
title.Parent = mainFrame

-- زر إخفاء/إظهار الواجهة
local hideBtn = Instance.new("ImageButton")
hideBtn.Size = UDim2.new(0, 35, 0, 35)
hideBtn.Position = UDim2.new(1, -45, 0, 5)
hideBtn.Image = "rbxassetid://6031094667"
hideBtn.BackgroundTransparency = 1
hideBtn.Parent = mainFrame

-- زر القفل (يقفل كل الأزرار)
local lockBtn = Instance.new("TextButton")
lockBtn.Size = UDim2.new(0, 80, 0, 25)
lockBtn.Position = UDim2.new(0.5, -40, 0, 5)
lockBtn.Text = "🔒 LOCK"
lockBtn.TextColor3 = Color3.fromRGB(200, 0, 200)
lockBtn.TextScaled = true
lockBtn.Font = Enum.Font.GothamBold
lockBtn.BackgroundColor3 = Color3.fromRGB(30, 0, 30)
lockBtn.BorderSizePixel = 1
lockBtn.BorderColor3 = Color3.fromRGB(200, 0, 200)
lockBtn.Parent = mainFrame

local isLocked = false
local allButtons = {}

local function updateLock()
    isLocked = not isLocked
    lockBtn.Text = isLocked and "🔓 UNLOCK" or "🔒 LOCK"
    for _, btn in ipairs(allButtons) do
        btn.Active = not isLocked
        btn.TextTransparency = isLocked and 0.5 or 0
    end
end
lockBtn.MouseButton1Click:Connect(updateLock)

-- ============================
-- الأقسام على اليسار
-- ============================
local sections = {
    {name = "📌 General", id = "general", color = Color3.fromRGB(200, 0, 200)},
    {name = "👑 VIP", id = "vip", color = Color3.fromRGB(255, 215, 0)},
    {name = "⚙️ Scripts", id = "scripts", color = Color3.fromRGB(0, 200, 200)},
    {name = "ℹ️ Info", id = "info", color = Color3.fromRGB(200, 200, 0)}
}

local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 80, 0, 400)
sidebar.Position = UDim2.new(0, 0, 0.1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(15, 0, 15)
sidebar.BackgroundTransparency = 0.3
sidebar.BorderSizePixel = 1
sidebar.BorderColor3 = Color3.fromRGB(200, 0, 200)
sidebar.Parent = mainFrame

local sidebarButtons = {}
local currentSection = "general"

for i, section in ipairs(sections) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Position = UDim2.new(0.05, 0, 0, 20 + (i-1) * 45)
    btn.Text = section.name
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.TextScaled = true
    btn.Font = Enum.Font.Gotham
    btn.BackgroundColor3 = Color3.fromRGB(20, 0, 20)
    btn.BackgroundTransparency = 0.5
    btn.BorderSizePixel = 1
    btn.BorderColor3 = section.color
    btn.Parent = sidebar
    table.insert(sidebarButtons, btn)

    btn.MouseButton1Click:Connect(function()
        currentSection = section.id
        updateVisibleSection()
        for _, b in ipairs(sidebarButtons) do
            b.BackgroundColor3 = Color3.fromRGB(20, 0, 20)
        end
        btn.BackgroundColor3 = section.color
        btn.BackgroundTransparency = 0.2
    end)
end

-- ============================
-- المحتوى حسب القسم
-- ============================
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(0.8, 0, 0.85, 0)
contentFrame.Position = UDim2.new(0.18, 0, 0.1, 0)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

local sectionContents = {}
local currentY = 0

-- دالة لإضافة أزرار لكل قسم
local function addButton(parent, text, y, color, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 30)
    btn.Position = UDim2.new(0.05, 0, 0, y)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextScaled = true
    btn.Font = Enum.Font.Gotham
    btn.BackgroundColor3 = Color3.fromRGB(15, 0, 15)
    btn.BackgroundTransparency = 0.3
    btn.BorderSizePixel = 1
    btn.BorderColor3 = color
    btn.Parent = parent
    table.insert(allButtons, btn)

    btn.MouseEnter:Connect(function()
        if not isLocked and btn.Active then
            btn.BackgroundTransparency = 0.1
            btn.Size = UDim2.new(0.92, 0, 0, 32)
        end
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundTransparency = 0.3
        btn.Size = UDim2.new(0.9, 0, 0, 30)
    end)

    btn.MouseButton1Click:Connect(function()
        if isLocked or not btn.Active then return end
        callback()
    end)
    return btn
end

-- ============================
-- قسم GENERAL
-- ============================
local generalFrame = Instance.new("Frame")
generalFrame.Size = UDim2.new(1, 0, 1, 0)
generalFrame.BackgroundTransparency = 1
generalFrame.Parent = contentFrame
sectionContents["general"] = generalFrame

local yPos = 10
local slowActive = false
addButton(generalFrame, "🐢 Slow Mode: OFF", yPos, Color3.fromRGB(200, 0, 200), function()
    slowActive = not slowActive
    allButtons[1].Text = slowActive and "🐢 Slow Mode: ON" or "🐢 Slow Mode: OFF"
    if slowActive then
        game:GetService("RunService").Stepped:Connect(function()
            while slowActive do wait(0.3) end
        end)
    end
end)
yPos = yPos + 38

local bypassActive = false
addButton(generalFrame, "🛡️ Bypass: OFF", yPos, Color3.fromRGB(200, 0, 200), function()
    bypassActive = not bypassActive
    allButtons[2].Text = bypassActive and "🛡️ Bypass: ON" or "🛡️ Bypass: OFF"
end)
yPos = yPos + 38

addButton(generalFrame, "🚶 Move to Stand", yPos, Color3.fromRGB(200, 0, 200), function()
    local stand = Instance.new("Part")
    stand.Size = Vector3.new(8, 1, 8)
    stand.Position = hrp.Position + Vector3.new(0, 5, 10)
    stand.Anchored = true
    stand.BrickColor = BrickColor.new("Bright red")
    stand.Parent = game.Workspace
    hrp.CFrame = CFrame.new(stand.Position + Vector3.new(0, 2, 0))
    game:GetService("Debris"):AddItem(stand, 5)
end)
yPos = yPos + 38

addButton(generalFrame, "💀 Respawn", yPos, Color3.fromRGB(200, 0, 200), function()
    char:BreakJoints()
    wait(0.5)
    player:LoadCharacter()
end)

-- ============================
-- قسم VIP (للأدمن فقط)
-- ============================
local vipFrame = Instance.new("Frame")
vipFrame.Size = UDim2.new(1, 0, 1, 0)
vipFrame.BackgroundTransparency = 1
vipFrame.Parent = contentFrame
sectionContents["vip"] = vipFrame

if isAdmin then
    yPos = 10
    addButton(vipFrame, "🌟 Fly (5s)", yPos, Color3.fromRGB(255, 215, 0), function()
        local fly = Instance.new("BodyVelocity")
        fly.MaxForce = Vector3.new(1, 1, 1) * 1000
        fly.Velocity = Vector3.new(0, 50, 0)
        fly.Parent = hrp
        wait(5)
        fly:Destroy()
    end)
    yPos = yPos + 38
    
    addButton(vipFrame, "💨 Super Speed", yPos, Color3.fromRGB(255, 215, 0), function()
        humanoid.WalkSpeed = 100
    end)
    yPos = yPos + 38
    
    addButton(vipFrame, "🛡️ God Mode", yPos, Color3.fromRGB(255, 215, 0), function()
        humanoid.MaxHealth = math.huge
        humanoid.Health = math.huge
    end)
    yPos = yPos + 38
    
    addButton(vipFrame, "🔫 Kill All", yPos, Color3.fromRGB(255, 0, 0), function()
        for _, p in ipairs(game.Players:GetPlayers()) do
            if p ~= player then
                p.Character:BreakJoints()
            end
        end
    end)
else
    local locked = Instance.new("TextLabel")
    locked.Size = UDim2.new(1, 0, 1, 0)
    locked.Text = "🔒 VIP LOCKED\nAdmin Only"
    locked.TextColor3 = Color3.fromRGB(100, 100, 100)
    locked.TextScaled = true
    locked.Font = Enum.Font.Gotham
    locked.BackgroundTransparency = 1
    locked.Parent = vipFrame
end

-- ============================
-- قسم SCRIPTS
-- ============================
local scriptsFrame = Instance.new("Frame")
scriptsFrame.Size = UDim2.new(1, 0, 1, 0)
scriptsFrame.BackgroundTransparency = 1
scriptsFrame.Parent = contentFrame
sectionContents["scripts"] = scriptsFrame

yPos = 10
addButton(scriptsFrame, "📜 Load Script", yPos, Color3.fromRGB(0, 200, 200), function()
    print("📜 Loading script...")
    -- loadstring(game:HttpGet("https://raw.githubusercontent.com/example/script.lua"))()
end)
yPos = yPos + 38

addButton(scriptsFrame, "🔄 Reload UI", yPos, Color3.fromRGB(0, 200, 200), function()
    screenGui:Destroy()
    print("🔄 UI Reloaded")
end)

-- ============================
-- قسم INFO
-- ============================
local infoFrame = Instance.new("Frame")
infoFrame.Size = UDim2.new(1, 0, 1, 0)
infoFrame.BackgroundTransparency = 1
infoFrame.Parent = contentFrame
sectionContents["info"] = infoFrame

yPos = 10
addButton(infoFrame, "📊 Show Stats", yPos, Color3.fromRGB(200, 200, 0), function()
    print("📊 Health:", humanoid.Health, "Speed:", humanoid.WalkSpeed)
end)
yPos = yPos + 38

addButton(infoFrame, "👤 Player Info", yPos, Color3.fromRGB(200, 200, 0), function()
    print("👤 Name:", player.Name)
    print("Team:", player.TeamColor and player.TeamColor.Name or "None")
    print("Admin:", isAdmin and "YES" or "NO")
end)

-- ============================
-- تحديث إظهار الأقسام
-- ============================
local function updateVisibleSection()
    for id, frame in pairs(sectionContents) do
        frame.Visible = (id == currentSection)
    end
end
updateVisibleSection()

-- ============================
-- حقوق
-- ============================
local rights = Instance.new("TextLabel")
rights.Size = UDim2.new(1, 0, 0, 20)
rights.Position = UDim2.new(0, 0, 1, -25)
rights.Text = "© BATO | " .. (isAdmin and "👑 ADMIN: Mohammad_kurdish73" or "🔒 USER")
rights.TextColor3 = isAdmin and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(150, 0, 150)
rights.TextScaled = true
rights.Font = Enum.Font.Gotham
rights.BackgroundTransparency = 1
rights.Parent = mainFrame

-- ============================
-- زر إخفاء/إظهار الواجهة
-- ============================
local isVisible = true
hideBtn.MouseButton1Click:Connect(function()
    isVisible = not isVisible
    mainFrame.Visible = isVisible
    glow.Visible = isVisible
    eyeFrame.Visible = isVisible
    hideBtn.Image = isVisible and "rbxassetid://6031094667" or "rbxassetid://6031094554"
end)

-- ============================
-- سحب الواجهة
-- ============================
local dragging = false
local dragStart, startPos

mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

mainFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        glow.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X - 10, startPos.Y.Scale, startPos.Y.Offset + delta.Y - 10)
        eyeFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X - 10, startPos.Y.Scale, startPos.Y.Offset + delta.Y - 10)
    end
end)

-- ============================
-- تشغيل السكربت
-- ============================
print("🔥 BATO ULTIMATE UI v9.0 Loaded.")
print("👑 Admin: Mohammad_kurdish73")
print("🌟 All VIP features unlocked.")
