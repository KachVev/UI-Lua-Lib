local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local NotificationLib = {}

function NotificationLib:Notify(config)
    local duration = config.Time or 3

    -- Create GUI container
    local gui = Instance.new("ScreenGui")
    gui.Name = "CustomNotificationUI"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    pcall(function() gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui") end)
    if not gui.Parent then gui.Parent = CoreGui end

    -- Main notification frame
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 300, 0, 70)
    frame.Position = UDim2.new(1, 320, 1, -100)
    frame.AnchorPoint = Vector2.new(1, 1)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    frame.BackgroundTransparency = 0
    frame.BorderSizePixel = 0
    frame.ZIndex = 100
    frame.Parent = gui

    local corner = Instance.new("UICorner", frame)
    corner.CornerRadius = UDim.new(0, 8)

    -- Icon
    local icon = Instance.new("ImageLabel")
    icon.Size = UDim2.new(0, 40, 0, 40)
    icon.Position = UDim2.new(0, 10, 0.5, -20)
    icon.BackgroundTransparency = 1
    icon.Image = config.Image or ""
    icon.ZIndex = 101
    icon.Parent = frame

    -- Title
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -60, 0, 20)
    title.Position = UDim2.new(0, 60, 0, 10)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextSize = 16
    title.TextColor3 = Color3.new(1, 1, 1)
    title.Text = config.Name or "Notification"
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.ZIndex = 101
    title.Parent = frame

    -- Content
    local content = Instance.new("TextLabel")
    content.Size = UDim2.new(1, -60, 0, 20)
    content.Position = UDim2.new(0, 60, 0, 35)
    content.BackgroundTransparency = 1
    content.Font = Enum.Font.Gotham
    content.TextSize = 14
    content.TextColor3 = Color3.fromRGB(200, 200, 200)
    content.Text = config.Content or ""
    content.TextXAlignment = Enum.TextXAlignment.Left
    content.ZIndex = 101
    content.Parent = frame

    -- Animate in
    TweenService:Create(frame, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Position = UDim2.new(1, -20, 1, -20)
    }):Play()

    -- Wait, then animate out
    task.delay(duration, function()
        local tween = TweenService:Create(frame, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Position = UDim2.new(1, 320, 1, -100),
            BackgroundTransparency = 1
        })
        tween:Play()
        tween.Completed:Wait()
        gui:Destroy()
    end)
end

return NotificationLib
