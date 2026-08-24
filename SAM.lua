-- SAM Lite - بدون واجهة (يعمل في الخلفية)
local p=game:GetService("Players").LocalPlayer
local char=p.Character or p.CharacterAdded:Wait()
local hum=char:WaitForChild("Humanoid")
local root=char:WaitForChild("HumanoidRootPart")

-- سرعة وطيران
hum.WalkSpeed=50
local bv=Instance.new("BodyVelocity")
bv.MaxForce=Vector3.new(1e9,1e9,1e9)
bv.Parent=root

-- Anti-AFK
spawn(function()
    while wait(30) do
        hum:MoveTo(root.Position+Vector3.new(0,0,1))
        wait(1)
        hum:MoveTo(root.Position+Vector3.new(0,0,-1))
    end
end)

-- سرقة تلقائية
spawn(function()
    while wait(0.5) do
        for _,o in pairs(workspace:GetDescendants()) do
            if o:IsA("Part") and o.Name:lower():find("egg") then
                root.CFrame=CFrame.new(o.Position)
                wait(0.2)
                local cd=o:FindFirstChild("ClickDetector")
                if cd then fireclickdetector(cd) end
                wait(0.3)
            end
        end
    end
end)
