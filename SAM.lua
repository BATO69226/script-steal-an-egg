-- BATO STEALER V7 - WITH ANIMATED BACKGROUND
local p=game.Players.LocalPlayer
local c=p.Character or p.CharacterAdded:Wait()
local h=c:WaitForChild("Humanoid")
local r=c:WaitForChild("HumanoidRootPart")
local g=Instance.new("ScreenGui")
g.Name="BATO_EGG_GUI"
g.Parent=p.PlayerGui

-- ==================== ANIMATED BACKGROUND ====================
local bg=Instance.new("Frame")
bg.Size=UDim2.new(1,0,1,0)
bg.BackgroundColor3=Color3.fromRGB(5,0,0)
bg.BorderSizePixel=0
bg.Parent=g

-- Gradient Effect
local grad=Instance.new("UIGradient")
grad.Color=ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(10,0,0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(30,0,0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10,0,0))
})
grad.Parent=bg

-- Floating Particles (Stars/Glow)
for i=1,20 do
    local star=Instance.new("Frame")
    star.Size=UDim2.new(0,math.random(2,5),0,math.random(2,5))
    star.Position=UDim2.new(math.random(),0,math.random(),0)
    star.BackgroundColor3=Color3.fromRGB(255, math.random(150,255), math.random(150,255))
    star.BorderSizePixel=0
    star.BackgroundTransparency=0.8
    star.Parent=bg
    
    local sc=Instance.new("UICorner")
    sc.CornerRadius=UDim.new(1,0)
    sc.Parent=star
    
    -- Animation for each star
    spawn(function()
        local speed=math.random(5,15)
        local dir=math.random(0,360)
        while star.Parent do
            wait(0.1)
            local pos=star.Position
            star.Position=UDim2.new(
                pos.X.Scale+math.sin(dir)*0.001,
                0,
                pos.Y.Scale+math.cos(dir)*0.001,
                0
            )
            star.BackgroundTransparency=0.5+math.sin(tick()*speed)*0.3
        end
    end)
end

-- ==================== MAIN FRAME (Transparent) ====================
local f=Instance.new("Frame")
f.Size=UDim2.new(0,650,0,800)
f.Position=UDim2.new(0.5,-325,0.5,-400)
f.BackgroundColor3=Color3.fromRGB(10,0,0)
f.BorderSizePixel=0
f.BackgroundTransparency=0.15
f.Parent=g

local c1=Instance.new("UICorner")
c1.CornerRadius=UDim.new(0,20)
c1.Parent=f

local g1=Instance.new("UIStroke")
g1.Color=Color3.fromRGB(255,0,0)
g1.Thickness=3
g1.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
g1.Parent=f

-- Title Bar
local t=Instance.new("Frame")
t.Size=UDim2.new(1,0,0,60)
t.BackgroundColor3=Color3.fromRGB(80,0,0)
t.BackgroundTransparency=0.3
t.BorderSizePixel=0
t.Parent=f

local c2=Instance.new("UICorner")
c2.CornerRadius=UDim.new(0,20)
c2.Parent=t

local l=Instance.new("TextLabel")
l.Size=UDim2.new(1,0,1,0)
l.BackgroundTransparency=1
l.Text="🔥 BATO STEALER V7 🔥"
l.TextColor3=Color3.fromRGB(255,215,0)
l.TextScaled=true
l.Font=Enum.Font.GothamBold
l.Parent=t

-- Pulse animation on title
spawn(function()
    while l.Parent do
        wait(0.5)
        l.TextColor3=Color3.fromRGB(255,215,0)
        wait(0.1)
        l.TextColor3=Color3.fromRGB(255,255,255)
    end
end)

-- ==================== TAB BUTTONS ====================
local tabs={"📋 Main","⚙️ The Script","🛠️ Extras","👤 Social"}
local tabBtns={}
local currentTab="Main"

for i,name in ipairs(tabs) do
    local btn=Instance.new("TextButton")
    btn.Size=UDim2.new(0,150,0,35)
    btn.Position=UDim2.new(0.02+(i-1)*0.25,0,0.10,0)
    btn.Text=name
    btn.BackgroundColor3=Color3.fromRGB(30,0,0)
    btn.BackgroundTransparency=0.5
    btn.TextColor3=Color3.fromRGB(255,200,200)
    btn.Font=Enum.Font.GothamBold
    btn.TextScaled=true
    btn.Parent=f
    tabBtns[name]=btn
    btn.MouseButton1Click:Connect(function()
        currentTab=name
        for _,v in pairs(f:GetChildren()) do
            if v.Name=="TabContent" then v.Visible=false end
        end
        local tabContent=f:FindFirstChild("TabContent_"..name)
        if tabContent then tabContent.Visible=true end
        for _,b in pairs(tabBtns) do
            b.BackgroundColor3=Color3.fromRGB(30,0,0)
            b.BackgroundTransparency=0.5
            b.TextColor3=Color3.fromRGB(255,200,200)
        end
        btn.BackgroundColor3=Color3.fromRGB(80,0,0)
        btn.BackgroundTransparency=0
        btn.TextColor3=Color3.fromRGB(255,255,0)
    end)
end

-- ==================== FUNCTION TO CREATE TAB CONTENT ====================
local function createTab(name)
    local tab=Instance.new("Frame")
    tab.Name="TabContent_"..name
    tab.Size=UDim2.new(1,-10,1,-100)
    tab.Position=UDim2.new(0,5,0.18,0)
    tab.BackgroundTransparency=1
    tab.Visible=(name=="Main")
    tab.Parent=f
    return tab
end

local function addButton(tab,text,x,y,w,h,col,tcol,func)
    local btn=Instance.new("TextButton")
    btn.Size=UDim2.new(0,w or 180,0,h or 40)
    btn.Position=UDim2.new(x,0,y,0)
    btn.Text=text
    btn.BackgroundColor3=col or Color3.fromRGB(40,0,0)
    btn.BackgroundTransparency=0.3
    btn.TextColor3=tcol or Color3.fromRGB(255,255,255)
    btn.Font=Enum.Font.GothamBold
    btn.TextScaled=true
    btn.Parent=tab
    btn.MouseButton1Click:Connect(func)
    return btn
end

-- ==================== TAB 1: MAIN ====================
local mainTab=createTab("Main")
local ts=false
local b1=addButton(mainTab,"⏹ TOGGLE: OFF",0.05,0.05,180,40,Color3.fromRGB(40,0,0),Color3.fromRGB(255,100,100),function()
    ts=not ts
    if ts then
        b1.Text="▶ TOGGLE: ON"
        b1.BackgroundColor3=Color3.fromRGB(0,80,0)
        for _,v in pairs(game.Workspace:GetDescendants()) do
            if v:IsA("BasePart") and v.Name=="Egg" then
                v.CanCollide=false
                v.Transparency=0.5
            end
        end
    else
        b1.Text="⏹ TOGGLE: OFF"
        b1.BackgroundColor3=Color3.fromRGB(40,0,0)
        for _,v in pairs(game.Workspace:GetDescendants()) do
            if v:IsA("BasePart") and v.Name=="Egg" then
                v.CanCollide=true
                v.Transparency=0
            end
        end
    end
end)
addButton(mainTab,"🐢 Slow Mode",0.38,0.05,180,40,Color3.fromRGB(40,0,0),Color3.fromRGB(255,200,0),function()
    h.WalkSpeed=10
    h.JumpPower=30
end)
addButton(mainTab,"🛡 Bypass AC",0.68,0.05,180,40,Color3.fromRGB(80,0,0),Color3.fromRGB(0,255,0),function()
    for _,v in pairs(game:GetDescendants()) do
        if v:IsA("Script") and (v.Name:lower():find("anticheat") or v.Name:lower():find("anti-cheat")) then
            v.Disabled=true
        end
    end
end)
addButton(mainTab,"🛒 Shop",0.05,0.20,140,40,Color3.fromRGB(0,40,80),Color3.fromRGB(100,200,255),function()
    local s=p.PlayerGui:FindFirstChild("ShopGUI")
    if s then s.Enabled=not s.Enabled end
end)
addButton(mainTab,"🚶 Stand",0.30,0.20,140,40,Color3.fromRGB(40,40,0),Color3.fromRGB(255,255,100),function()
    local s=game.Workspace:FindFirstChild("Stand") or game.Workspace:FindFirstChild("SpawnLocation")
    if s and r then r.CFrame=s.CFrame+Vector3.new(0,5,0) end
end)
addButton(mainTab,"💀 Respawn",0.55,0.20,140,40,Color3.fromRGB(80,0,0),Color3.fromRGB(255,50,50),function()
    if c then c:BreakJoints() end
end)
addButton(mainTab,"📂 Index",0.80,0.20,140,40,Color3.fromRGB(0,40,40),Color3.fromRGB(0,255,200),function()
    local i=p.PlayerGui:FindFirstChild("IndexGUI")
    if i then i.Enabled=not i.Enabled end
end)

-- ==================== TAB 2: THE SCRIPT ====================
local scriptTab=createTab("The Script")
local tws=false
local b2=addButton(scriptTab,"🚀 TP Walk: OFF",0.05,0.05,200,40,Color3.fromRGB(40,0,40),Color3.fromRGB(200,100,255),function()
    tws=not tws
    if tws then
        b2.Text="🚀 TP Walk: ON"
        b2.BackgroundColor3=Color3.fromRGB(0,80,80)
        game:GetService("RunService").Heartbeat:Connect(function()
            if tws and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local m=p:GetMouse()
                if m.Target then
                    local tp=m.Target.Position
                    r.CFrame=CFrame.new(tp.X,tp.Y+5,tp.Z)
                end
            end
        end)
    else
        b2.Text="🚀 TP Walk: OFF"
        b2.BackgroundColor3=Color3.fromRGB(40,0,40)
    end
end)
local sp=300
local b3=addButton(scriptTab,"⚡ TP Speed: 300",0.38,0.05,200,40,Color3.fromRGB(40,40,0),Color3.fromRGB(255,200,50),function()
    sp=sp+100
    if sp>1000 then sp=100 end
    b3.Text="⚡ TP Speed: "..sp
    h.WalkSpeed=sp
end)

-- ==================== TAB 3: EXTRAS ====================
local extraTab=createTab("Extras")
local sc=false
local b4=addButton(extraTab,"🔒 Lock Screen",0.25,0.05,250,40,Color3.fromRGB(40,0,0),Color3.fromRGB(255,255,255),function()
    sc=not sc
    if sc then
        b4.Text="🔓 Unlock Screen"
        for _,v in pairs(game:GetDescendants()) do
            if v:IsA("ScreenGui") then v.Enabled=false end
        end
    else
        b4.Text="🔒 Lock Screen"
        for _,v in pairs(game:GetDescendants()) do
            if v:IsA("ScreenGui") and v.Name~="BATO_EGG_GUI" then
                v.Enabled=true
            end
        end
    end
end)

local quickActions={
    {name="🥚 Steal", exec=function()
        for _,v in pairs(game.Workspace:GetDescendants()) do
            if v:IsA("BasePart") and v.Name:lower():find("egg") then
                v.Parent=p.Backpack
                break
            end
        end
    end},
    {name="👤 Camouflage", exec=function()
        for _,v in pairs(c:GetDescendants()) do
            if v:IsA("BasePart") then v.Transparency=0.9 end
        end
    end},
    {name="💨 Escape", exec=function()
        local rp=Vector3.new(math.random(-500,500),50,math.random(-500,500))
        r.CFrame=CFrame.new(rp)
    end},
    {name="⚡ Fly", exec=function()
        local bv=Instance.new("BodyVelocity")
        bv.MaxForce=Vector3.new(4000,4000,4000)
        bv.Velocity=Vector3.new(0,50,0)
        bv.Parent=r
        game:GetService("RunService").Heartbeat:Connect(function()
            if bv.Parent then bv.Velocity=Vector3.new(0,50,0) end
        end)
    end}
}
for i,act in ipairs(quickActions) do
    addButton(extraTab,act.name,0.06+(i-1)*0.24,0.20,120,40,Color3.fromRGB(50,0,0),Color3.fromRGB(255,80,80),act.exec)
end

-- ==================== TAB 4: SOCIAL ====================
local socialTab=createTab("Social")
addButton(socialTab,"💬 Discord: _.y_.8",0.15,0.05,200,40,Color3.fromRGB(30,30,200),Color3.fromRGB(255,255,255),function()
    setclipboard("_.y_.8")
end)
addButton(socialTab,"🎵 TikTok: c3tk",0.55,0.05,200,40,Color3.fromRGB(0,0,0),Color3.fromRGB(255,0,0),function()
    setclipboard("c3tk")
end)

-- ==================== MONEY DISPLAY ====================
local mf=Instance.new("Frame")
mf.Size=UDim2.new(0,250,0,60)
mf.Position=UDim2.new(0.5,-125,0.88,0)
mf.BackgroundColor3=Color3.fromRGB(0,50,0)
mf.BackgroundTransparency=0.3
mf.BorderSizePixel=0
mf.Parent=f
local mc=Instance.new("UICorner")
mc.CornerRadius=UDim.new(0,10)
mc.Parent=mf
local ml=Instance.new("TextLabel")
ml.Size=UDim2.new(1,0,0.5,0)
ml.Position=UDim2.new(0,0,0,0)
ml.BackgroundTransparency=1
ml.Text="💰 $43.2M"
ml.TextColor3=Color3.fromRGB(0,255,0)
ml.TextScaled=true
ml.Font=Enum.Font.GothamBold
ml.Parent=mf
local ml2=Instance.new("TextLabel")
ml2.Size=UDim2.new(1,0,0.5,0)
ml2.Position=UDim2.new(0,0,0.5,0)
ml2.BackgroundTransparency=1
ml2.Text="💎 $1.9T | ⏱ 1m 14s"
ml2.TextColor3=Color3.fromRGB(255,215,0)
ml2.TextScaled=true
ml2.Font=Enum.Font.Gotham
ml2.Parent=mf

-- ==================== FOOTER ====================
local ft=Instance.new("TextLabel")
ft.Size=UDim2.new(1,0,0,25)
ft.Position=UDim2.new(0,0,0.965,0)
ft.BackgroundTransparency=1
ft.Text="⚡ BATO V7 | All Rights Reserved ⚡"
ft.TextColor3=Color3.fromRGB(150,0,0)
ft.TextScaled=true
ft.Font=Enum.Font.Gotham
ft.Parent=f

-- ==================== OPENING ANIMATION ====================
for i=0,1,0.05 do
    wait(0.01)
    f.BackgroundTransparency=0.15-i*0.05
    f.Position=UDim2.new(0.5,-325,0.5,-400+i*15)
end
print("[BATO] V7 Loaded Successfully!")
