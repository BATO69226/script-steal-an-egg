-- SAM v4.1 - BAT0 EDITION (واجهة يدوية)
local p = game:GetService("Players").LocalPlayer
local gui = Instance.new("ScreenGui")
local frame = Instance.new("Frame")
local title = Instance.new("TextLabel")
local close = Instance.new("TextButton")

local buttons = {}
local toggles = {}

-- ===== أنيميشن الافتتاح =====
local function openAnimation()
    frame.Size = UDim2.new(0, 0, 0, 0)
    frame.Position = UDim2.new(0.5, 0, 0.5, 0)
    for i = 1, 30 do
        frame.Size = UDim2.new(0, i*12, 0, i*8)
        frame.Position = UDim2.new(0.5, -i*6, 0.5, -i*4)
        wait(0.02)
    end
end

-- ===== الواجهة الرئيسية =====
gui.Name = "SAM_GUI"
gui.Parent = p:WaitForChild("PlayerGui")

frame.Size = UDim2.new(0, 280, 0, 320)
frame.Position = UDim2.new(0.5, -140, 0.5, -160)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 30)
frame.BackgroundTransparency = 0.1
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(255, 215, 0)
frame.ClipsDescendants = true
frame.Parent = gui

-- خلفية متدرجة
local grad = Instance.new("UIGradient")
grad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 60)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 20))
})
grad.Parent = frame

-- العنوان
title.Size = UDim2.new(1, 0, 0, 35)
title.Position = UDim2.new(0, 0, 0, 5)
title.BackgroundTransparency = 1
title.Text = "⚡ BAT0 ⚡"
title.TextColor3 = Color3.fromRGB(255, 215, 0)
title.TextScaled = true
title.Font = Enum.Font.Bold
title.Parent = frame

-- زر الإغلاق
close.Size = UDim2.new(0, 25, 0, 25)
close.Position = UDim2.new(1, -30, 0, 5)
close.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
close.Text = "✕"
close.TextColor3 = Color3.fromRGB(255, 255, 255)
close.TextScaled = true
close.Font = Enum.Font.Bold
close.Parent = frame
close.MouseButton1Click:Connect(function() gui:Destroy() end)

-- ===== الأزرار والخيارات =====
local options = {
    {"🚀 سرعة", "Speed"},
    {"✈️ طيران", "Fly"},
    {"🥚 سرقة", "AutoSteal"},
    {"🛡️ AFK", "AntiAFK"},
    {"👁️ ESP", "ESP"}
}

-- حلقة لإنشاء الأزرار
for i, opt in ipairs(options) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 120, 0, 30)
    btn.Position = UDim2.new(0.05 + (i-1)%2 * 0.5, 0, 0.15 + math.floor((i-1)/2) * 0.15, 0)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
    btn.Text = opt[1] .. " [OFF]"
    btn.TextColor3 = Color3.fromRGB(220, 220, 255)
    btn.TextScaled = true
    btn.Font = Enum.Font.Bold
    btn.Parent = frame
    buttons[opt[2]] = btn
    toggles[opt[2]] = false
end

-- زر إعادة تعيين
local reset = Instance.new("TextButton")
reset.Size = UDim2.new(0.8, 0, 0, 30)
reset.Position = UDim2.new(0.1, 0, 0.8, 0)
reset.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
reset.Text = "🔄 إيقاف الكل"
reset.TextColor3 = Color3.fromRGB(255, 255, 255)
reset.TextScaled = true
reset.Font = Enum.Font.Bold
reset.Parent = frame

-- ===== دوال التشغيل =====
local function setSpeed(state)
    local char = p.Character or p.CharacterAdded:Wait()
    local hum = char:WaitForChild("Humanoid")
    hum.WalkSpeed = state and 50 or 16
end

local function setFly(state)
    local char = p.Character or p.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")
    local bv = root:FindFirstChild("BodyVelocity")
    if state then
        if not bv then
            bv = Instance.new("BodyVelocity")
            bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
            bv.Parent = root
        end
        game:GetService("RunService").Heartbeat:Connect(function()
            if toggles["Fly"] then
                bv.Velocity = Vector3.new(0, 20, 0)
            end
        end)
    else
        if bv then bv:Destroy() end
    end
end

local function setAutoSteal(state)
    if state then
        spawn(function()
            while toggles["AutoSteal"] do
                for _, o in pairs(workspace:GetDescendants()) do
                    if o:IsA("Part") and o.Name:lower():find("egg") then
                        local char = p.Character
                        if char then
                            char.HumanoidRootPart.CFrame = CFrame.new(o.Position)
                            wait(0.2)
                            local cd = o:FindFirstChild("ClickDetector")
                            if cd then fireclickdetector(cd) end
                            wait(0.3)
                        end
                    end
                end
                wait(0.5)
            end
        end)
    end
end

local function setAntiAFK(state)
    if state then
        spawn(function()
            while toggles["AntiAFK"] do
                local char = p.Character
                if char then
                    char.Humanoid:MoveTo(char.HumanoidRootPart.Position + Vector3.new(0,0,1))
                    wait(30)
                    char.Humanoid:MoveTo(char.HumanoidRootPart.Position + Vector3.new(0,0,-1))
                    wait(30)
                end
            end
        end)
    end
end

local function setESP(state)
    if state then
        spawn(function()
            while toggles["ESP"] do
                for _, o in pairs(workspace:GetDescendants()) do
                    if o:IsA("Part") and o.Name:lower():find("egg") then
                        local hl = o:FindFirstChild("Highlight")
                        if not hl then
                            hl = Instance.new("Highlight")
                            hl.FillColor = Color3.fromRGB(255, 0, 0)
                            hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                            hl.Parent = o
                        end
                    end
                end
                wait(1)
            end
        end)
    else
        for _, o in pairs(workspace:GetDescendants()) do
            if o:IsA("Part") and o.Name:lower():find("egg") then
                local hl = o:FindFirstChild("Highlight")
                if hl then hl:Destroy() end
            end
        end
    end
end

-- ===== ربط الأزرار بالوظائف =====
for opt, btn in pairs(buttons) do
    btn.MouseButton1Click:Connect(function()
        toggles[opt] = not toggles[opt]
        local state = toggles[opt]
        btn.Text = opt .. " [" .. (state and "ON" or "OFF") .. "]"
        btn.BackgroundColor3 = state and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(40, 40, 80)

        if opt == "Speed" then setSpeed(state)
        elseif opt == "Fly" then setFly(state)
        elseif opt == "AutoSteal" then setAutoSteal(state)
        elseif opt == "AntiAFK" then setAntiAFK(state)
        elseif opt == "ESP" then setESP(state)
        end
    end)
end

-- زر إعادة التعيين
reset.MouseButton1Click:Connect(function()
    for opt, btn in pairs(buttons) do
        toggles[opt] = false
        btn.Text = opt .. " [OFF]"
        btn.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
    end
    setSpeed(false)
    setFly(false)
    setESP(false)
    local char = p.Character
    if char then
        char.Humanoid.WalkSpeed = 16
    end
end)

-- ===== تشغيل الأنيميشن =====
openAnimation()
print("✅ SAM v4.1 - BAT0 جاهز! فعّل الخيارات يدوياً.")
