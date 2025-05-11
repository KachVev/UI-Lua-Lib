local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local NotificationLib = {}

function NotificationLib:Notify(data)
    assert(data.Name, "Missing Name")
    assert(data.Content, "Missing Content")
    assert(data.Image, "Missing Image")
    assert(data.Time, "Missing Time")

    -- Создание GUI
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "EnigmaNotificationUI"
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = CoreGui

    local Frame = Instance.new("Frame")
    Frame.AnchorPoint = Vector2.new(1, 1)
    Frame.Position = UDim2.new(1, -20, 1, -20)
    Frame.Size = UDim2.new(0, 250, 0, 80)
    Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Frame.BackgroundTransparency = 0.1
    Frame.BorderSizePixel = 0
    Frame.ClipsDescendants = true
    Frame.Visible = false
    Frame.Parent = ScreenGui
    Frame.BackgroundTransparency = 1
    Frame.Name = "NotificationFrame"
    Frame:SetAttribute("Dead", false)
    Frame.ZIndex = 50
    Frame.AutomaticSize = Enum.AutomaticSize.None
    Frame.SizeConstraint = Enum.SizeConstraint.RelativeXY
    Frame:ApplyDescription(Enum.ApplyDescription.Never)
    Frame:SetAttribute("Dead", false)
    Frame:SetAttribute("FadeOut", false)
    Frame:SetAttribute("CanFade", true)
    Frame:SetAttribute("Init", true)
    Frame:SetAttribute("FadeIn", true)
    Frame:SetAttribute("Priority", 0)
    Frame:SetAttribute("Ready", false)
    Frame:SetAttribute("Timer", false)
    Frame:SetAttribute("Sound", true)
    Frame:SetAttribute("Animation", true)
    Frame:SetAttribute("Original", true)
    Frame:SetAttribute("Group", nil)
    Frame:SetAttribute("Update", false)
    Frame:SetAttribute("Direction", 1)
    Frame:SetAttribute("Next", false)
    Frame:SetAttribute("Skip", false)
    Frame:SetAttribute("Pause", false)
    Frame:SetAttribute("Started", false)
    Frame:SetAttribute("Finished", false)
    Frame:SetAttribute("Function", false)
    Frame:SetAttribute("Transition", nil)
    Frame:SetAttribute("Mouse", nil)
    Frame:SetAttribute("Effect", false)
    Frame:SetAttribute("Idle", false)
    Frame:SetAttribute("Label", false)
    Frame:SetAttribute("Result", false)
    Frame:SetAttribute("Height", false)
    Frame:SetAttribute("Lock", false)
    Frame:SetAttribute("Counter", false)
    Frame:SetAttribute("IconSize", false)
    Frame:SetAttribute("Origin", false)

    Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Frame.BackgroundTransparency = 0
    Frame.BorderSizePixel = 0
    Frame.ClipsDescendants = true
    Frame.Name = "Notification"
    Frame.Parent = ScreenGui
    Frame.Visible = true
    Frame.Size = UDim2.new(0, 300, 0, 80)
    Frame.Position = UDim2.new(1, 320, 1, -100)
    Frame.AnchorPoint = Vector2.new(1, 1)
    Frame.BackgroundTransparency = 1
    Frame.ZIndex = 10
    Frame.AutomaticSize = Enum.AutomaticSize.None

    local UICorner = Instance.new("UICorner", Frame)
    UICorner.CornerRadius = UDim.new(0, 8)

    local Icon = Instance.new("ImageLabel")
    Icon.Image = data.Image
    Icon.Size = UDim2.new(0, 30, 0, 30)
    Icon.Position = UDim2.new(0, 10, 0, 10)
    Icon.BackgroundTransparency = 1
    Icon.Parent = Frame

    local Title = Instance.new("TextLabel")
    Title.Text = data.Name
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 16
    Title.TextColor3 = Color3.new(1, 1, 1)
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 50, 0, 10)
    Title.Size = UDim2.new(1, -60, 0, 20)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = Frame

    local Description = Instance.new("TextLabel")
    Description.Text = data.Content
    Description.Font = Enum.Font.Gotham
    Description.TextSize = 14
    Description.TextColor3 = Color3.fromRGB(200, 200, 200)
    Description.BackgroundTransparency = 1
    Description.Position = UDim2.new(0, 50, 0, 35)
    Description.Size = UDim2.new(1, -60, 0, 20)
    Description.TextXAlignment = Enum.TextXAlignment.Left
    Description.Parent = Frame

    -- Анимация появления
    Frame.Position = UDim2.new(1, 320, 1, -100)
    Frame.BackgroundTransparency = 1
    Frame.Visible = true

    TweenService:Create(Frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Position = UDim2.new(1, -20, 1, -20),
        BackgroundTransparency = 0
    }):Play()

    -- Ждём, потом скрываем
    task.delay(data.Time, function()
        if Frame then
            TweenService:Create(Frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                Position = UDim2.new(1, 320, 1, -100),
                BackgroundTransparency = 1
            }):Play()
            task.wait(0.3)
            ScreenGui:Destroy()
        end
    end)
end

return NotificationLib
