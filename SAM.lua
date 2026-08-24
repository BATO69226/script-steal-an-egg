--[=[
    Script: BATO Hub V2.0 - Crimson Edition
    حقوق النشر محفوظة لـ BATO
    تم التطوير بأمر من المستخدم
]=]

local BATO = {
    Name = "BATO Hub",
    Version = "2.0",
    Creator = "BATO"
}

-- إنشاء الواجهة الرئيسية
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BATO_GUI"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- الإطار الرئيسي (خلفية حمراء داكنة مع توهج)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 380, 0, 500)
MainFrame.Position = UDim2.new(0.5, -190, 0.5, -250)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 0, 0) -- خلفية حمراء داكنة
MainFrame.BackgroundTransparency = 0.05
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

-- زوايا دائرية مع إضاءة حمراء
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 16)
UICorner.Parent = MainFrame

-- تأثير توهج أحمر (خلفية متوهجة)
local GlowEffect = Instance.new("Frame")
GlowEffect.Size = UDim2.new(1.1, 0, 1.1, 0)
GlowEffect.Position = UDim2.new(-0.05, 0, -0.05, 0)
GlowEffect.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
GlowEffect.BackgroundTransparency = 0.8
GlowEffect.BorderSizePixel = 0
GlowEffect.Parent = MainFrame

local GlowCorner = Instance.new("UICorner")
GlowCorner.CornerRadius = UDim.new(0, 20)
GlowCorner.Parent = GlowEffect

-- إطار داخلي شفاف للتباين
local InnerFrame = Instance.new("Frame")
InnerFrame.Size = UDim2.new(0.96, 0, 0.96, 0)
InnerFrame.Position = UDim2.new(0.02, 0, 0.02, 0)
InnerFrame.BackgroundColor3 = Color3.fromRGB(10, 0, 0)
InnerFrame.BackgroundTransparency = 0.3
InnerFrame.BorderSizePixel = 0
InnerFrame.Parent = MainFrame

local InnerCorner = Instance.new("UICorner")
InnerCorner.CornerRadius = UDim.new(0, 12)
InnerCorner.Parent = InnerFrame

-- عنوان BATO (بأسلوب أحمر ناري)
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 0, 50)
TitleLabel.Position = UDim2.new(0, 0, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "BATO Hub v2.0"
TitleLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
TitleLabel.TextScaled = true
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Center
TitleLabel.Parent = InnerFrame

-- تأثير ظل للنص
local TitleShadow = Instance.new("TextLabel")
TitleShadow.Size = UDim2.new(1, 0, 0, 50)
TitleShadow.Position = UDim2.new(0.002, 0, 0.002, 0)
TitleShadow.BackgroundTransparency = 1
TitleShadow.Text = "BATO Hub v2.0"
TitleShadow.TextColor3 = Color3.fromRGB(100, 0, 0)
TitleShadow.TextScaled = true
TitleShadow.Font = Enum.Font.GothamBold
TitleShadow.TextXAlignment = Enum.TextXAlignment.Center
TitleShadow.Parent = InnerFrame

-- خط فاصل متوهج
local Divider = Instance.new("Frame")
Divider.Size = UDim2.new(0.9, 0, 0, 3)
Divider.Position = UDim2.new(0.05, 0, 0, 50)
Divider.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
Divider.BackgroundTransparency = 0.2
Divider.Parent = InnerFrame

-- توهج للخط الفاصل
local DividerGlow = Instance.new("Frame")
DividerGlow.Size = UDim2.new(0.9, 0, 0, 6)
DividerGlow.Position = UDim2.new(0.05, 0, 0, 48)
DividerGlow.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
DividerGlow.BackgroundTransparency = 0.8
DividerGlow.Parent = InnerFrame

-- دالة لإنشاء زر (بخلفية حمراء داكنة)
local function createButton(parent, text, position, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.8, 0, 0, 38)
    button.Position = position
    button.BackgroundColor3 = Color3.fromRGB(60, 0, 0)
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 200, 200)
    button.TextScaled = true
    button.Font = Enum.Font.Gotham
    button.BorderSizePixel = 0
    button.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = button
    
    -- تأثير hover
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
    end)
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(60, 0, 0)
    end)
    
    button.MouseButton1Click:Connect(callback)
    return button
end

-- دالة لإنشاء Toggle (بأسلوب أحمر)
local function createToggle(parent, text, position, defaultState)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.8, 0, 0, 32)
    frame.Position = position
    frame.BackgroundTransparency = 1
    frame.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.Position = UDim2.new(0, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 200, 200)
    label.TextScaled = true
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0.25, 0, 1, 0)
    toggleBtn.Position = UDim2.new(0.75, 0, 0, 0)
    toggleBtn.BackgroundColor3 = defaultState and Color3.fromRGB(200, 0, 0) or Color3.fromRGB(40, 0, 0)
    toggleBtn.Text = defaultState and "ON" or "OFF"
    toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleBtn.TextScaled = true
    toggleBtn.Font = Enum.Font.GothamBold
    toggleBtn.BorderSizePixel = 0
    toggleBtn.Parent = frame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 4)
    corner.Parent = toggleBtn
    
    local state = defaultState
    toggleBtn.MouseButton1Click:Connect(function()
        state = not state
        toggleBtn.BackgroundColor3 = state and Color3.fromRGB(200, 0, 0) or Color3.fromRGB(40, 0, 0)
        toggleBtn.Text = state and "ON" or "OFF"
        print(text .. " changed to: " .. tostring(state))
    end)
    
    return toggleBtn, state
end

-- إنشاء الأزرار حسب الصورة
local yOffset = 60
local spacing = 48

-- TOGGLE
createToggle(InnerFrame, "TOGGLE", UDim2.new(0.1, 0, 0, yOffset), false)

-- Bypass Anti-cheat
createToggle(InnerFrame, "Bypass Anti cheat", UDim2.new(0.1, 0, 0, yOffset + spacing), true)

-- Move to Stand
createButton(InnerFrame, "Move to Stand", UDim2.new(0.1, 0, 0, yOffset + spacing * 2), function()
    print("الانتقال إلى المنصة - BATO")
end)

-- Respawn Character
createButton(InnerFrame, "Respawn Character", UDim2.new(0.1, 0, 0, yOffset + spacing * 3), function()
    print("إعادة ظهور الشخصية - BATO")
end)

-- ex
createButton(InnerFrame, "ex", UDim2.new(0.1, 0, 0, yOffset + spacing * 4), function()
    print("تشغيل ex - BATO")
end)

-- TP Walk: OFF
createToggle(InnerFrame, "TP Walk: OFF", UDim2.new(0.1, 0, 0, yOffset + spacing * 5), false)

-- TP Speed: 300 Studs/s
local speedFrame = Instance.new("Frame")
speedFrame.Size = UDim2.new(0.8, 0, 0, 32)
speedFrame.Position = UDim2.new(0.1, 0, 0, yOffset + spacing * 6)
speedFrame.BackgroundTransparency = 1
speedFrame.Parent = InnerFrame

local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(1, 0, 1, 0)
speedLabel.Position = UDim2.new(0, 0, 0, 0)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "TP Speed: 300 Studs/s"
speedLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
speedLabel.TextScaled = true
speedLabel.Font = Enum.Font.GothamBold
speedLabel.TextXAlignment = Enum.TextXAlignment.Center
speedLabel.Parent = speedFrame

-- تأثير نبض خفيف للخلفية
game:GetService("RunService").RenderStepped:Connect(function()
    local pulse = (math.sin(tick() * 2) + 1) / 2
    MainFrame.BackgroundColor3 = Color3.fromRGB(30 + pulse * 10, 0, 0)
end)

-- جعل الواجهة قابلة للسحب
local dragging = false
local dragStart
local startPos

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

MainFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
