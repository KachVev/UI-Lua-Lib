
-- Enigma UI Minimal (No Slider, Smooth Title Animation)
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local EnigmaUI = {}
EnigmaUI.__index = EnigmaUI

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
    local dragToggle, dragInput, dragStart, startPos
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
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                                       startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

function EnigmaUI:Create(title)
    local self = setmetatable({}, EnigmaUI)

    local gui = Instance.new("ScreenGui", CoreGui)
    gui.Name = "EnigmaUI"
    gui.ResetOnSpawn = false

    local main = Instance.new("Frame", gui)
    main.Size = UDim2.new(0, 650, 0, 500)
    main.Position = UDim2.new(0.5, -325, 0.5, -250)
    main.BackgroundColor3 = theme.Background
    main.BorderSizePixel = 0
    main.Active = true
    MakeDraggable(main)
    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 8)

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

    task.spawn(function()
        while task.wait(2) do
            local fadeIn = TweenService:Create(titleLabel, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                TextColor3 = theme.Accent
            })
            fadeIn:Play()
            fadeIn.Completed:Wait()

            local fadeOut = TweenService:Create(titleLabel, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                TextColor3 = theme.Text
            })
            fadeOut:Play()
            fadeOut.Completed:Wait()
        end
    end)

    local sidebar = Instance.new("Frame", main)
    sidebar.Position = UDim2.new(0, 0, 0, 40)
    sidebar.Size = UDim2.new(0, 150, 1, -40)
    sidebar.BackgroundColor3 = theme.Sidebar
    Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 8)

    local searchBox = Instance.new("TextBox", main)
    searchBox.Size = UDim2.new(1, -160, 0, 30)
    searchBox.Position = UDim2.new(0, 160, 0, 45)
    searchBox.PlaceholderText = "Search..."
    searchBox.Text = ""
    searchBox.TextSize = 14
    searchBox.Font = Enum.Font.Gotham
    searchBox.TextColor3 = theme.Text
    searchBox.BackgroundColor3 = theme.Card
    Instance.new("UICorner", searchBox).CornerRadius = UDim.new(0, 6)

    local contentHolder = Instance.new("Folder", main)
    contentHolder.Name = "ContentHolder"

    local allElements = {}

    function self:Category(name)
        local button = Instance.new("TextButton", sidebar)
        button.Size = UDim2.new(1, 0, 0, 40)
        button.Text = name
        button.Font = Enum.Font.Gotham
        button.TextSize = 14
        button.BackgroundColor3 = theme.Card
        button.TextColor3 = theme.Text
        Instance.new("UICorner", button).CornerRadius = UDim.new(0, 6)

        local page = Instance.new("Frame", contentHolder)
        page.Size = UDim2.new(1, -170, 1, -100)
        page.Position = UDim2.new(0, 160, 0, 80)
        page.BackgroundTransparency = 1
        page.Visible = false
        page.Name = "Category_" .. name

        button.MouseButton1Click:Connect(function()
            for _, pg in pairs(contentHolder:GetChildren()) do
                pg.Visible = false
            end
            page.Visible = true
        end)

        local function createCard(labelText)
            local card = Instance.new("Frame", page)
            card.Size = UDim2.new(1, 0, 0, 50)
            card.Position = UDim2.new(0, 0, 0, #page:GetChildren() * 55)
            card.BackgroundColor3 = theme.Card
            Instance.new("UICorner", card).CornerRadius = UDim.new(0, 6)

            local label = Instance.new("TextLabel", card)
            label.Size = UDim2.new(1, -20, 1, 0)
            label.Position = UDim2.new(0, 10, 0, 0)
            label.BackgroundTransparency = 1
            label.Text = labelText
            label.Font = Enum.Font.Gotham
            label.TextSize = 14
            label.TextColor3 = theme.Text
            label.TextXAlignment = Enum.TextXAlignment.Left

            return card, label
        end

        local api = {}

        function api:Label(text)
            local card, label = createCard(text)
            table.insert(allElements, {button = button, card = card, label = label})
        end

        function api:Button(text, callback)
            local card, label = createCard(text)
            local button = Instance.new("TextButton", card)
            button.Size = UDim2.new(0, 100, 0, 30)
            button.Position = UDim2.new(1, -110, 0.5, -15)
            button.BackgroundColor3 = theme.Accent
            button.Text = "Run"
            button.TextColor3 = theme.Background
            button.Font = Enum.Font.GothamBold
            button.TextSize = 14
            button.MouseButton1Click:Connect(callback)
            table.insert(allElements, {button = button, card = card, label = label})
        end

        function api:Toggle(text, default, callback)
            local card, label = createCard(text)
            local toggle = Instance.new("TextButton", card)
            toggle.Size = UDim2.new(0, 60, 0, 30)
            toggle.Position = UDim2.new(1, -70, 0.5, -15)
            toggle.BackgroundColor3 = theme.Card
            toggle.Text = default and "ON" or "OFF"
            toggle.TextColor3 = default and theme.Accent or theme.SubText
            toggle.Font = Enum.Font.GothamBold
            toggle.TextSize = 14
            local state = default
            toggle.MouseButton1Click:Connect(function()
                state = not state
                toggle.Text = state and "ON" or "OFF"
                toggle.TextColor3 = state and theme.Accent or theme.SubText
                callback(state)
            end)
            table.insert(allElements, {button = toggle, card = card, label = label})
        end

        page.Visible = #contentHolder:GetChildren() == 1
        return api
    end

    searchBox:GetPropertyChangedSignal("Text"):Connect(function()
        local query = searchBox.Text:lower()
        for _, item in pairs(allElements) do
            local match = item.label.Text:lower():find(query)
            if item.button then item.button.Visible = match ~= nil end
            item.card.Visible = match ~= nil
        end
    end)

    return self
end

return EnigmaUI
