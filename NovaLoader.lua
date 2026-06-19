local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

pcall(function()
    CoreGui:FindFirstChild("NovaLoader"):Destroy()
end)

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "NovaLoader"
gui.Parent = CoreGui
gui.ResetOnSpawn = false

-- MAIN
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 360, 0, 220)
main.Position = UDim2.new(0.5, -180, 0.5, -110)
main.BackgroundColor3 = Color3.fromRGB(10,10,20)
main.Parent = gui
Instance.new("UICorner", main).CornerRadius = UDim.new(0,12)

local stroke = Instance.new("UIStroke", main)
stroke.Color = Color3.fromRGB(0,170,255)
stroke.Thickness = 2

-- TOP BAR
local top = Instance.new("Frame")
top.Size = UDim2.new(1,0,0,30)
top.BackgroundColor3 = Color3.fromRGB(15,15,30)
top.Parent = main
Instance.new("UICorner", top).CornerRadius = UDim.new(0,12)

-- TITLE
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,1,0)
title.BackgroundTransparency = 1
title.Text = "Nova Loader Hub"
title.TextColor3 = Color3.fromRGB(0,200,255)
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.Parent = top

-- ❌ EXIT BUTTON
local exit = Instance.new("TextButton")
exit.Size = UDim2.new(0,30,0,25)
exit.Position = UDim2.new(1,-35,0,2)
exit.Text = "X"
exit.TextColor3 = Color3.fromRGB(255,80,80)
exit.BackgroundColor3 = Color3.fromRGB(30,30,40)
exit.Parent = top
Instance.new("UICorner", exit).CornerRadius = UDim.new(0,6)

exit.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- 🧠 SCRIPT HUB LIST
local scripts = {
    {"Infinite Yield", "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"},
    {"Dex Explorer", "https://raw.githubusercontent.com/peyton2465/Dex/master/out.lua"}
}

local y = 40

for _,v in pairs(scripts) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0,320,0,35)
    btn.Position = UDim2.new(0,20,0,y)
    btn.Text = "▶ "..v[1]
    btn.BackgroundColor3 = Color3.fromRGB(20,20,35)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Parent = main
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)

    btn.MouseButton1Click:Connect(function()
        pcall(function()
            loadstring(game:HttpGet(v[2]))()
        end)
    end)

    y = y + 45
end

-- 🗑 CLEAR / RESET BUTTON
local clear = Instance.new("TextButton")
clear.Size = UDim2.new(0,120,0,30)
clear.Position = UDim2.new(0,20,1,-40)
clear.Text = "Clear UI"
clear.BackgroundColor3 = Color3.fromRGB(40,20,20)
clear.TextColor3 = Color3.fromRGB(255,120,120)
clear.Parent = main
Instance.new("UICorner", clear).CornerRadius = UDim.new(0,6)

clear.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- 📱 DRAG (PC + MOBILE)
local dragging, dragStart, startPos

top.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = main.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
    or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function()
    dragging = false
end)
-- TITLE BAR (Drag Handle)
local topbar = Instance.new("Frame")
topbar.Size = UDim2.new(1, 0, 0, 30)
topbar.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
topbar.BorderSizePixel = 0
topbar.Parent = main

Instance.new("UICorner", topbar).CornerRadius = UDim.new(0, 14)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 1, 0)
title.BackgroundTransparency = 1
title.Text = "Nova Loader"
title.TextColor3 = Color3.fromRGB(0, 200, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.Parent = topbar

-- 🖱️ DRAG SYSTEM (PC + MOBILE)
local dragging = false
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    main.Position = UDim2.new(
        startPos.X.Scale,
        startPos.X.Offset + delta.X,
        startPos.Y.Scale,
        startPos.Y.Offset + delta.Y
    )
end

topbar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = main.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

topbar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement
    or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        update(input)
    end
end)

-- BUTTON SAMPLE
local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0, 220, 0, 40)
btn.Position = UDim2.new(0.5, -110, 0.5, -20)
btn.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
btn.Text = "Execute"
btn.TextColor3 = Color3.fromRGB(255,255,255)
btn.Font = Enum.Font.Gotham
btn.TextSize = 14
btn.Parent = main

Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)

local btnStroke = Instance.new("UIStroke", btn)
btnStroke.Color = Color3.fromRGB(0, 170, 255)

-- hover effect (PC)
btn.MouseEnter:Connect(function()
    TweenService:Create(btn, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(30,30,50)
    }):Play()
end)

btn.MouseLeave:Connect(function()
    TweenService:Create(btn, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(20,20,35)
    }):Play()
end)

-- click effect
btn.MouseButton1Down:Connect(function()
    TweenService:Create(btn, TweenInfo.new(0.1), {
        Size = UDim2.new(0, 210, 0, 38)
    }):Play()
end)

btn.MouseButton1Up:Connect(function()
    TweenService:Create(btn, TweenInfo.new(0.1), {
        Size = UDim2.new(0, 220, 0, 40)
    }):Play()
end)top.Parent = main

Instance.new("UICorner", top).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,-80,1,0)
title.Position = UDim2.new(0,10,0,0)
title.BackgroundTransparency = 1
title.Text = "⚡ Nova Loader V2"
title.TextColor3 = Color3.fromRGB(0,200,255)
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = top

-- Close
local close = Instance.new("TextButton")
close.Size = UDim2.new(0,25,0,25)
close.Position = UDim2.new(1,-30,0,3)
close.Text = "X"
close.BackgroundColor3 = Color3.fromRGB(255,50,80)
close.TextColor3 = Color3.new(1,1,1)
close.Parent = top

-- Box
local box = Instance.new("TextBox")
box.Size = UDim2.new(1,-20,0,100)
box.Position = UDim2.new(0,10,0,40)
box.BackgroundColor3 = Color3.fromRGB(15,15,25)
box.TextColor3 = Color3.fromRGB(0,255,200)
box.PlaceholderText = "Paste Script..."
box.ClearTextOnFocus = false
box.MultiLine = true
box.Font = Enum.Font.Code
box.TextSize = 14
box.Parent = main

Instance.new("UICorner", box).CornerRadius = UDim.new(0,8)

-- Execute
local exec = Instance.new("TextButton")
exec.Size = UDim2.new(0.48,-5,0,35)
exec.Position = UDim2.new(0,10,1,-45)
exec.Text = "EXECUTE"
exec.BackgroundColor3 = Color3.fromRGB(0,170,255)
exec.TextColor3 = Color3.new(1,1,1)
exec.Parent = main

-- Clear
local clear = Instance.new("TextButton")
clear.Size = UDim2.new(0.48,-5,0,35)
clear.Position = UDim2.new(0.52,0,1,-45)
clear.Text = "CLEAR"
clear.BackgroundColor3 = Color3.fromRGB(40,40,60)
clear.TextColor3 = Color3.new(1,1,1)
clear.Parent = main

-- Execute logic
exec.MouseButton1Click:Connect(function()
    pcall(function()
        loadstring(box.Text)()
    end)
end)

clear.MouseButton1Click:Connect(function()
    box.Text = ""
end)

close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Drag
local dragging, startPos, startInput

top.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        startPos = main.Position
        startInput = input.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - startInput
        main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- 🌠 Shooting stars background
spawn(function()
    while true do
        task.wait(0.4)

        local star = Instance.new("Frame")
        star.Size = UDim2.new(0,2,0,2)
        star.Position = UDim2.new(math.random(),0,math.random(),0)
        star.BackgroundColor3 = Color3.fromRGB(0,200,255)
        star.BorderSizePixel = 0
        star.Parent = main

        local corner = Instance.new("UICorner", star)
        corner.CornerRadius = UDim.new(1,0)

        game:GetService("TweenService"):Create(
            star,
            TweenInfo.new(1),
            {Position = star.Position + UDim2.new(0, math.random(-80,80), 0, math.random(-80,80)), BackgroundTransparency = 1}
        ):Play()

        game.Debris:AddItem(star, 1)
    end
end)top.Size = UDim2.new(1,0,0,32)
top.BackgroundColor3 = Color3.fromRGB(25,25,35)
top.BorderSizePixel = 0

Instance.new("UICorner", top).CornerRadius = UDim.new(0,12)

-- Title
local title = Instance.new("TextLabel")
title.Parent = top
title.Size = UDim2.new(1,-90,1,0)
title.Position = UDim2.new(0,10,0,0)
title.BackgroundTransparency = 1
title.Text = "⚡ Nova Loader"
title.TextColor3 = Color3.fromRGB(0,170,255)
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextXAlignment = Enum.TextXAlignment.Left

-- Hover helper
local function hover(btn)
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {
            BackgroundTransparency = 0.2
        }):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {
            BackgroundTransparency = 0
        }):Play()
    end)
end

-- Close
local close = Instance.new("TextButton")
close.Parent = top
close.Size = UDim2.new(0,24,0,24)
close.Position = UDim2.new(1,-28,0,4)
close.Text = "X"
close.BackgroundColor3 = Color3.fromRGB(255,70,70)
close.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", close).CornerRadius = UDim.new(0,6)
hover(close)

-- Minimize
local mini = Instance.new("TextButton")
mini.Parent = top
mini.Size = UDim2.new(0,24,0,24)
mini.Position = UDim2.new(1,-56,0,4)
mini.Text = "-"
mini.BackgroundColor3 = Color3.fromRGB(255,180,0)
mini.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", mini).CornerRadius = UDim.new(0,6)
hover(mini)

-- TextBox
local box = Instance.new("TextBox")
box.Parent = main
box.Size = UDim2.new(1,-20,0,85)
box.Position = UDim2.new(0,10,0,40)
box.BackgroundColor3 = Color3.fromRGB(30,30,40)
box.TextColor3 = Color3.fromRGB(255,255,255)
box.PlaceholderText = "Paste Script..."
box.ClearTextOnFocus = false
box.MultiLine = true
box.TextWrapped = true
box.Font = Enum.Font.Code
box.TextSize = 13

Instance.new("UICorner", box).CornerRadius = UDim.new(0,8)

-- Execute
local exec = Instance.new("TextButton")
exec.Parent = main
exec.Size = UDim2.new(0.48,-5,0,30)
exec.Position = UDim2.new(0,10,1,-38)
exec.Text = "▶ Execute"
exec.BackgroundColor3 = Color3.fromRGB(0,170,255)
exec.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", exec).CornerRadius = UDim.new(0,8)
hover(exec)

-- Clear
local clear = Instance.new("TextButton")
clear.Parent = main
clear.Size = UDim2.new(0.48,-5,0,30)
clear.Position = UDim2.new(0.52,0,1,-38)
clear.Text = "🗑 Clear"
clear.BackgroundColor3 = Color3.fromRGB(60,60,60)
clear.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", clear).CornerRadius = UDim.new(0,8)
hover(clear)

-- Drag system
local dragging, start, startPos

top.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        start = i.Position
        startPos = main.Position
    end
end)

top.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UIS.InputChanged:Connect(function(i)
    if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = i.Position - start
        main.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- Execute script
exec.MouseButton1Click:Connect(function()
    local s = box.Text
    if s ~= "" then
        pcall(function()
            local f = loadstring(s)
            if f then f() end
        end)
    end
end)

-- Clear
clear.MouseButton1Click:Connect(function()
    box.Text = ""
end)

-- Close
close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Minimize fix
local minimized = false

mini.MouseButton1Click:Connect(function()
    minimized = not minimized

    if minimized then
        box.Visible = false
        exec.Visible = false
        clear.Visible = false
        main.Size = UDim2.new(0,180,0,35)
    else
        box.Visible = true
        exec.Visible = true
        clear.Visible = true
        main.Size = UDim2.new(0,300,0,180)
    end
end)
