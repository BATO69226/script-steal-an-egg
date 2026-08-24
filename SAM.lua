-- =====================================
-- SAM v9.1 - BATO RED EDITION
-- جميع الحقوق محفوظة لـ BATO
-- =====================================

local p = game:GetService("Players").LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "BATO_GUI"
gui.ResetOnSpawn = false
gui.Parent = p:WaitForChild("PlayerGui")

-- ===== الواجهة الرئيسية (باللون الأحمر) =====
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 380, 0, 480)
frame.Position = UDim2.new(0.5, -190, 0.5, -240)
frame.BackgroundColor3 = Color3.fromRGB(20, 0, 0) -- أحمر داكن
frame.BackgroundTransparency = 0.05
frame.BorderSizePixel = 3
frame.BorderColor3 = Color3.fromRGB(255, 0, 0) -- أحمر فاتح
frame.ClipsDescendants = true
frame.Active = true
frame.Draggable = true
frame.Parent = gui

-- ===== خلفية متدرجة (أحمر + أسود) =====
local grad = Instance.new("UIGradient")
grad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 0, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 0, 0))
})
grad.Parent = frame

-- ===== خلفية شعار BATO (مكرر كنقش) =====
local bgImage = Instance.new("ImageLabel")
bgImage.Size = UDim2.new(1, 0, 1, 0)
bgImage.BackgroundTransparency = 1
bgImage.Image = "rbxassetid://123456789" -- ضع رابط صورة شعار BATO هنا
bgImage.ImageColor3 = Color3.fromRGB(255, 0, 0) -- أحمر
bgImage.ImageTransparency = 0.85 -- شفاف جداً
bgImage.Parent = frame

-- ===== العنوان =====
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 50)
title.Position = UDim2.new(0, 0, 0, 5)
title.BackgroundTransparency = 1
title.Text = "⚡ BATO ULTIMATE ⚡"
title.TextColor3 = Color3.fromRGB(255, 50, 50) -- أحمر فاتح
title.TextScaled = true
title.Font = Enum.Font.Bold
title.Parent = frame

-- ===== زر الإغلاق =====
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.Bold
closeBtn.Parent = frame
closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- ===== الأزرار الرئيسية =====
local buttons = {
    {"🛡️ Bypass", "Bypass"},
    {"🚀 TP Walk", "TPWalk"},
    {"🏃 TP Speed", "TPSpeed"},
    {"📍 Move to Stand", "MoveStand"},
    {"🔄 Respawn", "Respawn"},
    {"💰 Auto Farm", "AutoFarm"},
    {"🥚 Auto Steal", "AutoSteal"},
    {"👁️ ESP", "ESP"}
}

local toggles = {}
local btnRefs = {}

for i, b in ipairs(buttons) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 150, 0, 30)
    btn.Position = UDim2.new(0.05 + (i-1)%2 * 0.5, 0, 0.13 + math.floor((i-1)/2) * 0.12, 0)
    btn.BackgroundColor3 = Color3.fromRGB(80, 0, 0) -- أحمر داكن
    btn.Text = b[1] .. " [OFF]"
    btn.TextColor3 = Color3.fromRGB(255, 150, 150) -- أحمر فاتح
    btn.TextScaled = true
    btn.Font = Enum.Font.Bold
    btn.BorderSizePixel = 1
    btn.BorderColor3 = Color3.fromRGB(255, 0, 0)
    btn.Parent = frame
    btnRefs[b[2]] = btn
    toggles[b[2]] = false
end

-- ===== زر إعادة التعيين =====
local resetBtn = Instance.new("TextButton")
resetBtn.Size = UDim2.new(0.8, 0, 0, 35)
resetBtn.Position = UDim2.new(0.1, 0, 0.88, 0)
resetBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
resetBtn.Text = "🔄 إيقاف الكل (BATO)"
resetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
resetBtn.TextScaled = true
resetBtn.Font = Enum.Font.Bold
resetBtn.Parent = frame

-- ===== حقوق الملكية =====
local rights = Instance.new("TextLabel")
rights.Size = UDim2.new(1, 0, 0, 20)
rights.Position = UDim2.new(0, 0, 0, 0.95)
rights.BackgroundTransparency = 1
rights.Text = "🔥 جميع الحقوق محفوظة لـ BATO 🔥"
rights.TextColor3 = Color3.fromRGB(255, 50, 50)
rights.TextScaled = true
rights.Font = Enum.Font.Bold
rights.Parent = frame

-- ===== دوال الميزات =====
local char = p.Character or p.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local root = char:WaitForChild("HumanoidRootPart")

local function toggleFeature(feature)
    toggles[feature] = not toggles[feature]
    local state = toggles[feature]
    local btn = btnRefs[feature]
    if btn then
        btn.Text = btn.Text:gsub("%[.-%]", state and "[ON]" or "[OFF]")
        btn.BackgroundColor3 = state and Color3.fromRGB(200, 0, 0) or Color3.fromRGB(80, 0, 0) -- أحمر فاتح/داكن
    end
    
    -- تنفيذ الميزات
    if feature == "Bypass" then
        p:Chat("🛡️ Bypass: " .. (state and "ON" or "OFF"))
    elseif feature == "TPWalk" then
        hum.WalkSpeed = state and 100 or 16
        p:Chat("🚀 TP Walk: " .. (state and "ON (100)" or "OFF"))
    elseif feature == "TPSpeed" then
        if state then
            hum.WalkSpeed = hum.WalkSpeed * 2
        else
            hum.WalkSpeed = 16
        end
        p:Chat("🏃 TP Speed: " .. (state and "ON" or "OFF"))
    elseif feature == "MoveStand" then
        if state then
            local standPos = Vector3.new(0, 10, 0)
            root.CFrame = CFrame.new(standPos)
            p:Chat("📍 تم الانتقال إلى Stand")
            toggles["MoveStand"] = false
            btn.Text = "📍 Move to Stand [OFF]"
            btn.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
        end
    elseif feature == "Respawn" then
        if state then
            p.Character = nil
            p:LoadCharacter()
            p:Chat("🔄 تم إعادة البعث")
            toggles["Respawn"] = false
            btn.Text = "🔄 Respawn [OFF]"
            btn.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
        end
    elseif feature == "AutoFarm" then
        if state then
            spawn(function()
                while toggles["AutoFarm"] do
                    for _, o in pairs(workspace:GetDescendants()) do
                        if o:IsA("Part") and (o.Name:lower():find("egg") or o.Name:lower():find("coin")) then
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
        p:Chat("💰 Auto Farm: " .. (state and "ON" or "OFF"))
    elseif feature == "AutoSteal" then
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
        p:Chat("🥚 Auto Steal: " .. (state and "ON" or "OFF"))
    elseif feature == "ESP" then
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
        p:Chat("👁️ ESP: " .. (state and "ON" or "OFF"))
    end
end

-- ===== ربط الأزرار =====
for feature, btn in pairs(btnRefs) do
    btn.MouseButton1Click:Connect(function()
        toggleFeature(feature)
    end)
end

-- ===== زر إعادة التعيين =====
resetBtn.MouseButton1Click:Connect(function()
    for feature, btn in pairs(btnRefs) do
        toggles[feature] = false
        btn.Text = btn.Text:gsub("%[.-%]", "[OFF]")
        btn.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
    end
    hum.WalkSpeed = 16
    for _, o in pairs(workspace:GetDescendants()) do
        if o:IsA("Part") and o.Name:lower():find("egg") then
            local hl = o:FindFirstChild("Highlight")
            if hl then hl:Destroy() end
        end
    end
    p:Chat("🔄 تم إيقاف جميع الميزات بواسطة BATO")
end)

-- ===== زر إظهار/إخفاء الواجهة (علوي) =====
local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 100, 0, 30)
toggleBtn.Position = UDim2.new(0.5, -50, 0, 5)
toggleBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
toggleBtn.Text = "⚡ BATO ⚡"
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.TextScaled = true
toggleBtn.Font = Enum.Font.Bold
toggleBtn.BorderSizePixel = 2
toggleBtn.BorderColor3 = Color3.fromRGB(255, 0, 0)
toggleBtn.Parent = gui

local guiVisible = true
toggleBtn.MouseButton1Click:Connect(function()
    guiVisible = not guiVisible
    frame.Visible = guiVisible
    toggleBtn.Text = guiVisible and "⚡ BATO ⚡" or "🔽 Show"
end)

-- ===== تأكيد التشغيل =====
p:Chat("✅ BATO RED EDITION يعمل الآن!")
print("✅ BATO RED EDITION جاهز!")
