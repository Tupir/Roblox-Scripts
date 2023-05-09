local NS = {
    Title = "SSHub",
    Icon = "rbxassetid://12903179843"
}
local function Notify(Title, Icon, Text, Duration)
    game.StarterGui:SetCore("SendNotification", {Title = Title or ""; Text = Text or ""; Icon = Icon or ""; Duration = tonumber(Duration) or 3 })
end
setclipboard("https://discord.gg/VPdpABVB46")
print("Script updated get new here: https://discord.gg/VPdpABVB46 (copied to clipboard)")
Notify(NS.Title,NS.Icon,"Script updated get new here: https://discord.gg/VPdpABVB46 (copied to clipboard)",5)
