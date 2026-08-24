-- BATO STEALER V11 - EXACT MATCH + TOGGLE BUTTON
-- All Rights Reserved | BATO

local p=game.Players.LocalPlayer
local c=p.Character or p.CharacterAdded:Wait()
local h=c:WaitForChild("Humanoid")
local r=c:WaitForChild("HumanoidRootPart")

-- ==================== LOADING SCREEN ====================
local loader=Instance.new("ScreenGui")
loader.Name="BATO_LOADER"
loader.Parent=p.PlayerGui

local lf=Instance.new("Frame")
lf.Size=UDim2.new(1,0,1,0)
lf.BackgroundColor3=Color3.fromRGB(0,0,0)
lf.BorderSizePixel=0
lf.Parent=loader

local lt=Instance.new("TextLabel")
lt.Size=UDim2.new(1,0,0,100)
lt.Position=UDim2.new(0,0,0.30,0)
lt.BackgroundTransparency=1
lt.Text="BATO"
lt.TextColor3=Color3.fromRGB(255,215,0)
lt.TextScaled=true
lt.Font=Enum.Font.GothamBold
lt.Parent=lf

local ls=Instance.new("TextLabel")
ls.Size=UDim2.new(1,0,0,60)
ls.Position=UDim2.new(0,0,0.45,0)
ls.BackgroundTransparency=1
ls.Text="STEALER V11"
ls.TextColor3=Color3.fromRGB(255,50,50)
ls.TextScaled=true
ls.Font=Enum.Font.Gotham
ls.Parent=lf

local bb=Instance.new("Frame")
bb.Size=UDim2.new(0,250,0,6)
bb.Position=UDim2.new(0.5,-125,0.60,0)
bb.BackgroundColor3=Color3.fromRGB(40,0,0)
bb.BorderSizePixel=0
bb.Parent=lf

local bc=Instance.new("UICorner")
bc.CornerRadius=UDim.new(0,4)
bc.Parent=bb

local bf=Instance.new("Frame")
bf.Size=UDim2.new(0,0,1,0)
bf.BackgroundColor3=Color3.fromRGB(255,215,0)
bf.BorderSizePixel=0
bf.Parent=bb

local fc=Instance.new("UICorner")
fc.CornerRadius=UDim.new(0,4)
fc.Parent=bf

local lt2=Instance.new("TextLabel")
lt2.Size=UDim2.new(1,0,0,30)
lt2.Position=UDim2.new(0,0,0.68,0)
lt2.BackgroundTransparency=1
lt2.Text="Loading..."
lt2.TextColor3=Color3.fromRGB(200,200,200)
lt2.TextScaled=true
lt2.Font=Enum.Font.Gotham
lt2.Parent=lf

for i=0,1,0.02 do
    wait(0.01)
    bf.Size=UDim2.new(i,0,1,0)
    lt2.Text="Loading... "..math.floor(i*100).."%"
    lt.Size=UDim2.new(i,0,0,100*i)
    lf.BackgroundTransparency=0.2-(i*0.2)
end

wait(0.3)
lf:TweenSize(UDim2.new(0,0,0,0),"Out","Quad",0.3,true)
wait(0.3)
loader:Destroy()

-- ==================== MAIN GUI ====================
local gui=Instance.new("ScreenGui")
gui.Name="BATO_EGG_GUI"
gui.Parent=p.PlayerGui
gui.Enabled=true

-- ==================== ANIMATED BACKGROUND ====================
local bg=Instance.new("Frame")
bg.Size=UDim2.new(1,0,1,0)
bg.BackgroundColor3=Color3.fromRGB(5,0,0)
bg.BorderSizePixel=0
bg.Parent=gui

local grad=Instance.new("UIGradient")
grad.Color=ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(10,0,0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(30,0,0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10,0,0))
})
grad.Parent=bg

for i=1,15 do
    local star=Instance.new("Frame")
    star.Size=UDim2.new(0,math.random(2,4),0,math.random(2,4))
    star.Position=UDim2.new(math.random(),0,math.random(),0)
    star.BackgroundColor3=Color3.fromRGB(255, math.random(150,255), math.random(150,255))
    star.BorderSizePixel=0
    star.BackgroundTransparency=0.8
    star.Parent=bg
    local sc=Instance.new("UICorner")
    sc.CornerRadius=UDim.new(1,0)
    sc.Parent=star
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

-- ==================== MAIN FRAME ====================
local f=Instance.new("Frame")
f.Size=UDim2.new(0,500,0,600)
f.Position=UDim2.new(0.5,-250,0.5,-300)
f.BackgroundColor3=Color3.fromRGB(8,0,0)
f.BorderSizePixel=0
f.BackgroundTransparency=0.1
f.Parent=gui

local c1=Instance.new("UICorner")
c1.CornerRadius=UDim.new(0,15)
c1.Parent=f

local g1=Instance.new("UIStroke")
g1.Color=Color3.fromRGB(255,0,0)
g1.Thickness=2
g1.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
g1.Parent=f

-- Title Bar
local t=Instance.new("Frame")
t.Size=UDim2.new(1,0,0,45)
t.BackgroundColor3=Color3.fromRGB(80,0,0)
t.BackgroundTransparency=0.3
t.BorderSizePixel=0
t.Parent=f

local c2=Instance.new("UICorner")
c2.CornerRadius=UDim.new(0,15)
c2.Parent=t

local l=Instance.new("TextLabel")
l.Size=UDim2.new(1,0,1,0)
l.BackgroundTransparency=1
l.Text="🔥 BATO V11 🔥"
l.TextColor3=Color3.fromRGB(255,215,0)
l.TextScaled=true
l.Font=Enum.Font.GothamBold
l.Parent=t

spawn(function()
    while l.Parent do
        wait(0.5)
        l.TextColor3=Color3.fromRGB(255,215,0)
        wait(0.1)
        l.TextColor3=Color3.fromRGB(255,255,255)
    end
end)

-- ==================== GUI TOGGLE BUTTON (Small) ====================
local toggleGuiBtn=Instance.new("TextButton")
toggleGuiBtn.Size=UDim2.new(0,30,0,30)
toggleGuiBtn.Position=UDim2.new(0.93,0,0.02,0)
toggleGuiBtn.Text="🔴"
toggleGuiBtn.BackgroundColor3=Color3.fromRGB(40,0,0)
toggleGuiBtn.BackgroundTransparency=0.2
toggleGuiBtn.TextColor3=Color3.fromRGB(255,255,255)
toggleGuiBtn.Font=Enum.Font.GothamBold
toggleGuiBtn.TextScaled=true
toggleGuiBtn.Parent=f

local guiVisible=true
toggleGuiBtn.MouseButton1Click:Connect(function()
    guiVisible=not guiVisible
    f.Visible=guiVisible
    if guiVisible then
        toggleGuiBtn.Text="🔴"
        toggleGuiBtn.BackgroundColor3=Color3.fromRGB(40,0,0)
    else
        toggleGuiBtn.Text="🟢"
        toggleGuiBtn.BackgroundColor3=Color3.fromRGB(0,80,0)
    end
end)

-- ==================== BUTTONS (EXACT MATCH) ====================
local function addBtn(text,x,y,w,h,func)
    local btn=Instance.new("TextButton")
    btn.Size=UDim2.new(0,w,0,h)
    btn.Position=UDim2.new(x,0,y,0)
    btn.Text=text
    btn.BackgroundColor3=Color3.fromRGB(40,0,0)
    btn.BackgroundTransparency=0.2
    btn.TextColor3=Color3.fromRGB(255,255,255)
    btn.Font=Enum.Font.GothamBold
    btn.TextScaled=true
    btn.Parent=f
    btn.MouseButton1Click:Connect(func)
    return btn
end

-- Row 1: TOGGLE | Slow Mode | Bypass Anti cheat
local ts=false
local b1=addBtn("TOGGLE",0.03,0.10,130,35,function()
    ts=not ts
    if ts then
        b1.Text="TOGGLE: ON"
        b1.BackgroundColor3=Color3.fromRGB(0,80,0)
        for _,v in pairs(game.Workspace:GetDescendants()) do
            if v:IsA("BasePart") and v.Name=="Egg" then
                v.CanCollide=false
                v.Transparency=0.5
            end
        end
    else
        b1.Text="TOGGLE"
        b1.BackgroundColor3=Color3.fromRGB(40,0,0)
        for _,v in pairs(game.Workspace:GetDescendants()) do
            if v:IsA("BasePart") and v.Name=="Egg" then
                v.CanCollide=true
                v.Transparency=0
            end
        end
    end
end)

addBtn("Slow Mode",0.36,0.10,130,35,function()
    h.WalkSpeed=10
    h.JumpPower=30
end)

addBtn("Bypass Anti cheat",0.69,0.10,130,35,function()
    for _,v in pairs(game:GetDescendants()) do
        if v:IsA("Script") and (v.Name:lower():find("anticheat") or v.Name:lower():find("anti-cheat")) then
            v.Disabled=true
        end
    end
end)

-- Row 2: Shop | Move to Stand | Respawn Character | Index
addBtn("Shop",0.03,0.20,110,35,function()
    local s=p.PlayerGui:FindFirstChild("ShopGUI")
    if s then s.Enabled=not s.Enabled end
end)

addBtn("Move to Stand",0.27,0.20,110,35,function()
    local s=game.Workspace:FindFirstChild("Stand") or game.Workspace:FindFirstChild("SpawnLocation")
    if s and r then r.CFrame=s.CFrame+Vector3.new(0,5,0) end
end)

addBtn("Respawn Character",0.50,0.20,110,35,function()
    if c then c:BreakJoints() end
end)

addBtn("Index",0.73,0.20,110,35,function()
    local i=p.PlayerGui:FindFirstChild("IndexGUI")
    if i then i.Enabled=not i.Enabled end
end)

-- Row 3: TP Walk: OFF | TP Speed: 300 Studs/s
local tws=false
local b2=addBtn("TP Walk: OFF",0.03,0.32,170,35,function()
    tws=not tws
    if tws then
        b2.Text="TP Walk: ON"
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
        b2.Text="TP Walk: OFF"
        b2.BackgroundColor3=Color3.fromRGB(40,0,40)
    end
end)

local sp=300
local b3=addBtn("TP Speed: 300 Studs/s",0.45,0.32,170,35,function()
    sp=sp+100
    if sp>1000 then sp=100 end
    b3.Text="TP Speed: "..sp.." Studs/s"
    h.WalkSpeed=sp
end)

-- ==================== MONEY DISPLAY ====================
local mf=Instance.new("Frame")
mf.Size=UDim2.new(0,250,0,60)
mf.Position=UDim2.new(0.5,-125,0.48,0)
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
ml.Text="43.2M"
ml.TextColor3=Color3.fromRGB(0,255,0)
ml.TextScaled=true
ml.Font=Enum.Font.GothamBold
ml.Parent=mf

local ml2=Instance.new("TextLabel")
ml2.Size=UDim2.new(1,0,0.5,0)
ml2.Position=UDim2.new(0,0,0.5,0)
ml2.BackgroundTransparency=1
ml2.Text="$1.9T  in 1m 14s"
ml2.TextColor3=Color3.fromRGB(255,215,0)
ml2.TextScaled=true
ml2.Font=Enum.Font.Gotham
ml2.Parent=mf

-- ==================== FOOTER ====================
local ft=Instance.new("TextLabel")
ft.Size=UDim2.new(1,0,0,20)
ft.Position=UDim2.new(0,0,0.95,0)
ft.BackgroundTransparency=1
ft.Text="⚡ BATO V11 | All Rights Reserved ⚡"
ft.TextColor3=Color3.fromRGB(150,0,0)
ft.TextScaled=true
ft.Font=Enum.Font.Gotham
ft.Parent=f

-- ==================== OPENING ANIMATION ====================
for i=0,1,0.05 do
    wait(0.01)
    f.BackgroundTransparency=0.1-i*0.05
    f.Position=UDim2.new(0.5,-250,0.5,-300+i*15)
end

print("[BATO] V11 Loaded Successfully!")
