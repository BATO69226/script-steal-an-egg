-- =====================================
-- Script: SAM v4.0 (BAT0 ULTIMATE)
-- Game: Steal an Egg
-- Features: GUI, Anti-Ban, All Options
-- =====================================

local player = game:GetService("Players").LocalPlayer
local gui = Instance.new("ScreenGui")
local mainFrame = Instance.new("Frame")
local title = Instance.new("TextLabel")
local closeBtn = Instance.new("TextButton")
local tab1 = Instance.new("TextButton")
local tab2 = Instance.new("TextButton")
local tab3 = Instance.new("TextButton")
local content = Instance.new("Frame")

-- ===== أنيميشن الافتتاح =====
local function openAnimation()
    mainFrame.Size = UDim2.new(0, 0, 0, 0)
    mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    for i = 1, 30 do
        mainFrame.Size = UDim2.new(0, i*12, 0, i*10)
        mainFrame.Position = UDim2.new(0.5, -i*6, 0.5, -i*5)
        wait(0.02)
    end
end

-- ===== الواجهة الرئيسية =====
gui.Name = "SAM_GUI"
gui.Parent = player:WaitForChild("PlayerGui")

mainFrame.Size = UDim2.new(0, 360, 0, 420)
mainFrame.Position = UDim2.new(0.5, -180, 0.5, -210)
mainFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 20)
mainFrame.BackgroundTransparency = 0.05
mainFrame.BorderSizePixel = 3
mainFrame.BorderColor3 = Color3.fromRGB(255, 215, 0)
mainFrame.ClipsDescendants = true
mainFrame.Parent = gui

-- خلفية متدرجة
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 25, 50)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(5, 5, 20))
})
gradient.Parent = mainFrame

-- شعار مع أنيميشن
local logo = Instance.new("TextLabel")
logo.Size = UDim2.new(1, 0, 0, 50)
logo.Position = UDim2.new(0, 0, 0, 5)
logo.BackgroundTransparency = 1
logo.Text = "⚡ BAT0 ⚡"
logo.TextColor3 = Color3.fromRGB(255, 215, 0)
logo.TextScaled = true
logo.Font = Enum.Font.Bold
logo.Parent = mainFrame

-- زر الإغلاق
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.Bold
closeBtn.Parent = mainFrame

-- ===== علامات التبويب =====
local tabs = {"🔥 الرئيسية", "⚙️ الإعدادات", "🛡️ الحماية"}
local tabButtons = {}

for i, name in ipairs(tabs) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 110, 0, 35)
    btn.Position = UDim2.new(0.03 + (i-1) * 0.33, 0, 0, 55)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(200, 200, 255)
    btn.TextScaled = true
    btn.Font = Enum.Font.Bold
    btn.Parent = mainFrame
    tabButtons[i] = btn
end

-- ===== محتوى التبويب =====
content.Size = UDim2.new(0.94, 0, 0, 290)
content.Position = UDim2.new(0.03, 0, 0, 95)
content.BackgroundColor3 = Color3.fromRGB(15, 15, 30)
content.BackgroundTransparency = 0.3
content.BorderSizePixel = 1
content.BorderColor3 = Color3.fromRGB(255, 215, 0)
content.Parent = mainFrame

-- ===== التبويب 1: الرئيسية =====
local mainContent = Instance.new("Frame")
mainContent.Size = UDim2.new(1, 0, 1, 0)
mainContent.BackgroundTransparency = 1
mainContent.Parent = content

-- قائمة الخيارات
local options = {
    {"🚀 سرعة خارقة", "Speed"},
    {"✈️ طيران", "Fly"},
    {"🥚 سرقة تلقائية", "AutoSteal"},
    {"🛡️ وضع AFK", "AntiAFK"},
    {"💰 بيع تلقائي", "AutoSell"},
    {"👁️ رؤية البيض", "ESP"}
}

local toggles = {}
for i, opt in ipairs(options) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 150, 0, 30)
    btn.Position = UDim2.new(0.05 + (i-1)%2 * 0.5, 0, 0.05 + math.floor((i-1)/2) * 0.15, 0)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
    btn.Text = opt[1] .. " [OFF]"
    btn.TextColor3 = Color3.fromRGB(200, 200, 255)
    btn.TextScaled = true
    btn.Font = Enum.Font.Bold
    btn.Parent = mainContent
    toggles[opt[2]] = {btn = btn, state = false}
    
    btn.MouseButton1Click:Connect(function()
        toggles[opt[2]].state = not toggles[opt[2]].state
        local stateText = toggles[opt[2]].state and "ON" or "OFF"
        btn.Text = opt[1] .. " [" .. stateText .. "]"
        btn.BackgroundColor3 = toggles[opt[2]].state and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(40, 40, 80)
        -- تنفيذ الخيار
        if opt[2] == "Speed" then
            player.Character.Humanoid.WalkSpeed = toggles[opt[2]].state and 50 or 16
        elseif opt[2] == "Fly" then
            local bv = player.Character.HumanoidRootPart:FindFirstChild("BodyVelocity")
            if toggles[opt[2]].state then
                if not bv then
                    bv = Instance.new("BodyVelocity")
                    bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
                    bv.Parent = player.Character.HumanoidRootPart
                end
                game:GetService("RunService").Heartbeat:Connect(function()
                    if toggles["Fly"].state then
                        bv.Velocity = Vector3.new(0, 25, 0)
                    end
                end)
            else
                if bv then bv:Destroy() end
            end
        elseif opt[2] == "AutoSteal" then
            spawn(function()
                while toggles["AutoSteal"].state do
                    for _, o in pairs(workspace:GetDescendants()) do
                        if o:IsA("Part") and o.Name:lower():find("egg") then
                            player.Character.HumanoidRootPart.CFrame = CFrame.new(o.Position)
                            wait(0.2)
                            local cd = o:FindFirstChild("ClickDetector")
                            if cd then fireclickdetector(cd) end
                            wait(0.3)
                        end
                    end
                    wait(0.5)
                end
            end)
        elseif opt[2] == "AntiAFK" then
            spawn(function()
                while toggles["AntiAFK"].state do
                    player.Character.Humanoid:MoveTo(player.Character.HumanoidRootPart.Position + Vector3.new(0,0,1))
                    wait(30)
                    player.Character.Humanoid:MoveTo(player.Character.HumanoidRootPart.Position + Vector3.new(0,0,-1))
                    wait(30)
                end
            end)
        elseif opt[2] == "AutoSell" then
            spawn(function()
                while toggles["AutoSell"].state do
                    -- محاكاة البيع (حسب نظام اللعبة)
                    print("🔄 بيع البيض...")
                    wait(5)
                end
            end)
        elseif opt[2] == "ESP" then
            spawn(function()
                while toggles["ESP"].state do
                    for _, o in pairs(workspace:GetDescendants()) do
                        if o:IsA("Part") and o.Name:lower():find("egg") then
                            local highlight = o:FindFirstChild("Highlight")
                            if not highlight then
                                highlight = Instance.new("Highlight")
                                highlight.FillColor = Color3.fromRGB(255, 0, 0)
                                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                                highlight.Parent = o
                            end
                        end
                    end
                    wait(1)
                end
            end)
        end
    end)
end

-- ===== التبويب 2: الإعدادات =====
local settingsContent = Instance.new("Frame")
settingsContent.Size = UDim2.new(1, 0, 1, 0)
settingsContent.BackgroundTransparency = 1
settingsContent.Visible = false
settingsContent.Parent = content

local speedSlider = Instance.new("TextLabel")
speedSlider.Size = UDim2.new(0.8, 0, 0, 30)
speedSlider.Position = UDim2.new(0.1, 0, 0.1, 0)
speedSlider.BackgroundTransparency = 1
speedSlider.Text = "⚡ السرعة: 50"
speedSlider.TextColor3 = Color3.fromRGB(200, 200, 255)
speedSlider.TextScaled = true
speedSlider.Font = Enum.Font.Bold
speedSlider.Parent = settingsContent

-- زر إعادة تعيين
local resetBtn = Instance.new("TextButton")
resetBtn.Size = UDim2.new(0.6, 0, 0, 40)
resetBtn.Position = UDim2.new(0.2, 0, 0.3, 0)
resetBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
resetBtn.Text = "🔄 إعادة تعيين الكل"
resetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
resetBtn.TextScaled = true
resetBtn.Font = Enum.Font.Bold
resetBtn.Parent = settingsContent

resetBtn.MouseButton1Click:Connect(function()
    for _, toggle in pairs(toggles) do
        toggle.state = false
        toggle.btn.Text = toggle.btn.Text:gsub("%[.-%]", "[OFF]")
        toggle.btn.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
    end
    player.Character.Humanoid.WalkSpeed = 16
    local bv = player.Character.HumanoidRootPart:FindFirstChild("BodyVelocity")
    if bv then bv:Destroy() end
end)

-- ===== التبويب 3: الحماية =====
local protectionContent = Instance.new("Frame")
protectionContent.Size = UDim2.new(1, 0, 1, 0)
protectionContent.BackgroundTransparency = 1
protectionContent.Visible = false
protectionContent.Parent = content

local antiBanLabel = Instance.new("TextLabel")
antiBanLabel.Size = UDim2.new(0.8, 0, 0, 40)
antiBanLabel.Position = UDim2.new(0.1, 0, 0.1, 0)
antiBanLabel.BackgroundTransparency = 1
antiBanLabel.Text = "🛡️ حماية متقدمة من الكشف\n(محاكاة حركة بشرية)"
antiBanLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
antiBanLabel.TextScaled = true
antiBanLabel.Font = Enum.Font.Bold
antiBanLabel.Parent = protectionContent

local antiBanBtn = Instance.new("TextButton")
antiBanBtn.Size = UDim2.new(0.6, 0, 0, 40)
antiBanBtn.Position = UDim2.new(0.2, 0, 0.5, 0)
antiBanBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
antiBanBtn.Text = "🛡️ تفعيل الحماية"
antiBanBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
antiBanBtn.TextScaled = true
antiBanBtn.Font = Enum.Font.Bold
antiBanBtn.Parent = protectionContent

local antiBanActive = false
antiBanBtn.MouseButton1Click:Connect(function()
    antiBanActive = not antiBanActive
    antiBanBtn.Text = antiBanActive and "✅ الحماية مفعلة" or "🛡️ تفعيل الحماية"
    antiBanBtn.BackgroundColor3 = antiBanActive and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(0, 150, 0)
    if antiBanActive then
        spawn(function()
            while antiBanActive do
                -- محاكاة حركة بشرية عشوائية
                local randomWait = math.random(10, 30)
                local direction = math.random(1, 4)
                local move = Vector3.new(
                    direction == 1 and 1 or direction == 2 and -1 or 0,
                    0,
                    direction == 3 and 1 or direction == 4 and -1 or 0
                )
                player.Character.Humanoid:MoveTo(player.Character.HumanoidRootPart.Position + move)
                wait(randomWait)
            end
        end)
    end
end)

-- ===== التبديل بين التبويبات =====
for i, btn in ipairs(tabButtons) do
    btn.MouseButton1Click:Connect(function()
        mainContent.Visible = (i == 1)
        settingsContent.Visible = (i == 2)
        protectionContent.Visible = (i == 3)
        for _, b in ipairs(tabButtons) do
            b.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
        end
        btn.BackgroundColor3 = Color3.fromRGB(60, 60, 120)
    end)
end

-- ===== زر الإغلاق =====
closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- ===== تشغيل الأنيميشن =====
openAnimation()

-- ===== إرسال تأكيد التشغيل =====
print("✅ SAM v4.0 - BAT0 ULTIMATE يعمل الآن!")
