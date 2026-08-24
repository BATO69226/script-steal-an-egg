-- =============================================
-- Script: BATO MINI PANEL v4.0
-- Language: English
-- Features: Compact UI, Open Sound, Single Lock Toggle
-- Rights: BATO
-- =============================================

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local humanoid = char:WaitForChild("Humanoid")

-- GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BatoMini"
screenGui.Parent = player.PlayerGui

-- Sound (when UI opens)
local openSound = Instance.new("Sound")
openSound.SoundId = "rbxassetid://9120393705" -- نغمة جميلة (يمكنك تغيير الـ ID)
openSound.Volume = 0.5
openSound.Parent = screenGui

-- Background Effect (animated particles)
local bg = Instance.new("Frame")
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
bg.BackgroundTransparency = 0.5
bg.Parent = screenGui

-- Glow border (smaller)
local glow = Instance.new("Frame")
glow.Size = UDim2.new(0, 320, 0, 460)
glow.Position = UDim2.new(0.5, -160, 0.5, -230)
glow.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
glow.BackgroundTransparency = 0.8
glow.BorderSizePixel = 3
glow.BorderColor3 = Color3.fromRGB(255, 0, 0)
glow.Parent = screenGui

-- Main Frame (smaller)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 440)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -220)
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 0, 0)
mainFrame.BackgroundTransparency = 0.15
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
mainFrame.Parent = screenGui

-- Title (smaller, animated pulse)
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 5)
title.Text = "🔥 BATO PANEL"
title.TextColor3 = Color3.fromRGB(255, 0, 0)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.BackgroundTransparency = 1
title.Parent = mainFrame

-- Pulse animation for title
game:GetService("RunService").RenderStepped:Connect(function()
    local pulse = (math.sin(tick() * 3) + 1) / 2
    title.TextColor3 = Color3.new(0.5 + pulse * 0.5, 0, 0)
end)

-- Glow animation
game:GetService("RunService").RenderStepped:Connect(function()
    local pulse = (math.sin(tick() * 2) + 1) / 2
    glow.BackgroundTransparency = 0.5 + pulse * 0.3
    glow.BorderColor3 = Color3.new(0.5 + pulse * 0.5, 0, 0)
end)

-- BATO Rights
local rights = Instance.new("TextLabel")
rights.Size = UDim2.new(1, 0, 0, 20)
rights.Position = UDim2.new(0, 0, 1, -25)
rights.Text = "© BATO"
rights.TextColor3 = Color3.fromRGB(150, 0, 0)
rights.TextScaled = true
rights.Font = Enum.Font.Gotham
rights.BackgroundTransparency = 1
rights.Parent = mainFrame

-- Toggle Button (Hide/Show UI)
local toggleBtn = Instance.new("ImageButton")
toggleBtn.Size = UDim2.new(0, 35, 0, 35)
toggleBtn.Position = UDim2.new(1, -45, 0, 5)
toggleBtn.Image = "rbxassetid://6031094667" -- قفل
toggleBtn.BackgroundTransparency = 1
toggleBtn.Parent = mainFrame

-- Single Lock/Unlock Button (toggle)
local lockToggleBtn = Instance.new("ImageButton")
lockToggleBtn.Size = UDim2.new(0, 30, 0, 30)
lockToggleBtn.Position = UDim2.new(0, 10, 0, 10)
lockToggleBtn.Image = "rbxassetid://6031094667" -- قفل (مغلق)
lockToggleBtn.BackgroundTransparency = 1
lockToggleBtn.Parent = mainFrame

-- State
local isLocked = false

-- Function to toggle lock
local function toggleLock()
    isLocked = not isLocked
    if isLocked then
        lockToggleBtn.Image = "rbxassetid://6031094554" -- فتح
        for _, btn in ipairs(buttons) do
            btn.Active = false
            btn.TextTransparency = 0.5
        end
    else
        lockToggleBtn.Image = "rbxassetid://6031094667" -- قفل
        for _, btn in ipairs(buttons) do
            btn.Active = true
            btn.TextTransparency = 0
        end
    end
end

lockToggleBtn.MouseButton1Click:Connect(toggleLock)

-- Buttons (smaller)
local yPos = 50
local buttons = {}

local function createButton(text, y, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 30)
    btn.Position = UDim2.new(0.05, 0, 0, y)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 50, 50)
    btn.TextScaled = true
    btn.Font = Enum.Font.Gotham
    btn.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
    btn.BackgroundTransparency = 0.3
    btn.BorderSizePixel = 1
    btn.BorderColor3 = Color3.fromRGB(255, 0, 0)
    btn.Parent = mainFrame
    table.insert(buttons, btn)
    
    -- Hover animation
    btn.MouseEnter:Connect(function()
        btn.BackgroundTransparency = 0.1
        btn.Size = UDim2.new(0.92, 0, 0, 32)
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundTransparency = 0.3
        btn.Size = UDim2.new(0.9, 0, 0, 30)
    end)
    
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- 1. Slow Mode
local slowActive = false
createButton("🐢 Slow: OFF", yPos, function()
    slowActive = not slowActive
    if slowActive then
        game:GetService("RunService").Stepped:Connect(function()
            if slowActive then wait(0.3) end
        end)
        buttons[1].Text = "🐢 Slow: ON"
    else
        buttons[1].Text = "🐢 Slow: OFF"
    end
end)
yPos = yPos + 37

-- 2. Bypass Anti Cheat
local bypassActive = false
createButton("🛡️ Bypass: OFF", yPos, function()
    bypassActive = not bypassActive
    buttons[2].Text = bypassActive and "🛡️ Bypass: ON" or "🛡️ Bypass: OFF"
end)
yPos = yPos + 37

-- 3. Shop
createButton("🛒 Shop", yPos, function()
    print("🛒 Shop opened (simulated)")
end)
yPos = yPos + 37

-- 4. Move to Stand
createButton("🚶 Move Stand", yPos, function()
    local stand = Instance.new("Part")
    stand.Size = Vector3.new(8, 1, 8)
    stand.Position = hrp.Position + Vector3.new(0, 5, 10)
    stand.Anchored = true
    stand.BrickColor = BrickColor.new("Bright red")
    stand.Parent = game.Workspace
    hrp.CFrame = CFrame.new(stand.Position + Vector3.new(0, 2, 0))
    game:GetService("Debris"):AddItem(stand, 5)
end)
yPos = yPos + 37

-- 5. Respawn
createButton("💀 Respawn", yPos, function()
    char:BreakJoints()
    wait(0.5)
    player:LoadCharacter()
end)
yPos = yPos + 37

-- 6. Index
createButton("📊 Index", yPos, function()
    print("📊 Player Info:")
    print("Name:", player.Name)
    print("Health:", humanoid.Health)
end)
yPos = yPos + 37

-- 7. TP Walk
local tpWalkActive = false
createButton("⚡ TP Walk: OFF", yPos, function()
    tpWalkActive = not tpWalkActive
    if tpWalkActive then
        buttons[7].Text = "⚡ TP Walk: ON"
        while tpWalkActive do
            local target = mouse.Hit
            hrp.CFrame = CFrame.new(target.Position + Vector3.new(0, 2, 0))
            game:GetService("RunService").RenderStepped:Wait()
        end
    else
        buttons[7].Text = "⚡ TP Walk: OFF"
    end
end)
yPos = yPos + 37

-- 8. TP Speed
createButton("💨 Speed: 300", yPos, function()
    humanoid.WalkSpeed = 300
    buttons[8].Text = "💨 Speed: 300"
end)

-- Stats (smaller)
local stats = Instance.new("TextLabel")
stats.Size = UDim2.new(1, 0, 0, 25)
stats.Position = UDim2.new(0, 0, 1, -50)
stats.Text = "💰 43.2M | $1.9T | ⏱ 1m"
stats.TextColor3 = Color3.fromRGB(255, 0, 0)
stats.TextScaled = true
stats.Font = Enum.Font.GothamBold
stats.BackgroundTransparency = 1
stats.Parent = mainFrame

-- Toggle UI (Hide/Show with sound)
local isOpen = true
toggleBtn.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    mainFrame.Visible = isOpen
    glow.Visible = isOpen
    if isOpen then
        openSound:Play() -- تشغيل الصوت عند الفتح
        toggleBtn.Image = "rbxassetid://6031094667" -- قفل
    else
        toggleBtn.Image = "rbxassetid://6031094554" -- فتح
    end
end)

-- Dragging (smaller)
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

print("🔥 BATO MINI PANEL v4.0 Loaded.")
print("👑 All commands ready for the USER.")
