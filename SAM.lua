-- =====================================
-- SAM v7.0 - BAT0 (واجهة تعمل بإجبار)
-- Game: Steal an Egg
-- =====================================

local p = game:GetService("Players").LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "SAM_GUI"
gui.ResetOnSpawn = false
gui.Parent = p:WaitForChild("PlayerGui")

-- ===== الواجهة الرئيسية =====
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 280, 0, 340)
frame.Position = UDim2.new(0.5, -140, 0.5, -170)
frame.BackgroundColor3 = Color3.fromRGB(10, 10, 25)
frame.BackgroundTransparency = 0.05
frame.BorderSizePixel = 3
frame.BorderColor3 = Color3.fromRGB(255, 215, 0)
frame.ClipsDescendants = true
frame.Active = true
frame.Draggable = true
frame.Parent = gui

-- خلفية متدرجة
local grad = Instance.new("UIGradient")
grad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 60)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(5, 5, 20))
})
grad.Parent = frame

-- ===== زر إظهار/إخفاء الواجهة (في أعلى الشاشة) =====
local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 120, 0, 30)
toggleBtn.Position = UDim2.new(0.5, -60, 0, 5)
toggleBtn.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
toggleBtn.Text = "⚡ BAT0 ⚡"
toggleBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
toggleBtn.TextScaled = true
toggleBtn.Font = Enum.Font.Bold
toggleBtn.BorderSizePixel = 2
toggleBtn.BorderColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.Parent = gui

-- ===== محتوى الواجهة =====
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 35)
title.Position = UDim2.new(0, 0, 0, 5)
title.BackgroundTransparency = 1
title.Text = "⚡ BAT0 ⚡"
title.TextColor3 = Color3.fromRGB(255, 215, 0)
title.TextScaled = true
title.Font = Enum.Font.Bold
title.Parent = frame

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 25, 0, 25)
closeBtn.Position = UDim2.new(1, -30, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.Bold
closeBtn.Parent = frame
closeBtn.MouseButton1Click:Connect(function()
    frame.Visible = false
    toggleBtn.Visible = true
end)

-- ===== خيارات البوت =====
local options = {
    {"🚀 Speed", "Speed"},
    {"✈️ Fly", "Fly"},
    {"🥚 AutoSteal", "AutoSteal"},
    {"🛡️ AFK", "AntiAFK"},
    {"👁️ ESP", "ESP"}
}

local buttons = {}
local toggles = {}

for i, opt in ipairs(options) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 120, 0, 30)
    btn.Position = UDim2.new(0.05 + (i-1)%2 * 0.5, 0, 0.15 + math.floor((i-1)/2) * 0.17, 0)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
    btn.Text = opt[1] .. " [OFF]"
    btn.TextColor3 = Color3.fromRGB(220, 220, 255)
    btn.TextScaled = true
    btn.Font = Enum.Font.Bold
    btn.BorderSizePixel = 1
    btn.BorderColor3 = Color3.fromRGB(100, 100, 150)
    btn.Parent = frame
    buttons[opt[2]] = btn
    toggles[opt[2]] = false
end

-- زر إعادة التعيين
local resetBtn = Instance.new("TextButton")
resetBtn.Size = UDim2.new(0.8, 0, 0, 30)
resetBtn.Position = UDim2.new(0.1, 0, 0.85, 0)
resetBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
resetBtn.Text = "🔄 Reset All"
resetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
resetBtn.TextScaled = true
resetBtn.Font = Enum.Font.Bold
resetBtn.Parent = frame

-- ===== دوال الميزات =====
local char = p.Character or p.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local root = char:WaitForChild("HumanoidRootPart")

local function setSpeed(state)
    hum.WalkSpeed = state and 50 or 16
end

local function setFly(state)
    local bv = root:FindFirstChild("BodyVelocity")
    if state then
        if not bv then
            bv = Instance.new("BodyVelocity")
            bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
            bv.Parent = root
        end
        game:GetService("RunService").Heartbeat:Connect(function()
            if toggles["Fly"] then bv.Velocity = Vector3.new(0, 20, 0) end
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
                        root.CFrame = CFrame.new(o.Position)
                        wait(0.2)
                        local cd = o:FindFirstChild("ClickDetector")
                        if cd then fireclickdetector(cd) end
                        wait(0.3)
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
                hum:MoveTo(root.Position + Vector3.new(0,0,1))
                wait(30)
                hum:MoveTo(root.Position + Vector3.new(0,0,-1))
                wait(30)
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

-- ===== ربط الأزرار =====
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

-- ===== زر إعادة التعيين =====
resetBtn.MouseButton1Click:Connect(function()
    for opt, btn in pairs(buttons) do
        toggles[opt] = false
        btn.Text = opt .. " [OFF]"
        btn.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
    end
    setSpeed(false)
    setFly(false)
    setESP(false)
    hum.WalkSpeed = 16
end)

-- ===== زر إظهار/إخفاء الواجهة =====
local guiVisible = true
toggleBtn.MouseButton1Click:Connect(function()
    guiVisible = not guiVisible
    frame.Visible = guiVisible
    toggleBtn.Visible = true
    toggleBtn.Text = guiVisible and "⚡ BAT0 ⚡" or "🔽 Show"
end)

-- ===== تأكيد التشغيل =====
print("✅ SAM v7.0 - BAT0 يعمل! اضغط على 'BAT0' في أعلى الشاشة لإظهار/إخفاء الواجهة.")
