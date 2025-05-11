
--// Enigma UI Framework v3 with global search
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

    local allCards = {}
    local allCategoryButtons = {}

    function self:Category(name)
        local button = Instance.new("TextButton", sidebar)
        button.Size = UDim2.new(1, 0, 0, 40)
        button.Text = name
        button.Font = Enum.Font.Gotham
        button.TextSize = 14
        button.BackgroundColor3 = theme.Card
        button.TextColor3 = theme.Text
        button.BorderSizePixel = 0
        Instance.new("UICorner", button).CornerRadius = UDim.new(0, 6)

        local page = Instance.new("Frame", contentHolder)
        page.Size = UDim2.new(1, -170, 1, -100)
        page.Position = UDim2.new(0, 160, 0, 80)
        page.BackgroundTransparency = 1
        page.Visible = false
        page.Name = "Category_" .. name

        local dummyCard = Instance.new("Frame", page)
        dummyCard.Size = UDim2.new(1, 0, 0, 70)
        dummyCard.Position = UDim2.new(0, 0, 0, 0)
        dummyCard.BackgroundColor3 = theme.Card
        Instance.new("UICorner", dummyCard).CornerRadius = UDim.new(0, 6)

        local dummyText = Instance.new("TextLabel", dummyCard)
        dummyText.Size = UDim2.new(1, -20, 1, 0)
        dummyText.Position = UDim2.new(0, 10, 0, 0)
        dummyText.BackgroundTransparency = 1
        dummyText.Text = name .. " Feature"
        dummyText.Font = Enum.Font.Gotham
        dummyText.TextSize = 14
        dummyText.TextColor3 = theme.Text
        dummyText.TextXAlignment = Enum.TextXAlignment.Left

        button.MouseEnter:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = theme.Accent}):Play()
        end)
        button.MouseLeave:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = theme.Card}):Play()
        end)

        button.MouseButton1Click:Connect(function()
            for _, pg in pairs(contentHolder:GetChildren()) do
                pg.Visible = false
            end
            page.Visible = true
        end)

        table.insert(allCards, {button = button, page = page, card = dummyCard, label = dummyText})
        table.insert(allCategoryButtons, button)

        if #allCategoryButtons == 1 then
            page.Visible = true
        end

        return page
    end

    searchBox:GetPropertyChangedSignal("Text"):Connect(function()
        local query = searchBox.Text:lower()
        for _, item in pairs(allCards) do
            local match = item.label.Text:lower():find(query) or item.button.Text:lower():find(query)
            item.button.Visible = match ~= nil
            item.card.Visible = match ~= nil
        end
    end)

    return self
end

return EnigmaUI
