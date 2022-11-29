local NS = {
	Title = "SSHub",
	Icon = "rbxassetid://8426126371"
};
local function Notify(Title, Icon, Text, Duration)
	game.StarterGui:SetCore("SendNotification", {Title = Title or ""; Text = Text or ""; Icon = Icon or ""; Duration = tonumber(Duration) or 3 })
end

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


--#endregion
local SupportedGames = loadstring(game:HttpGet('https://raw.githubusercontent.com/miguel831/Roblox-Scripts/main/SSHub/Games.lua', true))()
local function GetSupportedGame() 
print("Stage [1/2] Game Checker")
print("[1/2] Checking...")
	local Game
    for Id, Info in pairs(SupportedGames) do
        if tostring(game.PlaceId) == Id then
            Game = Info break
        end
    end return Game
end
local SupportedGame = GetSupportedGame()
if SupportedGame then
	print("[2/2] Game found: "..game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name)
    Load(SupportedGame.Script)
else
	Notify(NS.Title,NS.Icon,"No game found!",10)
	print("[2/2] No game found!")
end
