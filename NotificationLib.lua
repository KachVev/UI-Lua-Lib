-- Enigma Notification Wrapper
local NotificationLib = {}

--[[
    Creates a notification styled like OrionLib
    Params:
        Name (string): Title of the notification
        Content (string): Subtitle or message
        Image (string): AssetId (e.g. "rbxassetid://4483345998")
        Time (number): How long to display the notification
]]
function NotificationLib:Notify(data)
    assert(data.Name, "Missing Name")
    assert(data.Content, "Missing Content")
    assert(data.Image, "Missing Image")
    assert(data.Time, "Missing Time")

    game.StarterGui:SetCore("SendNotification", {
        Title = data.Name,
        Text = data.Content,
        Icon = data.Image,
        Duration = data.Time
    })
end

-- Example usage:
-- NotificationLib:Notify({
--     Name = "Enigma Example",
--     Content = "Enigma Example",
--     Image = "rbxassetid://4483345998",
--     Time = 5
-- })

return NotificationLib
