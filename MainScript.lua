
--================================
--          WORMHUB v1
--================================

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local Gold = Color3.fromRGB(218, 174, 55)
local Black = Color3.fromRGB(12, 12, 12)

local Screen = Instance.new("ScreenGui")
Screen.Name = "WormHub"
Screen.ResetOnSpawn = false
Screen.Parent = Player:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.fromOffset(330, 245)
Frame.Position = UDim2.new(0.5, -165, 0.5, -122)
Frame.BackgroundColor3 = Black
Frame.BorderColor3 = Gold
Frame.Parent = Screen

local Header = Instance.new("TextLabel")
Header.Size = UDim2.new(1, -40, 0, 38)
Header.BackgroundColor3 = Color3.fromRGB(27, 23, 14)
Header.Text = "WormHub"
Header.TextColor3 = Gold
Header.TextSize = 16
Header.TextXAlignment = Enum.TextXAlignment.Left
Header.Parent = Frame

local Close = Instance.new("TextButton")
Close.Size = UDim2.fromOffset(38, 38)
Close.Position = UDim2.new(1, -38, 0, 0)
Close.Text = "X"
Close.TextColor3 = Gold
Close.BackgroundColor3 = Black
Close.Parent = Frame

local Reopen = Instance.new("TextButton")
Reopen.Size = UDim2.fromOffset(42, 38)
Reopen.Position = UDim2.fromOffset(12, 12)
Reopen.Text = "W"
Reopen.TextColor3 = Gold
Reopen.BackgroundColor3 = Black
Reopen.Visible = false
Reopen.Parent = Screen

Close.Activated:Connect(function()
    Frame.Visible = false
    Reopen.Visible = true
end)

Reopen.Activated:Connect(function()
    Frame.Visible = true
    Reopen.Visible = false
end)

local function GetCoordinates()
    local Character = Player.Character
    local Root = Character and Character:FindFirstChild("HumanoidRootPart")

    if not Root then
        return nil
    end

    local P = Root.Position
    return string.format(
        "X: %.1f | Y: %.1f | Z: %.1f",
        P.X, P.Y, P.Z
    )
end

local function MakeLocation(Name, Y)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.fromOffset(125, 34)
    Button.Position = UDim2.fromOffset(10, Y)
    Button.Text = Name
    Button.TextSize = 11
    Button.TextColor3 = Gold
    Button.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
    Button.BorderColor3 = Gold
    Button.Parent = Frame

    local Coordinate = Instance.new("TextLabel")
    Coordinate.Size = UDim2.new(1, -145, 0, 34)
    Coordinate.Position = UDim2.fromOffset(140, Y)
    Coordinate.BackgroundColor3 = Black
    Coordinate.Text = "Belum diatur"
    Coordinate.TextColor3 = Color3.new(1, 1, 1)
    Coordinate.TextSize = 10
    Coordinate.Parent = Frame

    Button.Activated:Connect(function()
        local Position = GetCoordinates()
        Coordinate.Text = Position or "Karakter belum siap"
    end)
end

MakeLocation("Set Location Dig", 48)
MakeLocation("Set Location Pan", 90)

local function MakeToggle(Name, Y)
    local Active = false
    local Button = Instance.new("TextButton")

    Button.Size = UDim2.new(1, -20, 0, 36)
    Button.Position = UDim2.fromOffset(10, Y)
    Button.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
    Button.BorderColor3 = Gold
    Button.TextColor3 = Gold
    Button.TextSize = 12
    Button.Text = Name .. " : OFF"
    Button.Parent = Frame

    Button.Activated:Connect(function()
        Active = not Active
        Button.Text = Name .. (Active and " : ON" or " : OFF")
    end)
end

MakeToggle("Auto Dig", 135)
MakeToggle("Auto Pan", 178)

-- Geser panel dengan sentuhan atau mouse
local Dragging = false
local StartInput
local StartPosition

Header.Active = true

Header.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.Touch
        or Input.UserInputType == Enum.UserInputType.MouseButton1 then

        Dragging = true
        StartInput = Input.Position
        StartPosition = Frame.Position
    end
end)

UIS.InputChanged:Connect(function(Input)
    if not Dragging then return end

    if Input.UserInputType == Enum.UserInputType.Touch
        or Input.UserInputType == Enum.UserInputType.MouseMovement then

        local Delta = Input.Position - StartInput

        Frame.Position = UDim2.new(
            StartPosition.X.Scale,
            StartPosition.X.Offset + Delta.X,
            StartPosition.Y.Scale,
            StartPosition.Y.Offset + Delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.Touch
        or Input.UserInputType == Enum.UserInputType.MouseButton1 then
        Dragging = false
    end
end)

print("WormHub v1 berhasil dimuat")
