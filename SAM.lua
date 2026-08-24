--[[
    Script: BATO_EGG_MASTER_V4
    Owner: BATO (المستخدم)
    Features: Full GUI with Executable Lines for EVERY Button
--]]

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

local gui = Instance.new("ScreenGui")
gui.Name = "BATO_EGG_GUI"
gui.Parent = player.PlayerGui

-- Main Frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 650, 0, 800)
frame.Position = UDim2.new(0.5, -325, 0.5, -400)
frame.BackgroundColor3 = Color3.fromRGB(10, 0, 0)
frame.BorderSizePixel = 0
frame.BackgroundTransparency = 0.1
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 20)
corner.Parent = frame

local glow = Instance.new("UIStroke")
glow.Color = Color3.fromRGB(255, 0, 0)
glow.Thickness = 3
glow.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
glow.Parent = frame

-- Title Bar
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 60)
titleBar.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
titleBar.BorderSizePixel = 0
titleBar.Parent = frame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 20)
titleCorner.Parent = titleBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 1, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "🔥 BATO STEALER V4 🔥"
titleLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
titleLabel.TextScaled = true
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = titleBar

-- ==================== ROW 1: TOGGLE ====================
local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 180, 0, 40)
toggleBtn.Position = UDim2.new(0.05, 0, 0.12, 0)
toggleBtn.Text = "⏹ TOGGLE: OFF"
toggleBtn.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
toggleBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextScaled = true
toggleBtn.Parent = frame

local toggleState = false
toggleBtn.MouseButton1Click:Connect(function()
    toggleState = not toggleState
    if toggleState then
        toggleBtn.Text = "▶ TOGGLE: ON"
        toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 80, 0)
        -- ==== سطر التنفيذ ====
        for _, v in pairs(game.Workspace:GetDescendants()) do
            if v:IsA("BasePart") and v.Name == "Egg" then
                v.CanCollide = false
                v.Transparency = 0.5
            end
        end
        print("[BATO] Toggle ON - All Eggs Semi-Transparent & No Collide")
    else
        toggleBtn.Text = "⏹ TOGGLE: OFF"
        toggleBtn.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
        -- ==== سطر التنفيذ ====
        for _, v in pairs(game.Workspace:GetDescendants()) do
            if v:IsA("BasePart") and v.Name == "Egg" then
                v.CanCollide = true
                v.Transparency = 0
            end
        end
        print("[BATO] Toggle OFF - All Eggs Restored")
    end
end)

-- ==================== ROW 2: Slow Mode ====================
local slowModeBtn = Instance.new("TextButton")
slowModeBtn.Size = UDim2.new(0, 180, 0, 40)
slowModeBtn.Position = UDim2.new(0.38, 0, 0.12, 0)
slowModeBtn.Text = "🐢 Slow Mode"
slowModeBtn.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
slowModeBtn.TextColor3 = Color3.fromRGB(255, 200, 0)
slowModeBtn.Font = Enum.Font.GothamBold
slowModeBtn.TextScaled = true
slowModeBtn.Parent = frame

slowModeBtn.MouseButton1Click:Connect(function()
    -- ==== سطر التنفيذ ====
    humanoid.WalkSpeed = 10
    humanoid.JumpPower = 30
    print("[BATO] Slow Mode Activated - WalkSpeed: 10, JumpPower: 30")
end)

-- ==================== ROW 3: Bypass Anti-Cheat ====================
local bypassBtn = Instance.new("TextButton")
bypassBtn.Size = UDim2.new(0, 180, 0, 40)
bypassBtn.Position = UDim2.new(0.68, 0, 0.12, 0)
bypassBtn.Text = "🛡 Bypass Anti-Cheat"
bypassBtn.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
bypassBtn.TextColor3 = Color3.fromRGB(0, 255, 0)
bypassBtn.Font = Enum.Font.GothamBold
bypassBtn.TextScaled = true
bypassBtn.Parent = frame

bypassBtn.MouseButton1Click:Connect(function()
    -- ==== سطر التنفيذ ====
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("Script") and (v.Name:lower():find("anticheat") or v.Name:lower():find("anti-cheat")) then
            v.Disabled = true
            print("[BATO] Disabled Anti-Cheat Script: " .. v.Name)
        end
    end
    print("[BATO] Anti-Cheat Bypassed Successfully")
end)

-- ==================== ROW 4: Shop ====================
local shopBtn = Instance.new("TextButton")
shopBtn.Size = UDim2.new(0, 140, 0, 40)
shopBtn.Position = UDim2.new(0.05, 0, 0.24, 0)
shopBtn.Text = "🛒 Shop"
shopBtn.BackgroundColor3 = Color3.fromRGB(0, 40, 80)
shopBtn.TextColor3 = Color3.fromRGB(100, 200, 255)
shopBtn.Font = Enum.Font.GothamBold
shopBtn.TextScaled = true
shopBtn.Parent = frame

shopBtn.MouseButton1Click:Connect(function()
    -- ==== سطر التنفيذ ====
    local shopGUI = player.PlayerGui:FindFirstChild("ShopGUI")
    if shopGUI then
        shopGUI.Enabled = not shopGUI.Enabled
        print("[BATO] Shop Toggled")
    else
        print("[BATO] Shop GUI not found")
    end
end)

-- ==================== ROW 5: Move to Stand ====================
local standBtn = Instance.new("TextButton")
standBtn.Size = UDim2.new(0, 140, 0, 40)
standBtn.Position = UDim2.new(0.30, 0, 0.24, 0)
standBtn.Text = "🚶 Move to Stand"
standBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 0)
standBtn.TextColor3 = Color3.fromRGB(255, 255, 100)
standBtn.Font = Enum.Font.GothamBold
standBtn.TextScaled = true
standBtn.Parent = frame

standBtn.MouseButton1Click:Connect(function()
    -- ==== سطر التنفيذ ====
    local stand = game.Workspace:FindFirstChild("Stand") or game.Workspace:FindFirstChild("SpawnLocation")
    if stand and rootPart then
        rootPart.CFrame = stand.CFrame + Vector3.new(0, 5, 0)
        print("[BATO] Moved to Stand")
    else
        print("[BATO] Stand not found")
    end
end)

-- ==================== ROW 6: Respawn Character ====================
local respawnBtn = Instance.new("TextButton")
respawnBtn.Size = UDim2.new(0, 140, 0, 40)
respawnBtn.Position = UDim2.new(0.55, 0, 0.24, 0)
respawnBtn.Text = "💀 Respawn"
respawnBtn.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
respawnBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
respawnBtn.Font = Enum.Font.GothamBold
respawnBtn.TextScaled = true
respawnBtn.Parent = frame

respawnBtn.MouseButton1Click:Connect(function()
    -- ==== سطر التنفيذ ====
    if character then
        character:BreakJoints()
        print("[BATO] Character Respawned")
    end
end)

-- ==================== ROW 7: Index ====================
local indexBtn = Instance.new("TextButton")
indexBtn.Size = UDim2.new(0, 140, 0, 40)
indexBtn.Position = UDim2.new(0.80, 0, 0.24, 0)
indexBtn.Text = "📂 Index"
indexBtn.BackgroundColor3 = Color3.fromRGB(0, 40, 40)
indexBtn.TextColor3 = Color3.fromRGB(0, 255, 200)
indexBtn.Font = Enum.Font.GothamBold
indexBtn.TextScaled = true
indexBtn.Parent = frame

indexBtn.MouseButton1Click:Connect(function()
    -- ==== سطر التنفيذ ====
    local indexGUI = player.PlayerGui:FindFirstChild("IndexGUI")
    if indexGUI then
        indexGUI.Enabled = not indexGUI.Enabled
        print("[BATO] Index Toggled")
    else
        print("[BATO] Index GUI not found")
    end
end)

-- ==================== ROW 8: TP Walk ====================
local tpWalkBtn = Instance.new("TextButton")
tpWalkBtn.Size = UDim2.new(0, 200, 0, 40)
tpWalkBtn.Position = UDim2.new(0.05, 0, 0.36, 0)
tpWalkBtn.Text = "🚀 TP Walk: OFF"
tpWalkBtn.BackgroundColor3 = Color3.fromRGB(40, 0, 40)
tpWalkBtn.TextColor3 = Color3.fromRGB(200, 100, 255)
tpWalkBtn.Font = Enum.Font.GothamBold
tpWalkBtn.TextScaled = true
tpWalkBtn.Parent = frame

local tpWalkState = false
tpWalkBtn.MouseButton1Click:Connect(function()
    tpWalkState = not tpWalkState
    if tpWalkState then
        tpWalkBtn.Text = "🚀 TP Walk: ON"
        tpWalkBtn.BackgroundColor3 = Color3.fromRGB(0, 80, 80)
        -- ==== سطر التنفيذ ====
        game:GetService("RunService").Heartbeat:Connect(function()
            if tpWalkState and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local mouse = player:GetMouse()
                if mouse.Target then
                    local targetPos = mouse.Target.Position
                    rootPart.CFrame = CFrame.new(targetPos.X, targetPos.Y + 5, targetPos.Z)
                end
            end
        end)
        print("[BATO] TP Walk Activated")
    else
        tpWalkBtn.Text = "🚀 TP Walk: OFF"
        tpWalkBtn.BackgroundColor3 = Color3.fromRGB(40, 0, 40)
        print("[BATO] TP Walk Deactivated")
    end
end)

-- ==================== ROW 9: TP Speed ====================
local tpSpeedBtn = Instance.new("TextButton")
tpSpeedBtn.Size = UDim2.new(0, 200, 0, 40)
tpSpeedBtn.Position = UDim2.new(0.38, 0, 0.36, 0)
tpSpeedBtn.Text = "⚡ TP Speed: 300"
tpSpeedBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 0)
tpSpeedBtn.TextColor3 = Color3.fromRGB(255, 200, 50)
tpSpeedBtn.Font = Enum.Font.GothamBold
tpSpeedBtn.TextScaled = true
tpSpeedBtn.Parent = frame

local tpSpeed = 300
tpSpeedBtn.MouseButton1Click:Connect(function()
    tpSpeed = tpSpeed + 100
    if tpSpeed > 1000 then tpSpeed = 100 end
    tpSpeedBtn.Text = "⚡ TP Speed: " .. tpSpeed
    -- ==== سطر التنفيذ ====
    humanoid.WalkSpeed = tpSpeed
    print("[BATO] TP Speed set to: " .. tpSpeed)
end)

-- ==================== ROW 10: Money Display ====================
local moneyFrame = Instance.new("Frame")
moneyFrame.Size = UDim2.new(0, 250, 0, 60)
moneyFrame.Position = UDim2.new(0.55, 0, 0.36, 0)
moneyFrame.BackgroundColor3 = Color3.fromRGB(0, 50, 0)
moneyFrame.BorderSizePixel = 0
moneyFrame.Parent = frame

local moneyCorner = Instance.new("UICorner")
moneyCorner.CornerRadius = UDim.new(0, 10)
moneyCorner.Parent = moneyFrame

local moneyLabel = Instance.new("TextLabel")
moneyLabel.Size = UDim2.new(1, 0, 0.5, 0)
moneyLabel.Position = UDim2.new(0, 0, 0, 0)
moneyLabel.BackgroundTransparency = 1
moneyLabel.Text = "💰 $43.2M"
moneyLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
moneyLabel.TextScaled = true
moneyLabel.Font = Enum.Font.GothamBold
moneyLabel.Parent = moneyFrame

local moneyLabel2 = Instance.new("TextLabel")
moneyLabel2.Size = UDim2.new(1, 0, 0.5, 0)
moneyLabel2.Position = UDim2.new(0, 0, 0.5, 0)
moneyLabel2.BackgroundTransparency = 1
moneyLabel2.Text = "💎 $1.9T | ⏱ 1m 14s"
moneyLabel2.TextColor3 = Color3.fromRGB(255, 215, 0)
moneyLabel2.TextScaled = true
moneyLabel2.Font = Enum.Font.Gotham
moneyLabel2.Parent = moneyFrame

-- ==================== ROW 11: Discord ====================
local discordBtn = Instance.new("TextButton")
discordBtn.Size = UDim2.new(0, 200, 0, 40)
discordBtn.Position = UDim2.new(0.1, 0, 0.50, 0)
discordBtn.Text = "💬 Discord: _.y_.8"
discordBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 200)
discordBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
discordBtn.Font = Enum.Font.GothamBold
discordBtn.TextScaled = true
discordBtn.Parent = frame

discordBtn.MouseButton1Click:Connect(function()
    -- ==== سطر التنفيذ ====
    setclipboard("_.y_.8")
    print("[BATO] Discord username copied: _.y_.8")
end)

-- ==================== ROW 12: TikTok ====================
local tiktokBtn = Instance.new("TextButton")
tiktokBtn.Size = UDim2.new(0, 200, 0, 40)
tiktokBtn.Position = UDim2.new(0.55, 0, 0.50, 0)
tiktokBtn.Text = "🎵 TikTok: c3tk"
tiktokBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
tiktokBtn.TextColor3 = Color3.fromRGB(255, 0, 0)
tiktokBtn.Font = Enum.Font.GothamBold
tiktokBtn.TextScaled = true
tiktokBtn.Parent = frame

tiktokBtn.MouseButton1Click:Connect(function()
    -- ==== سطر التنفيذ ====
    setclipboard("c3tk")
    print("[BATO] TikTok username copied: c3tk")
end)

-- ==================== ROW 13: Screen Share Lock ====================
local screenBtn = Instance.new("TextButton")
screenBtn.Size = UDim2.new(0, 250, 0, 40)
screenBtn.Position = UDim2.new(0.5, -125, 0.62, 0)
screenBtn.Text = "🔒 Lock Screen Share"
screenBtn.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
screenBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
screenBtn.Font = Enum.Font.GothamBold
screenBtn.TextScaled = true
screenBtn.Parent = frame

screenBtn.MouseButton1Click:Connect(function()
    if screenBtn.Text == "🔒 Lock Screen Share" then
        screenBtn.Text = "🔓 Unlock Screen Share"
        -- ==== سطر التنفيذ ====
        for _, v in pairs(game:GetDescendants()) do
            if v:IsA("ScreenGui") then
                v.Enabled = false
            end
        end
        print("[BATO] Screen Share Locked - All GUIs Hidden")
    else
        screenBtn.Text = "🔒 Lock Screen Share"
        -- ==== سطر التنفيذ ====
        for _, v in pairs(game:GetDescendants()) do
            if v:IsA("ScreenGui") and v.Name ~= "BATO_EGG_GUI" then
                v.Enabled = true
            end
        end
        print("[BATO] Screen Share Unlocked - All GUIs Restored")
    end
end)

-- ==================== ROW 14: Quick Actions (Steal, Camouflage, Escape, Fly) ====================
local quickActions = {
    {name = "🥚 Steal", exec = function()
        -- ==== سطر التنفيذ ====
        for _, v in pairs(game.Workspace:GetDescendants()) do
            if v:IsA("BasePart") and v.Name:lower():find("egg") then
                v.Parent = player.Backpack
                print("[BATO] Stole an Egg: " .. v.Name)
                break
            end
        end
    end},
    {name = "👤 Camouflage", exec = function()
        -- ==== سطر التنفيذ ====
        for _, v in pairs(character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Transparency = 0.9
            end
        end
        print("[BATO] Camouflage Activated")
    end},
    {name = "💨 Escape", exec = function()
        -- ==== سطر التنفيذ ====
        local randomPos = Vector3.new(math.random(-500, 500), 50, math.random(-500, 500))
        rootPart.CFrame = CFrame.new(randomPos)
        print("[BATO] Escaped to: " .. tostring(randomPos))
    end},
    {name = "⚡ Fly", exec = function()
        -- ==== سطر التنفيذ ====
        local flySpeed = 50
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
        bodyVelocity.Velocity = Vector3.new(0, flySpeed, 0)
        bodyVelocity.Parent = rootPart
        
        game:GetService("RunService").Heartbeat:Connect(function()
            if bodyVelocity.Parent then
                bodyVelocity.Velocity = Vector3.new(0, flySpeed, 0)
            end
        end)
        print("[BATO] Fly Mode Activated")
    end}
}

for i, action in ipairs(quickActions) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 120, 0, 40)
    btn.Position = UDim2.new(0.06 + (i-1) * 0.24, 0, 0.75, 0)
    btn.Text = action.name
    btn.BackgroundColor3 = Color3.fromRGB(50, 0, 0)
    btn.TextColor3 = Color3.fromRGB(255, 80, 80)
    btn.Font = Enum.Font.GothamBold
    btn.TextScaled = true
    btn.Parent = frame

    btn.MouseButton1Click:Connect(action.exec)
end

-- ==================== Footer ====================
local footer = Instance.new("TextLabel")
footer.Size = UDim2.new(1, 0, 0, 30)
footer.Position = UDim2.new(0, 0, 0.95, 0)
footer.BackgroundTransparency = 1
footer.Text = "⚡ BATO STEALER V4 | All Rights Reserved ⚡"
footer.TextColor3 = Color3.fromRGB(150, 0, 0)
footer.TextScaled = true
footer.Font = Enum.Font.Gotham
footer.Parent = frame

-- ==================== Opening Animation ====================
for i = 0, 1, 0.05 do
    wait(0.01)
    frame.BackgroundTransparency = 0.1 - (i * 0.1)
    frame.Position = UDim2.new(0.5, -325, 0.5, -400 + (i * 15))
end

print("[BATO] V4 Legendary Stealer Script Loaded Successfully!")
