local Enigma = {}

-- Utility: simple instance constructor
local function Create(class, props)
    local inst = Instance.new(class)
    for i,v in pairs(props) do
        inst[i] = v
    end
    return inst
end

-- Main entry
function Enigma.new(title, userId, buyer)
    local self = {}

    local gui = Create("ScreenGui", {
        Name = "EnigmaUI",
        ResetOnSpawn = false,
        Parent = game:GetService("CoreGui")
    })

    local window = Create("Frame", {
        Size = UDim2.new(0, 600, 0, 400),
        Position = UDim2.new(0.5, -300, 0.5, -200),
        BackgroundColor3 = Color3.fromRGB(25, 25, 25),
        BorderSizePixel = 0,
        Parent = gui
    })

    Create("TextLabel", {
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundColor3 = Color3.fromRGB(35, 35, 35),
        Text = title or "Enigma UI",
        Font = Enum.Font.GothamBold,
        TextSize = 20,
        TextColor3 = Color3.new(1, 1, 1),
        Parent = window
    })

    local categories = {}

    function self:Category(name, icon)
        local category = {}

        local button = Create("TextButton", {
            Size = UDim2.new(0, 100, 0, 30),
            Position = UDim2.new(0, #categories * 105, 0, 50),
            BackgroundColor3 = Color3.fromRGB(50, 50, 50),
            Text = name,
            Font = Enum.Font.Gotham,
            TextSize = 14,
            TextColor3 = Color3.new(1, 1, 1),
            Parent = window
        })

        function category:Button(name, icon)
            local subButton = {}

            Create("TextButton", {
                Size = UDim2.new(0, 120, 0, 25),
                Position = UDim2.new(0, 20, 0, 100 + (#categories * 35)),
                BackgroundColor3 = Color3.fromRGB(60, 60, 60),
                Text = name,
                Font = Enum.Font.Gotham,
                TextSize = 12,
                TextColor3 = Color3.new(1, 1, 1),
                Parent = window
            })

            function subButton:Section(title, side)
                local section = {}

                Create("TextLabel", {
                    Size = UDim2.new(0, 260, 0, 25),
                    Position = side == "Right" and UDim2.new(0, 310, 0, 140) or UDim2.new(0, 20, 0, 140),
                    BackgroundColor3 = Color3.fromRGB(40, 40, 40),
                    Text = title,
                    Font = Enum.Font.GothamBold,
                    TextSize = 14,
                    TextColor3 = Color3.new(1, 1, 1),
                    Parent = window
                })

                return section
            end

            return subButton
        end

        table.insert(categories, category)
        return category
    end

    return self
end

return Enigma
