-- =============================================
-- Script: BATO ULTIMATE UI v10.4
-- Features: Disable/Enable Hack + Auto Break Trees + Egg
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
-- حالة الهاك
-- ============================
local hackEnabled = true  -- الهاك شغال افتراضياً

-- ============================
-- إنشاء الواجهة
-- ============================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BatoUltimate"
screenGui.Parent = player.PlayerGui

-- ============================
-- العين الحمراء
-- ============================
local eyeFrame = Instance.new("Frame")
eyeFrame.Size = UDim2.new(0, 50, 0, 50)
eyeFrame.Position = UDim2.new(0.5, -25, 0.08, 0)
eyeFrame.BackgroundTransparency = 1
eyeFrame.Parent = screenGui

local eye = Instance.new("ImageLabel")
eye.Size = UDim2.new(1, 0, 1, 0)
eye.Image = "rbxassetid://6023426926"
eye.ImageColor3 = Color3.fromRGB(255, 0, 0)
eye.BackgroundTransparency = 1
eye.Parent = eyeFrame

-- ============================
-- الإطار الرئيسي
-- ============================
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 520, 0, 560) -- زيادة الارتفاع
mainFrame.Position = UDim2.new(0.5, -260, 0.5, -280)
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 0, 10)
mainFrame.BackgroundTransparency = 0.15
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.fromRGB(200, 0, 200)
mainFrame.Parent = screenGui

-- ============================
-- العنوان
-- ============================
local title = Instance.new("TextLabel")
title.Size = UDim2.new(0.7, 0, 0, 35)
title.Position = UDim2.new(0.15, 0, 0, 5)
title.Text = "🔥 BATO ULTIMATE"
title.TextColor3 = Color3.fromRGB(200, 0, 200)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.BackgroundTransparency = 1
title.Parent = mainFrame

-- ============================
-- زر قفل/فتح الواجهة
-- ============================
local toggleVisBtn = Instance.new("ImageButton")
toggleVisBtn.Size = UDim2.new(0, 30, 0, 30)
toggleVisBtn.Position = UDim2.new(0.01, 0, 0.01, 0)
toggleVisBtn.Image = "rbxassetid://6031094667"
toggleVisBtn.BackgroundTransparency = 1
toggleVisBtn.Parent = mainFrame

local isVisible = true
toggleVisBtn.MouseButton1Click:Connect(function()
    isVisible = not isVisible
    mainFrame.Visible = isVisible
    eyeFrame.Visible = isVisible
    toggleVisBtn.Image = isVisible and "rbxassetid://6031094667" or "rbxassetid://6031094554"
end)

-- ============================
-- زر LOCK
-- ============================
local lockBtn = Instance.new("TextButton")
lockBtn.Size = UDim2.new(0, 70, 0, 22)
lockBtn.Position = UDim2.new(0.5, -35, 0, 5)
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
    {name = "📍 TP", id = "tp", color = Color3.fromRGB(0, 200, 255)},
    {name = "⚡ Speed", id = "speed", color = Color3.fromRGB(0, 255, 0)},
    {name = "🛡️ Def", id = "def", color = Color3.fromRGB(255, 200, 0)},
    {name = "💀 Kill", id = "kill", color = Color3.fromRGB(255, 0, 0)},
    {name = "⚙️ Misc", id = "misc", color = Color3.fromRGB(200, 0, 200)}
}

local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 75, 0, 460)
sidebar.Position = UDim2.new(0, 0, 0.1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(15, 0, 15)
sidebar.BackgroundTransparency = 0.3
sidebar.BorderSizePixel = 1
sidebar.BorderColor3 = Color3.fromRGB(200, 0, 200)
sidebar.Parent = mainFrame

local sidebarButtons = {}
local currentSection = "tp"

for i, section in ipairs(sections) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.Position = UDim2.new(0.05, 0, 0, 15 + (i-1) * 42)
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
        if not hackEnabled then return end -- منع التنقل إذا الهاك معطل
        currentSection = section.id
        updateVisibleSection()
        for _, b in ipairs(sidebarButtons) do
            b.BackgroundColor3 = Color3.fromRGB(20, 0, 20)
            b.BackgroundTransparency = 0.5
        end
        btn.BackgroundColor3 = section.color
        btn.BackgroundTransparency = 0.2
    end)
end

-- ============================
-- المحتوى
-- ============================
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(0.8, 0, 0.85, 0)
contentFrame.Position = UDim2.new(0.17, 0, 0.1, 0)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

local sectionContents = {}
local function createSection(id)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 1
    frame.Parent = contentFrame
    sectionContents[id] = frame
    return frame
end

-- دالة إضافة زر (مع التحقق من حالة الهاك)
local function addButton(parent, text, y, color, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 28)
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
        if not isLocked and btn.Active and hackEnabled then
            btn.BackgroundTransparency = 0.1
            btn.Size = UDim2.new(0.92, 0, 0, 30)
        end
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundTransparency = 0.3
        btn.Size = UDim2.new(0.9, 0, 0, 28)
    end)

    btn.MouseButton1Click:Connect(function()
        if isLocked or not btn.Active or not hackEnabled then return end
        callback()
    end)
    return btn
end

-- ============================
-- 1. قسم TP
-- ============================
local tpFrame = createSection("tp")
local y = 5

local tpLocations = {
    {"🏠 Spawn", Vector3.new(0, 10, 0)},
    {"🏛️ Center", Vector3.new(100, 10, 100)},
    {"🌲 Forest", Vector3.new(-200, 10, -200)},
    {"🏜️ Desert", Vector3.new(300, 10, -100)},
    {"🌊 Ocean", Vector3.new(500, 10, 500)},
}

for _, loc in ipairs(tpLocations) do
    addButton(tpFrame, loc[1], y, Color3.fromRGB(0, 200, 255), function()
        hrp.CFrame = CFrame.new(loc[2])
    end)
    y = y + 35
end

-- ============================
-- 2. قسم Speed
-- ============================
local speedFrame = createSection("speed")
y = 5

local speeds = {
    {"🐢 Slow (10)", 10},
    {"🚶 Normal (16)", 16},
    {"🏃 Fast (50)", 50},
    {"💨 Super (100)", 100},
    {"⚡ Ultra (300)", 300},
}

for _, spd in ipairs(speeds) do
    addButton(speedFrame, spd[1], y, Color3.fromRGB(0, 255, 0), function()
        humanoid.WalkSpeed = spd[2]
    end)
    y = y + 35
end

-- ============================
-- 3. قسم Def
-- ============================
local defFrame = createSection("def")
y = 5

addButton(defFrame, "🛡️ God Mode", y, Color3.fromRGB(255, 200, 0), function()
    humanoid.MaxHealth = math.huge
    humanoid.Health = math.huge
end)
y = y + 35

addButton(defFrame, "❤️ Full Health", y, Color3.fromRGB(255, 200, 0), function()
    humanoid.Health = humanoid.MaxHealth
end)
y = y + 35

addButton(defFrame, "🔰 No Fall Damage", y, Color3.fromRGB(255, 200, 0), function()
    humanoid:GetPropertyChangedSignal("Health"):Connect(function()
        if humanoid.Health < 10 then
            humanoid.Health = 100
        end
    end)
end)
y = y + 35

addButton(defFrame, "🌀 Anti AFK", y, Color3.fromRGB(255, 200, 0), function()
    game:GetService("VirtualUser"):CaptureController()
    game:GetService("VirtualUser"):ClickButton2(Vector2.new())
    print("🔄 Anti AFK activated")
end)

-- ============================
-- 4. قسم Kill
-- ============================
local killFrame = createSection("kill")
y = 5

addButton(killFrame, "💀 Kill Self", y, Color3.fromRGB(255, 0, 0), function()
    char:BreakJoints()
end)
y = y + 35

addButton(killFrame, "🔫 Kill All", y, Color3.fromRGB(255, 0, 0), function()
    for _, p in ipairs(game.Players:GetPlayers()) do
        if p ~= player and p.Character then
            p.Character:BreakJoints()
        end
    end
end)
y = y + 35

addButton(killFrame, "💥 Explode", y, Color3.fromRGB(255, 0, 0), function()
    local explosion = Instance.new("Explosion")
    explosion.Position = hrp.Position
    explosion.BlastRadius = 20
    explosion.BlastDamage = 50
    explosion.Parent = game.Workspace
end)

-- ============================
-- 5. قسم Misc
-- ============================
local miscFrame = createSection("misc")
y = 5

-- ============================
-- 🔴 زر إيقاف الهاك
-- ============================
addButton(miscFrame, "🔴 Disable Hack", y, Color3.fromRGB(255, 0, 0), function()
    hackEnabled = false
    mainFrame.Visible = false
    eyeFrame.Visible = false
    print("🔴 Hack disabled. UI hidden.")
end)
y = y + 35

-- ============================
-- 🟢 زر تشغيل الهاك
-- ============================
addButton(miscFrame, "🟢 Enable Hack", y, Color3.fromRGB(0, 255, 0), function()
    hackEnabled = true
    mainFrame.Visible = true
    eyeFrame.Visible = true
    print("🟢 Hack enabled. UI shown.")
end)
y = y + 35

-- باقي الأزرار
addButton(miscFrame, "🌟 Fly (5s)", y, Color3.fromRGB(200, 0, 200), function()
    local fly = Instance.new("BodyVelocity")
    fly.MaxForce = Vector3.new(1, 1, 1) * 1000
    fly.Velocity = Vector3.new(0, 50, 0)
    fly.Parent = hrp
    wait(5)
    fly:Destroy()
end)
y = y + 35

addButton(miscFrame, "🔄 Respawn", y, Color3.fromRGB(200, 0, 200), function()
    char:BreakJoints()
    wait(0.5)
    player:LoadCharacter()
end)
y = y + 35

addButton(miscFrame, "🥚 Steal Egg", y, Color3.fromRGB(255, 165, 0), function()
    local egg = Instance.new("Part")
    egg.Size = Vector3.new(2, 3, 2)
    egg.Shape = Enum.PartType.Ball
    egg.BrickColor = BrickColor.new("Bright yellow")
    egg.Position = hrp.Position + Vector3.new(0, 5, 0)
    egg.Anchored = true
    egg.Parent = game.Workspace
    
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://9120393705"
    sound.Volume = 1
    sound.Parent = egg
    sound:Play()
    
    for i = 1, 20 do
        egg.CFrame = CFrame.new(hrp.Position + Vector3.new(0, 3, 0) + Vector3.new(math.sin(i/2), i/5, math.cos(i/2)))
        wait(0.05)
    end
    egg:Destroy()
    print("🥚 Egg stolen!")
end)
y = y + 35

addButton(miscFrame, "🔄 Return Egg", y, Color3.fromRGB(0, 255, 255), function()
    local egg = Instance.new("Part")
    egg.Size = Vector3.new(2, 3, 2)
    egg.Shape = Enum.PartType.Ball
    egg.BrickColor = BrickColor.new("Bright yellow")
    egg.Position = hrp.Position + Vector3.new(0, 10, 0)
    egg.Anchored = true
    egg.Parent = game.Workspace
    
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://9120393705"
    sound.Volume = 1
    sound.Parent = egg
    sound:Play()
    
    for i = 1, 30 do
        local t = i / 30
        local pos = Vector3.new(0, 10, 0) * (1 - t) + Vector3.new(0, 3, 0) * t
        egg.CFrame = CFrame.new(hrp.Position + pos)
        wait(0.03)
    end
    egg:Destroy()
    print("🔄 Egg returned to hand!")
end)
y = y + 35

addButton(miscFrame, "🪓 Auto Break Trees", y, Color3.fromRGB(34, 139, 34), function()
    print("🪓 Starting Auto Break Trees...")
    local treesBroken = 0
    for _, obj in ipairs(game.Workspace:GetDescendants()) do
        if obj:IsA("Part") or obj:IsA("Model") then
            local name = obj.Name:lower()
            if name:find("tree") or name:find("wood") or name:find("log") or name:find("branch") then
                pcall(function()
                    obj:Destroy()
                    treesBroken = treesBroken + 1
                    wait(0.05)
                end)
            end
        end
    end
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://9120393705"
    sound.Volume = 1
    sound.Parent = game.Workspace
    sound:Play()
    wait(0.5)
    sound:Destroy()
    print("🪓 Trees broken: " .. treesBroken)
end)
y = y + 35

addButton(miscFrame, "📊 Show Stats", y, Color3.fromRGB(200, 0, 200), function()
    print("📊 Health:", humanoid.Health, "Speed:", humanoid.WalkSpeed)
end)
y = y + 35

addButton(miscFrame, "👤 Player Info", y, Color3.fromRGB(200, 0, 200), function()
    print("👤 Name:", player.Name)
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
rights.Size = UDim2.new(1, 0, 0, 18)
rights.Position = UDim2.new(0, 0, 1, -22)
rights.Text = "© BATO | " .. (isAdmin and "👑 ADMIN" or "🔒 USER")
rights.TextColor3 = isAdmin and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(150, 0, 150)
rights.TextScaled = true
rights.Font = Enum.Font.Gotham
rights.BackgroundTransparency = 1
rights.Parent = mainFrame

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
        eyeFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X - 10, startPos.Y.Scale, startPos.Y.Offset + delta.Y - 10)
    end
end)

-- ============================
-- تشغيل السكربت
-- ============================
print("🔥 BATO ULTIMATE UI v10.4 Loaded.")
print("👑 Admin: Mohammad_kurdish73")
print("🔴 Disable Hack / 🟢 Enable Hack added.")
