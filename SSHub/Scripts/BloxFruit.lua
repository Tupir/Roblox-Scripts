local Name = "SSHub"
_G.LibraryConfg = {
	AccentColors = {
		Accent1 = Color3.fromRGB(255, 255, 255),
		Accent2 = Color3.fromRGB(255, 255, 255),
		TabTextColor = Color3.fromRGB(255,255,255),
	}
}
--#region Notify
local NS = {
	Title = "SSHub",
	Icon = "rbxassetid://8426126371"
}
local function Notify(Title, Icon, Text, Duration)
	game.StarterGui:SetCore("SendNotification", {Title = Title or ""; Text = Text or ""; Icon = Icon or ""; Duration = tonumber(Duration) or 3 })
end
--#endregion
--#region Settings
--Variables Settings
getgenv().Settings = {
   ChestAutoFarm = false,
};

local ESPSettings = {
	PlayerESP = {
		Enabled = false,
		TracersOn = false,
		BoxesOn = false,
		NamesOn = false,
		DistanceOn = false,
		HealthOn = false,
		ToolOn = false,
		FaceCamOn = false,
		Colors = {
			BoxColor = Color3.fromRGB(255, 255, 255),
			NameColor = Color3.fromRGB(255, 255, 255),
			DistanceColor = Color3.fromRGB(255, 255, 255),
			HealthColor = Color3.fromRGB(255, 255, 255),
			ToolColor = Color3.fromRGB(255, 255, 255),
			TracerColor = Color3.fromRGB(255, 255, 255),
			Color = Color3.fromRGB(255, 255, 255)
		},
		Distance = 100000
	}
};

local Success, Error = pcall(function()
    print("Stage [2/2] Loader")
    print("[1/2] Loading...")

    --#region Libs
    local LibraryHttps = "https://raw.githubusercontent.com/miguel831/Roblox-Scripts/main/SSHub/Lib/LibrarySSHub.lua"
    local LibraryESPHttps = "https://raw.githubusercontent.com/miguel831/Roblox-Scripts/main/SSHub/Lib/ESP.lua"
    local Library = loadstring(game:HttpGet(LibraryHttps, true))() 
    local LibraryESP = loadstring(game:HttpGet(LibraryESPHttps, true))()
    --#endregion

    -- #region Services
    local game = game;
    local GetService = game.GetService;
    local Workspace = GetService(game, "Workspace")
    local Players = GetService(game, "Players")
    local ReplicatedStorage = GetService(game, "ReplicatedStorage")
    local ScriptContext = GetService(game, "ScriptContext")
    local LogService = GetService(game, "LogService")
    local RunService = GetService(game, "RunService")
    local Lighting = GetService(game, "Lighting")
    local CoreGui = GetService(game, "CoreGui")
    local VirtualUser = GetService(game, "VirtualUser")
    local Uis = GetService(game, "UserInputService")
    local Cam = Workspace.CurrentCamera
    local Player = Players.LocalPlayer
    local Mouse = Player:GetMouse()
    local GameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
    --#endregion

    --#region Functions
local Character = Player.Character
local function UpdateChar()
    Character = Player.Character
end

local function TableRemove(Table, Item)
    local Index = nil
    for i, v in ipairs (Table) do 
        if (v == Item) then
            Index = i 
        end
    end
table.remove(Table, Index)
end

local function CheckChar(Character, Health)
    local hp = Health or 1; local rt = false
    if Character and Character:FindFirstChild("HumanoidRootPart") then
        if Character:FindFirstChildOfClass("Humanoid") then
            if not Character.Humanoid.Health < hp then
                rt = true
            end
        end
    end
    return rt
end

local function CheckIfCharacterValid(Character)
    if Character ~= nil and Character:FindFirstChild("Humanoid") and Character:FindFirstChild("Humanoid").Health > 0 then
        return true
    else
        return false
    end
end

local function CheckIfUserHasFF(Character)
    if Character:FindFirstChildWhichIsA("ForceField") then
        return true 
    else 
        return false 
    end 
end  


local function CheckIfUserIsFriendly(TargetClient)
    if TargetClient:IsFriendsWith(Player.UserId) then
        return true 
    else 
        return false
    end 
end

local function ClosestPlayer()
	Target = nil; magn = math.huge
    for i, CPlayer in pairs(Players:GetChildren()) do
        if CPlayer ~= nil then
                mag = (Character.HumanoidRootPart.Position - CPlayer.Character.HumanoidRootPart.Position).Magnitude
                if mag < magn then 
                    magn = mag 
                    Target = CPlayer
                end
            end
        end
    return Target
end 

local function ClosestChest()
	Target = nil; magn = math.huge
    for i, CChest in pairs(Workspace:GetDescendants()) do
      if string.find(CChest.Name, "Chest") then
        if CChest:IsA("Part") then
            if CChest ~= nil then
                    mag = (Character.HumanoidRootPart.Position - CChest.Position).Magnitude
                    if mag < magn then 
                        magn = mag 
                        Target = CChest
                    end
                end
            end
        end
    end
    return Target, magn
end 

--#endregion
function zeroGrav(part)
    if part:FindFirstChild("BodyForce") then return end
    local temp = Instance.new("BodyForce")
    temp.Force = part:GetMass() * Vector3.new(0,workspace.Gravity,0)
    temp.Parent = part
 end
local function TeleportTween(To)
    Distance = (To.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    if Distance < 10 then
        Speed = 1000
    elseif Distance < 170 then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = To
        Speed = 350
    elseif Distance < 1000 then
        Speed = 350
    elseif Distance >= 1000 then
        Speed = 250
    end
    game:GetService("TweenService"):Create(
        game.Players.LocalPlayer.Character.HumanoidRootPart,
        TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),
        {CFrame = To}
    ):Play()
end
spawn(function()
    while wait() do
        pcall(function()
            if getgenv().Settings.ChestAutoFarm then
                local Cofre, Distancia = ClosestChest()
                if Cofre then
                    zeroGrav(game.Players.LocalPlayer.Character.HumanoidRootPart)
                    TeleportTween(Cofre.CFrame)
                end
            end
        end)
    end
end)
RunService.RenderStepped:Connect(function()
      UpdateChar()
      LibraryESP.Colors.BoxColor = ESPSettings.PlayerESP.Colors.BoxColor
      LibraryESP.Colors.NameColor = ESPSettings.PlayerESP.Colors.NameColor
      LibraryESP.Colors.DistanceColor = ESPSettings.PlayerESP.Colors.DistanceColor
      LibraryESP.Colors.HealthColor = ESPSettings.PlayerESP.Colors.HealthColor
      LibraryESP.Colors.ToolColor = ESPSettings.PlayerESP.Colors.ToolColor 
      LibraryESP.Colors.TracerColor = ESPSettings.PlayerESP.Colors.TracerColor
end)

local SShub = Library:CreateWindow(Name, Vector2.new(400, 550))
CoreGui:FindFirstChild(Name).main.top.title.Text = Name.."|"..GameName.."|"
local Main = SShub:CreateTab("Main")
local Teleports = SShub:CreateTab("Teleports")
local Visuals = SShub:CreateTab("Visuals")
local Settingss = SShub:CreateTab("Settings-Ui")

local MainT = Teleports:CreateSector("Server", "left")
local MainP = Visuals:CreateSector("Player ESP", "left")
local MainA = Main:CreateSector("AutoFarm", "left")

local MainC = Settingss:CreateSector("Credits", "left")
local MainUI = Settingss:CreateSector("UI", "left")
Settingss:CreateConfigSystem("right")

MainT:AddButton("Rejoin", function()
   local ts = game:GetService("TeleportService")
   local p = game:GetService("Players").LocalPlayer
   ts:Teleport(game.PlaceId, p)
end)
MainA:AddToggle("Chest Auto Farm", getgenv().Settings.ChestAutoFarm, function(V)
    TeleportTween(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
   getgenv().Settings.ChestAutoFarm = V
end, "ChestAutoFarm")
MainA:AddLabel("Lag ⚠️")
MainA:AddButton("Stop Tween", function()
	TeleportTween(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
end)
MainA:AddToggle("Noclip", false, function(V)
   if V == true then
      _G.conn = game:GetService("RunService").Stepped:Connect(function()
         for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then
               v.CanCollide = false    
            end
         end
       end)
      else
       _G.conn:Disconnect()
      end
end, "NoClip")


--Player Visuals
local PlayerESPsToggle = MainP:AddToggle("Toggle ESP's", ESPSettings.PlayerESP.Enabled, function(V)
	ESPSettings.PlayerESP.Enabled = V

	LibraryESP.Tracers = ESPSettings.PlayerESP.TracersOn
	LibraryESP.Names = ESPSettings.PlayerESP.NamesOn
	LibraryESP.Health = ESPSettings.PlayerESP.HealthOn
	LibraryESP.Distance = ESPSettings.PlayerESP.DistanceOn
	LibraryESP.Tool = ESPSettings.PlayerESP.ToolOn
	LibraryESP.Boxes = ESPSettings.PlayerESP.BoxesOn
	LibraryESP.FaceCamera = ESPSettings.PlayerESP.FaceCamOn
	LibraryESP:Toggle(ESPSettings.PlayerESP.Enabled)
end, "PlayerESPsToggle")

PlayerESPsToggle:AddKeybind("None", "PlayerESPsToggle Keybind")

MainP:AddSlider("ESP Distance", 0, ESPSettings.PlayerESP.Distance, 100000, 10, function(V)
	LibraryESP.DistanceS = V
	ESPSettings.PlayerESP.Distance = V
end,"ESPDistance")

local BoxColor = MainP:AddToggle("Boxes", ESPSettings.PlayerESP.BoxesOn, function(V)
	ESPSettings.PlayerESP.BoxesOn = V
	LibraryESP.Boxes = ESPSettings.PlayerESP.BoxesOn
end,"BoxesES")

BoxColor:AddColorpicker(ESPSettings.PlayerESP.Colors.BoxColor, function(V)
	ESPSettings.PlayerESP.Colors.BoxColor = V
end,"BoxESColor")

local TracerColor = MainP:AddToggle("Tracers", ESPSettings.PlayerESP.TracersOn, function(V)
	ESPSettings.PlayerESP.TracersOn = V
	LibraryESP.Tracers = ESPSettings.PlayerESP.TracersOn
end,"TracersES")

TracerColor:AddColorpicker(ESPSettings.PlayerESP.Colors.TracerColor, function(V)
	ESPSettings.PlayerESP.Colors.TracerColor = V
end,"TracersESColor")

local NameColor = MainP:AddToggle("Name", ESPSettings.PlayerESP.NamesOn, function(V)
	ESPSettings.PlayerESP.NamesOn = V
	LibraryESP.Names = ESPSettings.PlayerESP.NamesOn
end,"NameES")

NameColor:AddColorpicker(ESPSettings.PlayerESP.Colors.NameColor, function(V)
	ESPSettings.PlayerESP.Colors.NameColor = V
end,"NameESColor")

local HealthColor = MainP:AddToggle("Health", ESPSettings.PlayerESP.HealthOn, function(V)
	ESPSettings.PlayerESP.HealthOn = V
	LibraryESP.Health = ESPSettings.PlayerESP.HealthOn
end,"HealthES")

HealthColor:AddColorpicker(ESPSettings.PlayerESP.Colors.HealthColor, function(V)
	ESPSettings.PlayerESP.Colors.HealthColor = V
end,"HealthESColor")

local DistanceColor = MainP:AddToggle("Distance", ESPSettings.PlayerESP.DistanceOn, function(V)
	ESPSettings.PlayerESP.DistanceOn = V
	LibraryESP.Distance = ESPSettings.PlayerESP.DistanceOn
end,"DistanceES")

DistanceColor:AddColorpicker(ESPSettings.PlayerESP.Colors.DistanceColor, function(V)
	ESPSettings.PlayerESP.Colors.DistanceColor = V
end,"DistanceESColor")

local ToolColor = MainP:AddToggle("Tool", ESPSettings.PlayerESP.ToolOn, function(V)
	ESPSettings.PlayerESP.ToolOn = V
	LibraryESP.Tool = ESPSettings.PlayerESP.ToolOn
end,"ToolES")

ToolColor:AddColorpicker(ESPSettings.PlayerESP.Colors.ToolColor, function(V)
	ESPSettings.PlayerESP.Colors.ToolColor = V
end,"ToolESColor")

MainP:AddToggle("Face Cam", ESPSettings.PlayerESP.FaceCamOn, function(V)
	ESPSettings.PlayerESP.FaceCamOn = V
	LibraryESP.FaceCamera = ESPSettings.PlayerESP.FaceCamOn
end,"FaceCamES")
--#endregion
MainC:AddLabel("Owner - Tupi")

local ToggleToggleUI = MainUI:AddToggle("UI Shortcut", true, function(V)
	RunService.RenderStepped:Wait()
	game:GetService("CoreGui"):FindFirstChild(Name).Enabled = V
end)

ToggleToggleUI:AddKeybind(Enum.KeyCode.LeftAlt, "Ui Keybind")

MainUI:AddColorpicker("Accent 1", _G.LibraryConfg.AccentColors.Accent1, function(V)
Library.theme.accentcolor = V
SShub:UpdateTheme()
end,"COLOR1")

MainUI:AddColorpicker("Accent 2", _G.LibraryConfg.AccentColors.Accent2, function(V)
Library.theme.accentcolor2 = V
SShub:UpdateTheme()
end,"COLOR2")

MainUI:AddColorpicker("Text Color", _G.LibraryConfg.AccentColors.TabTextColor, function(V)
Library.theme.tabstextcolor = V
SShub:UpdateTheme()
end,"TEXT1")
end)

if Success then
print("[2/2] Load Success")
end

if Error then
	Notify(NS.Title,NS.Icon,"Error, Copied to clipboard")
	print("[Error] Copied to clipboard")
	setclipboard(tostring(Error))
end
