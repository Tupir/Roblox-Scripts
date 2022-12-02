local NS = {
	Title = "SSHub",
	Icon = "rbxassetid://8426126371"
};
local function Notify(Title, Icon, Text, Duration)
	game.StarterGui:SetCore("SendNotification", {Title = Title or ""; Text = Text or ""; Icon = Icon or ""; Duration = tonumber(Duration) or 3 })
end
local Time = .0
task.spawn(function()
    while task.wait(.1) do
        Time = Time + .1
    end
end)
--#region Loader
local function Load(Script)
    local Success, Error = pcall(function()
		if not game:GetService("CoreGui"):FindFirstChild("SSHub") then
			loadstring(game:HttpGet('https://raw.githubusercontent.com/miguel831/Roblox-Scripts/main/SSHub/Scripts/'.. Script ..'.lua', true))()
		elseif game:GetService("CoreGui"):FindFirstChild("SSHub") then
			game:GetService("Players").LocalPlayer:Kick("\nScript Alredy Loaded")
		end
	end)
    if Error and not Success then
        Notify(NS.Title,NS.Icon,"Error!, Error Copied",5)
		setclipboard(tostring(Error))
    elseif Success and not Error then
    end
end
