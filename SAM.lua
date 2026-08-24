-- =============================================
-- Script: BATO ULTIMATE UI v8.1
-- Admin: Mohammad_kurdish73
-- Rights: BATO
-- =============================================

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local humanoid = char:WaitForChild("Humanoid")

-- ============================
-- قائمة الأدمن (محدثة)
-- ============================
local adminList = {
    "Mohammad_kurdish73",  -- الأدمن الجديد
    -- يمكنك إضافة المزيد هنا
}

local isAdmin = false
for _, name in ipairs(adminList) do
    if player.Name == name then
        isAdmin = true
        break
    end
end

-- ============================
-- باقي الكود (نفسه مع تحسينات بسيطة)
-- ============================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BatoUltimate"
screenGui.Parent = player.PlayerGui

-- الخلفية
local bg = Instance.new("Frame")
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.fromRGB(5, 0, 5)
bg.Parent = screenGui

-- نجوم متحركة
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

-- العين الحمراء
local eyeFrame = Instance.new("Frame")
eyeFrame.Size = UDim2.new(0, 80, 0, 80)
eyeFrame.Position = UDim2.new(0.5, -40, 0.15, 0)
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

-- الإطار الرئيسي
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 400, 0, 500)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 0, 10)
mainFrame.BackgroundTransparency = 0.15
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.fromRGB(200, 0, 200)
mainFrame.Parent = screenGui

local glow = Instance.new("Frame")
glow.Size = UDim2.new(0, 420, 0, 520)
glow.Position = UDim2.new(0.5, -210, 0.5, -210)
glow.BackgroundColor3 = Color3.fromRGB(200, 0, 200)
glow.BackgroundTransparency = 0.9
glow.BorderSizePixel = 3
glow.BorderColor3 = Color3.fromRGB(200, 0, 200)
glow.Parent = screenGui

-- العنوان
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 5)
title.Text = "🔥 BATO ULTIMATE"
title.TextColor3 = Color3.fromRGB(200, 0, 200)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.BackgroundTransparency = 1
title.Parent = mainFrame

game:GetService("RunService").RenderStepped:Connect(function()
    local pulse = (math.sin(tick() * 3) + 1) / 2
    title.TextColor3 = Color3.new(0.5 + pulse * 0.5, 0, 0.5 + pulse * 0.5)
end)

-- حقوق مع اسم الأدمن
local rights = Instance.new("TextLabel")
rights.Size = UDim2.new(1, 0, 0, 20)
rights.Position = UDim2.new(0, 0, 1, -25)
rights.Text = "© BATO | " .. (isAdmin and "👑 ADMIN: Mohammad_kurdish73" or "🔒 USER")
rights.TextColor3 = isAdmin and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(150, 0, 150)
rights.TextScaled = true
rights.Font = Enum.Font.Gotham
rights.BackgroundTransparency = 1
rights.Parent = mainFrame

-- Toggle
local toggleBtn = Instance.new("ImageButton")
toggleBtn.Size = UDim2.new(0, 35, 0, 35)
toggleBtn.Position = UDim2.new(1, -45, 0, 5)
toggleBtn.Image = "rbxassetid://6031094667"
toggleBtn.BackgroundTransparency = 1
toggleBtn.Parent = mainFrame

-- Lock
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

-- الأقسام
local yPos = 50
local sections = {
    {name = "📌 GENERAL", color = Color3.fromRGB(200, 0, 200), adminOnly = false},
    {name = "👑 VIP", color = Color3.fromRGB(255, 215, 0), adminOnly = true},
    {name = "⚙️ SCRIPTS", color = Color3.fromRGB(0, 200, 200), adminOnly = false},
    {name = "ℹ️ INFO", color = Color3.fromRGB(200, 200, 0), adminOnly = false}
}

for _, section in ipairs(sections) do
    local secLabel = Instance.new("TextLabel")
    secLabel.Size = UDim2.new(0.95, 0, 0, 25)
    secLabel.Position = UDim2.new(0.025, 0, 0, yPos)
    secLabel.Text = section.name .. (section.adminOnly and " ⚠️" or "")
    secLabel.TextColor3 = section.color
    secLabel.TextScaled = true
    secLabel.Font = Enum.Font.GothamBold
    secLabel.BackgroundColor3 = Color3.fromRGB(20, 0, 20)
    secLabel.BackgroundTransparency = 0.5
    secLabel.BorderSizePixel = 1
    secLabel.BorderColor3 = section.color
    secLabel.Parent = mainFrame
    yPos = yPos + 32

    local btnCount = section.adminOnly and 3 or 2
    for i = 1, btnCount do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.85, 0, 0, 25)
        btn.Position = UDim2.new(0.075, 0, 0, yPos)
        
        if section.name == "📌 GENERAL" then
            btn.Text = i == 1 and "▶️ Start" or "⏹️ Stop"
        elseif section.name == "👑 VIP" then
            btn.Text = i == 1 and "🌟 Fly" or (i == 2 and "💨 Super Speed" or "🛡️ God Mode")
        elseif section.name == "⚙️ SCRIPTS" then
            btn.Text = i == 1 and "📜 Load Script" or "🔄 Reload UI"
        else
            btn.Text = i == 1 and "📊 Stats" or "👤 Player Info"
        end
        
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextScaled = true
        btn.Font = Enum.Font.Gotham
        btn.BackgroundColor3 = Color3.fromRGB(15, 0, 15)
        btn.BackgroundTransparency = 0.3
        btn.BorderSizePixel = 1
        btn.BorderColor3 = section.color
        btn.Parent = mainFrame
        table.insert(allButtons, btn)

        if section.adminOnly and not isAdmin then
            btn.Text = "🔒 " .. btn.Text
            btn.TextColor3 = Color3.fromRGB(100, 100, 100)
            btn.Active = false
        end

        btn.MouseEnter:Connect(function()
            if not isLocked and btn.Active then
                btn.BackgroundTransparency = 0.1
                btn.Size = UDim2.new(0.87, 0, 0, 27)
            end
        end)
        btn.MouseLeave:Connect(function()
            btn.BackgroundTransparency = 0.3
            btn.Size = UDim2.new(0.85, 0, 0, 25)
        end)

        btn.MouseButton1Click:Connect(function()
            if isLocked or not btn.Active then return end
            
            if btn.Text == "▶️ Start" then
                humanoid.WalkSpeed = 16
                print("▶️ Started")
            elseif btn.Text == "⏹️ Stop" then
                humanoid.WalkSpeed = 0
                print("⏹️ Stopped")
            elseif btn.Text == "📜 Load Script" then
                print("📜 Loading script...")
            elseif btn.Text == "🔄 Reload UI" then
                screenGui:Destroy()
                print("🔄 UI Reloaded")
            elseif btn.Text == "📊 Stats" then
                print("📊 Health:", humanoid.Health, "Speed:", humanoid.WalkSpeed)
            elseif btn.Text == "👤 Player Info" then
                print("👤 Name:", player.Name, "Team:", player.TeamColor and player.TeamColor.Name or "None")
            elseif btn.Text == "🌟 Fly" and isAdmin then
                local fly = Instance.new("BodyVelocity")
                fly.MaxForce = Vector3.new(1, 1, 1) * 1000
                fly.Velocity = Vector3.new(0, 50, 0)
                fly.Parent = hrp
                wait(5)
                fly:Destroy()
            elseif btn.Text == "💨 Super Speed" and isAdmin then
                humanoid.WalkSpeed = 100
            elseif btn.Text == "🛡️ God Mode" and isAdmin then
                humanoid.MaxHealth = math.huge
                humanoid.Health = math.huge
            end
        end)
        yPos = yPos + 32
    end
    yPos = yPos + 10
end

-- Stats
local stats = Instance.new("TextLabel")
stats.Size = UDim2.new(1, 0, 0, 25)
stats.Position = UDim2.new(0, 0, 1, -50)
stats.Text = "💰 43.2M | $1.9T | ⏱ 1m 14s"
stats.TextColor3 = Color3.fromRGB(200, 0, 200)
stats.TextScaled = true
stats.Font = Enum.Font.GothamBold
stats.BackgroundTransparency = 1
stats.Parent = mainFrame

-- Toggle UI
local isOpen = true
toggleBtn.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    mainFrame.Visible = isOpen
    glow.Visible = isOpen
    eyeFrame.Visible = isOpen
    toggleBtn.Image = isOpen and "rbxassetid://6031094667" or "rbxassetid://6031094554"
end)

-- Dragging
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
print("🔥 BATO ULTIMATE UI v8.1 Loaded.")
print("👑 Admin: Mohammad_kurdish73")
print("🌟 All VIP features unlocked for you.")
