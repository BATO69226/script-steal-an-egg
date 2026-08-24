-- =============================================
-- Script: BATO ADVANCED UI v7.0
-- Style: Like the TikTok video
-- Sections: The Beginning | Scripts | Information
-- Rights: BATO
-- =============================================

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local humanoid = char:WaitForChild("Humanoid")

-- GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BatoAdvanced"
screenGui.Parent = player.PlayerGui

-- Background (animated gradient)
local bg = Instance.new("Frame")
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.fromRGB(5, 0, 5)
bg.Parent = screenGui

-- Animated background particles (stars)
for i = 1, 30 do
    local star = Instance.new("Frame")
    star.Size = UDim2.new(0, 2, 0, 2)
    star.Position = UDim2.new(math.random(), 0, math.random(), 0)
    star.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    star.BackgroundTransparency = 0.5
    star.Parent = bg
    game:GetService("RunService").RenderStepped:Connect(function()
        star.Position = UDim2.new(star.Position.X.Scale, 0, star.Position.Y.Scale + 0.001, 0)
        if star.Position.Y.Scale > 1 then star.Position = UDim2.new(math.random(), 0, 0, 0) end
    end)
end

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 450, 0, 600)
mainFrame.Position = UDim2.new(0.5, -225, 0.5, -300)
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 0, 10)
mainFrame.BackgroundTransparency = 0.2
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.fromRGB(200, 0, 200)
mainFrame.Parent = screenGui

-- Glow
local glow = Instance.new("Frame")
glow.Size = UDim2.new(0, 470, 0, 620)
glow.Position = UDim2.new(0.5, -235, 0.5, -310)
glow.BackgroundColor3 = Color3.fromRGB(200, 0, 200)
glow.BackgroundTransparency = 0.9
glow.BorderSizePixel = 3
glow.BorderColor3 = Color3.fromRGB(200, 0, 200)
glow.Parent = screenGui

-- Title (neon pulse)
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 50)
title.Position = UDim2.new(0, 0, 0, 5)
title.Text = "🔥 BATO ADVANCED"
title.TextColor3 = Color3.fromRGB(200, 0, 200)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.BackgroundTransparency = 1
title.Parent = mainFrame

-- Title pulse
game:GetService("RunService").RenderStepped:Connect(function()
    local pulse = (math.sin(tick() * 3) + 1) / 2
    title.TextColor3 = Color3.new(0.5 + pulse * 0.5, 0, 0.5 + pulse * 0.5)
end)

-- Glow pulse
game:GetService("RunService").RenderStepped:Connect(function()
    local pulse = (math.sin(tick() * 2) + 1) / 2
    glow.BorderColor3 = Color3.new(0.5 + pulse * 0.5, 0, 0.5 + pulse * 0.5)
    glow.BackgroundTransparency = 0.7 + pulse * 0.2
end)

-- Rights
local rights = Instance.new("TextLabel")
rights.Size = UDim2.new(1, 0, 0, 20)
rights.Position = UDim2.new(0, 0, 1, -25)
rights.Text = "© BATO"
rights.TextColor3 = Color3.fromRGB(150, 0, 150)
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
lockBtn.Size = UDim2.new(0, 90, 0, 30)
lockBtn.Position = UDim2.new(0.5, -45, 0, 5)
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
    lockBtn.BackgroundColor3 = isLocked and Color3.fromRGB(50, 0, 50) or Color3.fromRGB(30, 0, 30)
    for _, btn in ipairs(allButtons) do
        btn.Active = not isLocked
        btn.TextTransparency = isLocked and 0.5 or 0
    end
end
lockBtn.MouseButton1Click:Connect(updateLock)

-- ============================
-- الأقسام
-- ============================
local yPos = 55
local sections = {
    {name = "📌 THE BEGINNING", color = Color3.fromRGB(200, 0, 200)},
    {name = "⚙️ SCRIPTS", color = Color3.fromRGB(0, 200, 200)},
    {name = "ℹ️ INFORMATION", color = Color3.fromRGB(200, 200, 0)}
}

for _, section in ipairs(sections) do
    local secLabel = Instance.new("TextLabel")
    secLabel.Size = UDim2.new(0.95, 0, 0, 30)
    secLabel.Position = UDim2.new(0.025, 0, 0, yPos)
    secLabel.Text = section.name
    secLabel.TextColor3 = section.color
    secLabel.TextScaled = true
    secLabel.Font = Enum.Font.GothamBold
    secLabel.BackgroundColor3 = Color3.fromRGB(20, 0, 20)
    secLabel.BackgroundTransparency = 0.5
    secLabel.BorderSizePixel = 1
    secLabel.BorderColor3 = section.color
    secLabel.Parent = mainFrame
    yPos = yPos + 37

    -- أزرار لكل قسم
    local btnCount = 2
    for i = 1, btnCount do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.85, 0, 0, 28)
        btn.Position = UDim2.new(0.075, 0, 0, yPos)
        btn.Text = section.name == "📌 THE BEGINNING" and (i == 1 and "▶️ Start" or "⏹️ Stop") or
                   section.name == "⚙️ SCRIPTS" and (i == 1 and "📜 Load Script" or "🔄 Reload") or
                   "📊 Stats"
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextScaled = true
        btn.Font = Enum.Font.Gotham
        btn.BackgroundColor3 = Color3.fromRGB(15, 0, 15)
        btn.BackgroundTransparency = 0.3
        btn.BorderSizePixel = 1
        btn.BorderColor3 = section.color
        btn.Parent = mainFrame
        table.insert(allButtons, btn)

        btn.MouseEnter:Connect(function()
            if not isLocked then
                btn.BackgroundTransparency = 0.1
                btn.Size = UDim2.new(0.87, 0, 0, 30)
            end
        end)
        btn.MouseLeave:Connect(function()
            btn.BackgroundTransparency = 0.3
            btn.Size = UDim2.new(0.85, 0, 0, 28)
        end)

        btn.MouseButton1Click:Connect(function()
            if isLocked then return end
            if btn.Text == "▶️ Start" then
                print("▶️ Starting...")
                humanoid.WalkSpeed = 16
            elseif btn.Text == "⏹️ Stop" then
                print("⏹️ Stopping...")
                humanoid.WalkSpeed = 0
            elseif btn.Text == "📜 Load Script" then
                print("📜 Loading script...")
                loadstring(game:HttpGet("https://raw.githubusercontent.com/example/script.lua"))()
            elseif btn.Text == "🔄 Reload" then
                print("🔄 Reloading...")
                game:GetService("CoreGui"):FindFirstChild("BatoAdvanced"):Destroy()
                -- إعادة تحميل السكربت (يمكنك وضع الكود هنا)
            elseif btn.Text == "📊 Stats" then
                print("📊 Player:", player.Name)
                print("Health:", humanoid.Health)
                print("Speed:", humanoid.WalkSpeed)
            end
        end)
        yPos = yPos + 35
    end
    yPos = yPos + 10
end

-- Stats display
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
    end
end)

print("🔥 BATO ADVANCED UI v7.0 Loaded.")
print("👑 All commands ready for the USER.")
