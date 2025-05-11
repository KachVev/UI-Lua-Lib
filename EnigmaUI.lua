local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local Enigma = {}
Enigma.__index = Enigma

local function create(class, props)
	local obj = Instance.new(class)
	for k, v in pairs(props) do
		obj[k] = v
	end
	return obj
end

local function tween(obj, time, props)
	TweenService:Create(obj, TweenInfo.new(time, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props):Play()
end

function Enigma:Create(title)
	local self = setmetatable({}, Enigma)

	local screenGui = create("ScreenGui", {
		Name = "EnigmaUI",
		ResetOnSpawn = false,
		Parent = game.CoreGui
	})

	local main = create("Frame", {
		Name = "Main",
		Size = UDim2.new(0, 500, 0, 400),
		Position = UDim2.new(0.5, -250, 0.5, -200),
		BackgroundColor3 = Color3.fromRGB(30, 30, 30),
		BorderSizePixel = 0,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Parent = screenGui
	})

	create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = main})

	local titleLabel = create("TextLabel", {
		Text = title,
		Size = UDim2.new(1, 0, 0, 40),
		BackgroundTransparency = 1,
		TextColor3 = Color3.new(1, 1, 1),
		Font = Enum.Font.GothamBold,
		TextSize = 20,
		Parent = main
	})

	local tabHolder = create("Frame", {
		Name = "Tabs",
		Size = UDim2.new(1, 0, 0, 30),
		Position = UDim2.new(0, 0, 0, 40),
		BackgroundTransparency = 1,
		Parent = main
	})

	local tabLayout = create("UIListLayout", {
		FillDirection = Enum.FillDirection.Horizontal,
		Padding = UDim.new(0, 5),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent = tabHolder
	})

	local contentHolder = create("Frame", {
		Name = "Content",
		Size = UDim2.new(1, -20, 1, -80),
		Position = UDim2.new(0, 10, 0, 70),
		BackgroundTransparency = 1,
		Parent = main
	})

	self.Tabs = {}
	self.ContentHolder = contentHolder
	self.TabHolder = tabHolder
	self.Main = main

	return self
end

function Enigma:Tab(name)
	local tabBtn = create("TextButton", {
		Text = name,
		Size = UDim2.new(0, 100, 1, 0),
		BackgroundColor3 = Color3.fromRGB(40, 40, 40),
		TextColor3 = Color3.new(1, 1, 1),
		Font = Enum.Font.Gotham,
		TextSize = 14,
		Parent = self.TabHolder
	})

	create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = tabBtn})

	local tabPage = create("Frame", {
		Visible = false,
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		Parent = self.ContentHolder
	})

	tabBtn.MouseButton1Click:Connect(function()
		for _, t in pairs(self.Tabs) do
			t.Page.Visible = false
		end
		tabPage.Visible = true
	end)

	local newTab = {Page = tabPage}
	table.insert(self.Tabs, newTab)

	function newTab:Label(text)
		local label = create("TextLabel", {
			Text = text,
			Size = UDim2.new(1, 0, 0, 30),
			BackgroundTransparency = 1,
			TextColor3 = Color3.fromRGB(200, 200, 200),
			Font = Enum.Font.Gotham,
			TextSize = 14,
			Parent = tabPage
		})
	end

	function newTab:Button(text, callback)
		local button = create("TextButton", {
			Text = text,
			Size = UDim2.new(1, 0, 0, 30),
			BackgroundColor3 = Color3.fromRGB(50, 50, 50),
			TextColor3 = Color3.new(1, 1, 1),
			Font = Enum.Font.Gotham,
			TextSize = 14,
			Parent = tabPage
		})

		create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = button})

		button.MouseButton1Click:Connect(function()
			if callback then callback() end
		end)
	end


	return newTab
end

return Enigma
