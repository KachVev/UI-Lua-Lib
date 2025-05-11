
--// Enigma UI Framework
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local EnigmaUI = {}
EnigmaUI.__index = EnigmaUI

-- Theme
local theme = {
    Background = Color3.fromRGB(30, 30, 30),
    Topbar = Color3.fromRGB(40, 40, 40),
    Sidebar = Color3.fromRGB(35, 35, 35),
    Card = Color3.fromRGB(45, 45, 45),
    Accent = Color3.fromRGB(0, 255, 127),
    Text = Color3.fromRGB(255, 255, 255),
    SubText = Color3.fromRGB(180, 180, 180)
}

local function MakeDraggable(frame)
    local dragToggle = nil
    local dragInput, dragStart, startPos

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragToggle = true
            dragStart = input.Position
            startPos = frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragToggle = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragToggle then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

function EnigmaUI:Create(title)
    local self = setmetatable({}, EnigmaUI)

    -- ScreenGui
    local gui = Instance.new("ScreenGui")
    gui.Name = "EnigmaUI"
    gui.ResetOnSpawn = false
    gui.Parent = CoreGui

    -- Main Frame
    local main = Instance.new("Frame", gui)
    main.Size = UDim2.new(0, 600, 0, 400)
    main.Position = UDim2.new(0.5, -300, 0.5, -200)
    main.BackgroundColor3 = theme.Background
    main.BorderSizePixel = 0
    main.Active = true

    local corner = Instance.new("UICorner", main)
    corner.CornerRadius = UDim.new(0, 8)

    -- Topbar
    local topbar = Instance.new("Frame", main)
    topbar.Size = UDim2.new(1, 0, 0, 40)
    topbar.BackgroundColor3 = theme.Topbar
    Instance.new("UICorner", topbar).CornerRadius = UDim.new(0, 8)

    local titleLabel = Instance.new("TextLabel", topbar)
    titleLabel.Size = UDim2.new(1, 0, 1, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title or "Enigma UI"
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 18
    titleLabel.TextColor3 = theme.Text

    -- Sidebar
    local sidebar = Instance.new("Frame", main)
    sidebar.Position = UDim2.new(0, 0, 0, 40)
    sidebar.Size = UDim2.new(0, 150, 1, -40)
    sidebar.BackgroundColor3 = theme.Sidebar
    Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 8)

    -- Container
    local container = Instance.new("Frame", main)
    container.Position = UDim2.new(0, 160, 0, 50)
    container.Size = UDim2.new(1, -170, 1, -60)
    container.BackgroundTransparency = 1

    -- Dummy Card
    local card = Instance.new("Frame", container)
    card.Size = UDim2.new(1, 0, 0, 80)
    card.Position = UDim2.new(0, 0, 0, 0)
    card.BackgroundColor3 = theme.Card
    local cardCorner = Instance.new("UICorner", card)
    cardCorner.CornerRadius = UDim.new(0, 6)

    card.MouseEnter:Connect(function()
        TweenService:Create(card, TweenInfo.new(0.2), {BackgroundColor3 = theme.Accent}):Play()
    end)
    card.MouseLeave:Connect(function()
        TweenService:Create(card, TweenInfo.new(0.2), {BackgroundColor3 = theme.Card}):Play()
    end)

    local cardText = Instance.new("TextLabel", card)
    cardText.Size = UDim2.new(1, -20, 1, 0)
    cardText.Position = UDim2.new(0, 10, 0, 0)
    cardText.BackgroundTransparency = 1
    cardText.Text = "This is a dummy card"
    cardText.Font = Enum.Font.Gotham
    cardText.TextSize = 16
    cardText.TextColor3 = theme.Text
    cardText.TextXAlignment = Enum.TextXAlignment.Left

    -- Make main draggable via topbar
    MakeDraggable(main)

    return self
end

return EnigmaUI
