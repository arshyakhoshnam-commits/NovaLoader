local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

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
main.BackgroundColor3 = Color3.fromRGB(18,18,25)
main.BorderSizePixel = 0
main.Active = true
main.ClipsDescendants = true

Instance.new("UICorner", main).CornerRadius = UDim.new(0,12)

local stroke = Instance.new("UIStroke", main)
stroke.Color = Color3.fromRGB(0,170,255)
stroke.Thickness = 1.5
stroke.Transparency = 0.3

-- TopBar
local top = Instance.new("Frame")
top.Parent = main
top.Size = UDim2.new(1,0,0,32)
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
