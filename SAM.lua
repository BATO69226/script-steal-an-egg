-- SAM v3.1 - BAT0 EDITION (مع عداد الثواني)
local p=game:GetService("Players").LocalPlayer
local g=Instance.new("ScreenGui")
local f=Instance.new("Frame")
local t=Instance.new("TextLabel")
local s=Instance.new("TextLabel")
local st=Instance.new("TextLabel")
local timerLabel=Instance.new("TextLabel")
local bS=Instance.new("TextButton")
local bP=Instance.new("TextButton")
local aL=Instance.new("TextLabel")

-- ===== الواجهة =====
g.Name="SAM"
g.Parent=p:WaitForChild("PlayerGui")

f.Size=UDim2.new(0,340,0,310)
f.Position=UDim2.new(0.5,-170,0.5,-155)
f.BackgroundColor3=Color3.fromRGB(10,10,20)
f.BackgroundTransparency=0.05
f.BorderSizePixel=2
f.BorderColor3=Color3.fromRGB(255,215,0)
f.Parent=g

-- تدرج لوني
local gr=Instance.new("UIGradient")
gr.Color=ColorSequence.new({
    ColorSequenceKeypoint.new(0,Color3.fromRGB(30,30,60)),
    ColorSequenceKeypoint.new(1,Color3.fromRGB(5,5,20))
})
gr.Parent=f

-- شعار BAT0
local l=Instance.new("TextLabel")
l.Size=UDim2.new(1,0,0,40)
l.Position=UDim2.new(0,0,0,5)
l.BackgroundTransparency=1
l.Text="⚡BAT0⚡"
l.TextColor3=Color3.fromRGB(255,215,0)
l.TextScaled=true
l.Font=Enum.Font.Bold
l.Parent=f

-- العنوان
t.Size=UDim2.new(1,0,0,30)
t.Position=UDim2.new(0,0,0,45)
t.BackgroundTransparency=1
t.Text="STEAL MASTER"
t.TextColor3=Color3.fromRGB(200,200,255)
t.TextScaled=true
t.Font=Enum.Font.Bold
t.Parent=f

-- حقوق الملكية
s.Size=UDim2.new(1,0,0,25)
s.Position=UDim2.new(0,0,0,75)
s.BackgroundTransparency=1
s.Text="🔥BAT0🔥"
s.TextColor3=Color3.fromRGB(255,100,100)
s.TextScaled=true
s.Font=Enum.Font.Bold
s.Parent=f

-- الحالة
st.Size=UDim2.new(1,0,0,25)
st.Position=UDim2.new(0,0,0,105)
st.BackgroundTransparency=1
st.Text="✅ Ready"
st.TextColor3=Color3.fromRGB(0,255,100)
st.TextScaled=true
st.Font=Enum.Font.Bold
st.Parent=f

-- عداد الثواني ⏱️
timerLabel.Size=UDim2.new(1,0,0,30)
timerLabel.Position=UDim2.new(0,0,0,130)
timerLabel.BackgroundTransparency=1
timerLabel.Text="⏱️ 00:00:00"
timerLabel.TextColor3=Color3.fromRGB(100,200,255)
timerLabel.TextScaled=true
timerLabel.Font=Enum.Font.Bold
timerLabel.Parent=f

-- زر التشغيل
bS.Size=UDim2.new(0,130,0,40)
bS.Position=UDim2.new(0.08,0,0,170)
bS.BackgroundColor3=Color3.fromRGB(0,180,0)
bS.TextColor3=Color3.fromRGB(255,255,255)
bS.Text="▶ Start"
bS.TextScaled=true
bS.Font=Enum.Font.Bold
bS.Parent=f

-- زر الإيقاف
bP.Size=UDim2.new(0,130,0,40)
bP.Position=UDim2.new(0.55,0,0,170)
bP.BackgroundColor3=Color3.fromRGB(180,0,0)
bP.TextColor3=Color3.fromRGB(255,255,255)
bP.Text="⏹ Stop"
bP.TextScaled=true
bP.Font=Enum.Font.Bold
bP.Parent=f

-- إشارة AFK
aL.Size=UDim2.new(1,0,0,25)
aL.Position=UDim2.new(0,0,0,225)
aL.BackgroundTransparency=1
aL.Text="🛡️ AFK Active"
aL.TextColor3=Color3.fromRGB(100,200,255)
aL.TextScaled=true
aL.Font=Enum.Font.Regular
aL.Parent=f

-- ===== ميزات البوت =====
local running=false
local seconds=0
local char=p.Character or p.CharacterAdded:Wait()
local hum=char:WaitForChild("Humanoid")
local root=char:WaitForChild("HumanoidRootPart")

-- تحديث العداد
local function updateTimer()
    while running do
        wait(1)
        seconds=seconds+1
        local h=math.floor(seconds/3600)
        local m=math.floor((seconds%3600)/60)
        local s=seconds%60
        timerLabel.Text=string.format("⏱️ %02d:%02d:%02d",h,m,s)
    end
end

-- Anti-AFK
local function antiAFK()
    while running do
        hum:MoveTo(root.Position+Vector3.new(0,0,1))
        wait(30)
        hum:MoveTo(root.Position+Vector3.new(0,0,-1))
        wait(30)
    end
end

-- سرعة وطيران
local function setSpeed(spd) hum.WalkSpeed=spd end
local function fly(state)
    local bv=root:FindFirstChild("BodyVelocity")
    if state then
        if not bv then
            bv=Instance.new("BodyVelocity")
            bv.MaxForce=Vector3.new(1e9,1e9,1e9)
            bv.Parent=root
        end
        game:GetService("RunService").Heartbeat:Connect(function()
            if running then bv.Velocity=Vector3.new(0,25,0) end
        end)
    else
        if bv then bv:Destroy() end
    end
end

-- سرقة تلقائية
local function autoSteal()
    while running do
        for _,o in pairs(workspace:GetDescendants()) do
            if o:IsA("Part") and o.Name:lower():find("egg") then
                root.CFrame=CFrame.new(o.Position)
                wait(0.2)
                local cd=o:FindFirstChild("ClickDetector")
                if cd then fireclickdetector(cd) end
                wait(0.3)
            end
        end
        wait(0.5)
    end
end

-- ===== أزرار التحكم =====
bS.MouseButton1Click:Connect(function()
    running=true
    seconds=0
    st.Text="⚡ Running"
    st.TextColor3=Color3.fromRGB(255,200,0)
    setSpeed(50)
    fly(true)
    spawn(autoSteal)
    spawn(antiAFK)
    spawn(updateTimer)
end)

bP.MouseButton1Click:Connect(function()
    running=false
    st.Text="⏹ Stopped"
    st.TextColor3=Color3.fromRGB(255,100,100)
    setSpeed(16)
    fly(false)
end)
