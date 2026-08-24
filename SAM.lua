-- =============================================
-- Script: BATO ULTIMATE UI v10.5
-- Features: Only Return Egg to Hand
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
mainFrame.Size = UDim2.new(0, 300, 0, 200)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 0, 10)
mainFrame.BackgroundTransparency = 0.15
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.fromRGB(200, 0, 200)
mainFrame.Parent = screenGui

-- ============================
-- العنوان
-- ============================
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 35)
title.Position = UDim2.new(0, 0, 0, 5)
title.Text = "🔥 BATO EGG"
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
toggleVisBtn.Position = UDim2.new(1, -35, 0, 5)
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
lockBtn.Size = UDim2.new(0, 60, 0, 22)
lockBtn.Position = UDim2.new(0.5, -30, 0, 5)
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
-- زر واحد فقط: إرجاع البيضة
-- ============================
local eggBtn = Instance.new("TextButton")
eggBtn.Size = UDim2.new(0.8, 0, 0, 40)
eggBtn.Position = UDim2.new(0.1, 0, 0.4, 0)
eggBtn.Text = "🔄 Return Egg to Hand"
eggBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
eggBtn.TextScaled = true
eggBtn.Font = Enum.Font.GothamBold
eggBtn.BackgroundColor3 = Color3.fromRGB(15, 0, 15)
eggBtn.BackgroundTransparency = 0.3
eggBtn.BorderSizePixel = 2
eggBtn.BorderColor3 = Color3.fromRGB(0, 255, 255)
eggBtn.Parent = mainFrame
table.insert(allButtons, eggBtn)

eggBtn.MouseEnter:Connect(function()
    if not isLocked and eggBtn.Active then
        eggBtn.BackgroundTransparency = 0.1
        eggBtn.Size = UDim2.new(0.82, 0, 0, 42)
    end
end)
eggBtn.MouseLeave:Connect(function()
    eggBtn.BackgroundTransparency = 0.3
    eggBtn.Size = UDim2.new(0.8, 0, 0, 40)
end)

eggBtn.MouseButton1Click:Connect(function()
    if isLocked or not eggBtn.Active then return end

    -- ============================
    -- إرجاع البيضة إلى يد اللاعب
    -- ============================
    print("🔄 Returning egg to hand...")

    -- إنشاء بيضة
    local egg = Instance.new("Part")
    egg.Size = Vector3.new(2, 3, 2)
    egg.Shape = Enum.PartType.Ball
    egg.BrickColor = BrickColor.new("Bright yellow")
    egg.Position = hrp.Position + Vector3.new(0, 10, 0)
    egg.Anchored = true
    egg.Parent = game.Workspace

    -- صوت
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://9120393705"
    sound.Volume = 1
    sound.Parent = egg
    sound:Play()

    -- تحريك البيضة إلى يد اللاعب
    for i = 1, 30 do
        local t = i / 30
        local pos = Vector3.new(0, 10, 0) * (1 - t) + Vector3.new(0, 3, 0) * t
        egg.CFrame = CFrame.new(hrp.Position + pos)
        wait(0.03)
    end

    egg:Destroy()
    print("✅ Egg returned to hand!")
end)

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
print("🔥 BATO EGG UI Loaded.")
print("👑 Admin: Mohammad_kurdish73")
print("🔄 Return Egg to Hand ready.")
