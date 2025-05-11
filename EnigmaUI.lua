
-- Enigma UI Framework by KachVev

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Enigma = {}

local theme = {
    Background = Color3.fromRGB(20, 20, 20),
    TabBackground = Color3.fromRGB(25, 25, 25),
    SectionBackground = Color3.fromRGB(30, 30, 30),
    Border = Color3.fromRGB(40, 40, 40),
    Accent = Color3.fromRGB(80, 200, 120),
    Text = Color3.fromRGB(220, 220, 220),
    SubText = Color3.fromRGB(150, 150, 150)
}

function Enigma:Create(title)
    local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    ScreenGui.Name = "EnigmaUI"
    
    local Main = Instance.new("Frame", ScreenGui)
    Main.Size = UDim2.new(0, 600, 0, 400)
    Main.Position = UDim2.new(0.5, -300, 0.5, -200)
    Main.BackgroundColor3 = theme.Background
    Main.BorderSizePixel = 0
    Main.Name = "Main"
    Main.Active = true
    Main.Draggable = true

    local TopBar = Instance.new("Frame", Main)
    TopBar.Size = UDim2.new(1, 0, 0, 30)
    TopBar.BackgroundColor3 = theme.TabBackground
    TopBar.BorderSizePixel = 0

    local Title = Instance.new("TextLabel", TopBar)
    Title.Size = UDim2.new(1, 0, 1, 0)
    Title.BackgroundTransparency = 1
    Title.Text = title
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 14
    Title.TextColor3 = theme.Accent

    local TabContainer = Instance.new("Frame", Main)
    TabContainer.Position = UDim2.new(0, 0, 0, 30)
    TabContainer.Size = UDim2.new(1, 0, 0, 30)
    TabContainer.BackgroundColor3 = theme.Background
    TabContainer.BorderSizePixel = 0

    local Tabs = {}
    local ActiveTab = nil

    function Enigma:Tab(name)
        local TabButton = Instance.new("TextButton", TabContainer)
        TabButton.Size = UDim2.new(0, 100, 1, 0)
        TabButton.BackgroundColor3 = theme.TabBackground
        TabButton.Text = name
        TabButton.Font = Enum.Font.Gotham
        TabButton.TextColor3 = theme.Text
        TabButton.TextSize = 12
        TabButton.BorderSizePixel = 0

        local TabFrame = Instance.new("ScrollingFrame", Main)
        TabFrame.Position = UDim2.new(0, 0, 0, 60)
        TabFrame.Size = UDim2.new(1, 0, 1, -60)
        TabFrame.BackgroundColor3 = theme.Background
        TabFrame.BorderSizePixel = 0
        TabFrame.Visible = false
        TabFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
        TabFrame.ScrollBarThickness = 6
        TabFrame.Name = name .. "_Tab"

        local Layout = Instance.new("UIListLayout", TabFrame)
        Layout.Padding = UDim.new(0, 10)
        Layout.SortOrder = Enum.SortOrder.LayoutOrder

        TabButton.MouseButton1Click:Connect(function()
            if ActiveTab then
                ActiveTab.Visible = false
            end
            ActiveTab = TabFrame
            TabFrame.Visible = true
        end)

        Tabs[name] = TabFrame

        local TabApi = {}

        function TabApi:Section(title)
            local Section = Instance.new("Frame", TabFrame)
            Section.Size = UDim2.new(1, -20, 0, 30)
            Section.BackgroundColor3 = theme.SectionBackground
            Section.BorderSizePixel = 0
            Section.LayoutOrder = 1

            local Label = Instance.new("TextLabel", Section)
            Label.Size = UDim2.new(1, 0, 1, 0)
            Label.BackgroundTransparency = 1
            Label.Font = Enum.Font.GothamBold
            Label.Text = title
            Label.TextSize = 13
            Label.TextColor3 = theme.Text
            Label.TextXAlignment = Enum.TextXAlignment.Left

            return Section
        end

        return TabApi
    end

    return Enigma
end

return Enigma
