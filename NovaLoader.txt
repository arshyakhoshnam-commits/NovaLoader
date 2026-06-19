local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

-- حذف GUI قبلی
pcall(function()
    CoreGui:FindFirstChild("NovaLoader"):Destroy()
end)

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "NovaLoader"
gui.Parent = CoreGui
gui.ResetOnSpawn = false

-- Main
local main = Instance.new("Frame")
main.Parent = gui
main.Size = UDim2.new(0,300,0,180)
main.Position = UDim2.new(0.35,0,0.35,0)
main.BackgroundColor3 = Color3.fromRGB(25,25,25)
main.BorderSizePixel = 0
main.Active = true

Instance.new("UICorner", main).CornerRadius = UDim.new(0,10)

-- TopBar
local top = Instance.new("Frame")
top.Parent = main
top.Size = UDim2.new(1,0,0,30)
top.BackgroundColor3 = Color3.fromRGB(35,35,35)
top.BorderSizePixel = 0

local title = Instance.new("TextLabel")
title.Parent = top
title.Size = UDim2.new(1,-70,1,0)
title.Position = UDim2.new(0,10,0,0)
title.BackgroundTransparency = 1
title.Text = "⚡ Nova Loader"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextXAlignment = Enum.TextXAlignment.Left

-- Close
local close = Instance.new("TextButton")
close.Parent = top
close.Size = UDim2.new(0,25,0,25)
close.Position = UDim2.new(1,-30,0,2)
close.Text = "X"
close.BackgroundColor3 = Color3.fromRGB(255,60,60)
close.TextColor3 = Color3.new(1,1,1)

-- Minimize
local mini = Instance.new("TextButton")
mini.Parent = top
mini.Size = UDim2.new(0,25,0,25)
mini.Position = UDim2.new(1,-60,0,2)
mini.Text = "-"
mini.BackgroundColor3 = Color3.fromRGB(255,180,0)
mini.TextColor3 = Color3.new(1,1,1)

-- TextBox
local box = Instance.new("TextBox")
box.Parent = main
box.Size = UDim2.new(1,-20,0,90)
box.Position = UDim2.new(0,10,0,40)
box.BackgroundColor3 = Color3.fromRGB(40,40,40)
box.TextColor3 = Color3.new(1,1,1)
box.PlaceholderText = "Paste Script..."
box.MultiLine = true
box.ClearTextOnFocus = false
box.TextWrapped = true
box.TextXAlignment = Enum.TextXAlignment.Left
box.TextYAlignment = Enum.TextYAlignment.Top
box.Font = Enum.Font.Code
box.TextSize = 14

Instance.new("UICorner", box).CornerRadius = UDim.new(0,8)

-- Execute
local exec = Instance.new("TextButton")
exec.Parent = main
exec.Size = UDim2.new(0.48,-5,0,35)
exec.Position = UDim2.new(0,10,1,-45)
exec.Text = "▶ Execute"
exec.BackgroundColor3 = Color3.fromRGB(0,170,255)
exec.TextColor3 = Color3.new(1,1,1)

-- Clear
local clear = Instance.new("TextButton")
clear.Parent = main
clear.Size = UDim2.new(0.48,-5,0,35)
clear.Position = UDim2.new(0.52,0,1,-45)
clear.Text = "🗑 Clear"
clear.BackgroundColor3 = Color3.fromRGB(55,55,55)
clear.TextColor3 = Color3.new(1,1,1)

-- Drag
local dragging, dragInput, dragStart, startPos

top.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = main.Position
    end
end)

top.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- Execute Script
exec.MouseButton1Click:Connect(function()
    local scriptText = box.Text

    if scriptText ~= "" then
        pcall(function()
            local func = loadstring(scriptText)
            if func then
                func()
            end
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

-- Minimize
local minimized = false

mini.MouseButton1Click:Connect(function()
    minimized = not minimized

    if minimized then
        box.Visible = false
        exec.Visible = false
        clear.Visible
sonic: = false
        main.Size = UDim2.new(0,180,0,35)
        main.Position = UDim2.new(1,-190,0.5,0)
    else
        box.Visible = true
        exec.Visible = true
        clear.Visible = true
        main.Size = UDim2.new(0,300,0,180)
    end
end)
