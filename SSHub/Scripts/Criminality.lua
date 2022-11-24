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
local stocked
local sstockk
local Settings = {
	GunMods = { 
		NoRecoil = false,
		InstantEquip = false,
		Spread = false,
		InstantAim = false,
		Values = {
			RecoilAmmount = 0,
			SpreadAmmount = 0,
			},
		Removes = {
			EquipAnim = false,
			AimAnim = false,
			},
		},
	TpHit = {
		Name = "nil",
		HitPart = "Head",
		Weapon = "Fists",
		Configs = {
			Bat = {0.5, 0.1},
			Fists = {0.2, 0.1},
			FireAxe = {0.65, 0.1},
			Chainsaw = {0.13, 0.1},
		},
		--|1| When do teleport + Start hit seceunce
		--|2| When do the hit
		--|3| When teleport back
	},
	Killaura = false,
	AntiStomp = false,
	EZBypass = false,
	AutoBreakSafes = false,
	DownedChat = false,
	KillChat = false,
	KillMSG = "",
	IsDead = true,
	AutoPickCash = false,
	AutoPickTools = false,
	AutoPickScrap = false,
	InfiniteStamina = false,
	NoJumpCooldown = false,
	SpaceJump = false,
	NoFailLockpick = false,
	ShowChatLogs = true,
	NoFlashbang  = false,
	NoSmoke = false,
	UnlockDoorsNearby = false,
	OpenDoorsNearby = false,
	NoClipD = false,
	FullBright = false,
	CamFovToggled = false,
	CamFov = 70,
	Zoom = 10,
	InfinitePepperSpray = false,
	PepperSprayAura = false,
	WalkSpeed = {Enabled = false, Amount = 30},
	JumpPower = {Enabled = false, Amount = 75},
	NoBarbwire = false,
	NoFallDamage = false,
	NoRagdoll = false,
	WallBang = false,
	ElevatorTP = false,
	TowerTP = false,
	UIKey = Enum.KeyCode.LeftAlt,
	NoDowned = false,
}
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
		Distance = 2000
	}, 
	ScrapESP = {
		Enabled = false,
		LegendaryOnly = false,
		RareOnly = false,
		GoodOnly = false,
		BadOnly = false,
		Distance = 2000,
		RarityColors = {
			Bad = Color3.fromRGB(175, 175, 175),
			Good = Color3.fromRGB(0, 255, 0),
			Rare = Color3.fromRGB(255, 0, 0),
			Legendary = Color3.fromRGB(255, 255, 160)
		}	
	},
	SafeESP = {
		Enabled = false,
		BigOnly = false,
		SmallOnly = false,
		Distance = 2000,
	},
	RegisterESP = {
		Enabled = false,
		Distance = 2000
	},
	DealerSESP = {
		Enabled = false,
		Distance = 10000
	},
};
local CoolDowns = {
	AutoPickUps = {
		ScrapCooldown = false,
		MoneyCooldown = false,
		ToolCooldown = false
	}
}
local Information = {
	Map = {
	SpawnedScraps = {},
	SpawnedTools = {},
	SpawnedCash = {},
	Dealers = {}
},
Clients = {
	Characters = {},
	Client = {}
	}
}
--Silent Aim Settings
local SilentSettings = { Main = { Enabled = false, TeamCheck = false, VisibleCheck = false, TargetPart = "Head" }, FOVSettings = { Visible = false, Radius = 360 }, SilentAimColor = Color3.fromRGB(255, 255, 255)};
local ValidTargetParts = {"Head", "Torso"};
--#endregion
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
local CoreGui = GetService(game, "CoreGui");
local Uis = GetService(game, "UserInputService");
local Cam = Workspace.CurrentCamera;
local Player = Players.LocalPlayer;
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

local function CheckIfHoldingGun(Character)
    if Character:FindFirstChildWhichIsA("Tool") and Character:FindFirstChildWhichIsA("Tool"):FindFirstChild("IsGun") then
        return true 
    else 
        return false 
    end 
end 

local function CheckIfHoldingMelee(Character)
    if Character:FindFirstChildWhichIsA("Tool") and Character:FindFirstChildWhichIsA("Tool"):FindFirstChild("MeleeClient") then
        return true
    else
        return false 
    end 
end 

local function CheckIfToolHasConfig(Tool)
if Tool:FindFirstChild("Config") then 
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

local function CheckIfUserIsDowned(Player)
    if ReplicatedStorage.Values.LegacyDowningSystem.Value == false then 
        if ReplicatedStorage.CharStats[Player.Name].Downed.Value == true then 
        return true 
        else 
        return false 
    end 
    elseif ReplicatedStorage.Values.LegacyDowningSystem.Value == true then 
        if Player.Character.Torso:FindFirstChild("PointLight") then 
            return true 
        else 
            return false
        end 
    end 
end

local function CheckIfUserIsFriendly(TargetClient)
    if TargetClient:IsFriendsWith(Player.UserId) then
        return true 
    else 
        return false
    end 
end

local function ClosestDealer()
	Target = nil; magn = math.huge
    for i, Dealer in pairs(workspace.Map.Shopz:GetChildren()) do
        if Dealer.Type.Value == "IllegalStore" then
                mag = (Character.HumanoidRootPart.Position - Dealer.MainPart.Position).Magnitude
                if mag < magn then 
                    magn = mag 
                    Target = Dealer
                end
            end
        end
    return Target
end

local function ClosestSafe(Dis)
    Target = nil; magn = Dis
    for i, Safe in pairs(workspace.Map.BredMakurz:GetChildren()) do
        if string.find(Safe.Name, "Safe") then
            if Safe:FindFirstChild("Values") then 
                mag = (Character.HumanoidRootPart.Position - Safe.MainPart.Position).Magnitude
                if mag < magn and not Safe.Values.Broken.Value then 
                    magn = mag 
                    Target = Safe
                end
            end
        end
    end
    return Target, Target.Values
end

local function ClosestRegister(Dis)
	Target = nil; magn = Dis
    for i, Register in pairs(workspace.Map.BredMakurz:GetChildren()) do
        if string.find(Register.Name, "Register") then
            if Register:FindFirstChild("Values") then 
                mag = (Character.HumanoidRootPart.Position - Register.MainPart.Position).Magnitude
                if mag < magn then 
                    magn = mag 
                    Target = Register
                end
            end
        end
    end
    return Target, Target.Values 
end 

local function ClosestDoor(Dis)
	Target = nil; magn = Dis
    for i, Door in pairs(workspace.Map.Doors:GetChildren()) do
		if Door ~= nil and Door.DoorBase ~= nil then
            if Door:FindFirstChild("Values") and Door:FindFirstChild("Events") then 
                mag = (Character.HumanoidRootPart.Position - Door.DoorBase.Position).Magnitude
                if mag < magn then 
                    magn = mag 
                    Target = Door
                end
            end
        end
    end
    return Target, Target.Values, Target.Events
end 

local function ClosestScrap()
	Target = nil; magn = math.huge
    for i, Scrap in pairs(workspace.Filter.SpawnedPiles:GetChildren()) do
        if Scrap ~= nil then
                mag = (Character.HumanoidRootPart.Position - Scrap.MeshPart.Position).Magnitude
                if mag < magn then 
                    magn = mag 
                    Target = Scrap
                end
            end
        end
    return Target
end 

local function ClosestTool()
	Target = nil; magn = math.huge
    for i, Tool in pairs(workspace.Map.SpawnedTools:GetChildren()) do
        if Tool ~= nil then
                mag = (Character.HumanoidRootPart.Position - Tool.MeshPart.Position).Magnitude
                if mag < magn then 
                    magn = mag 
                    Target = Tool
                end
            end
        end
    return Target
end 

local function ClosestMoney()
	Target = nil; magn = math.huge
    for i, Money in pairs(workspace.Filter.SpawnedBread:GetChildren()) do
        if Money ~= nil then
                mag = (Character.HumanoidRootPart.Position - Money.Position).Magnitude
                if mag < magn then 
                    magn = mag 
                    Target = Money
                end
            end
        end
    return Target
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



local function GenerateSeed(Type)
        local GeneratedSeed 
            if Type == "Finish" then
                GeneratedSeed = ReplicatedStorage.Events:FindFirstChild("XMHH.1"):InvokeServer("\240\159\154\168", tick(), Character:FindFirstChildWhichIsA("Tool"), "EXECQQ")
            elseif Type == "Hit" then 
                GeneratedSeed = ReplicatedStorage.Events:FindFirstChild("XMHH.1"):InvokeServer("\240\159\154\168", tick(), Character:FindFirstChildWhichIsA("Tool"), "43TRFWJ", "Normal", tick(), true) 
            elseif Type == "BreakSafe" then 
                GeneratedSeed = ReplicatedStorage.Events:FindFirstChild("XMHH.1"):InvokeServer("\240\159\154\168", tick(), Character:FindFirstChild("Crowbar"), "DZDRRRKI", ClosestSafe(5), "Register") 
            elseif Type == "BreakRegister" then
                GeneratedSeed = ReplicatedStorage.Events:FindFirstChild("XMHH.1"):InvokeServer("\240\159\154\168", tick(), Character:FindFirstChildWhichIsA("Tool"), "DZDRRRKI", ClosestRegister(10), "Register") 
            elseif Type == "BreakDoor" then
                GeneratedSeed = ReplicatedStorage.Events:FindFirstChild("XMHH.1"):InvokeServer("\240\159\154\168", tick(), Character:FindFirstChildWhichIsA("Tool"), "DZDRRRKI", ClosestDoor(10), "Door") 
			end
	return GeneratedSeed
end
--#endregion
--#region Signal Events
Players.PlayerAdded:Connect(function(PlayerAdded)
if PlayerAdded ~= Player then
    PlayerAdded.CharacterAdded:Connect(function(CharacterAdded)
        table.insert(Information.Clients.Characters, CharacterAdded)
    end)
    PlayerAdded.CharacterRemoving:Connect(function(CharacterRemoved)
        TableRemove(Information.Clients.Characters, CharacterRemoved)
    end)
    table.insert(Information.Clients.Client, PlayerAdded)
end 
end)

Players.PlayerRemoving:Connect(function(ClientRemoved)
TableRemove(Information.Clients.Client, ClientRemoved)
end)

Workspace.Filter.ChildAdded:Connect(function(Object)
    if Object.Parent == Workspace.Filter.SpawnedBread then
        table.insert(Information.Map.SpawnedCash, Object)
    elseif Object.Parent == Workspace.Filter.SpawnedTools then
        table.insert(Information.Map.SpawnedTools, Object)
    elseif Object.Parent == Workspace.Filter.SpawnedPiles then
        table.insert(Information.Map.SpawnedScraps, Object)
    end
end)

Workspace.Filter.ChildRemoved:Connect(function(Object)
    if Object.Parent == Workspace.Filter.SpawnedBread then
        TableRemove(Information.Map.SpawnedCash, Object)
    elseif Object.Parent == Workspace.Filter.SpawnedTools then
        TableRemove(Information.Map.SpawnedTools, Object)
    elseif Object.Parent == Workspace.Filter.SpawnedPiles then
        TableRemove(Information.Map.SpawnedScraps, Object)
    end
end)

for _, Connection in next, getconnections(LogService.MessageOut) do
    Connection:Disable() 
end 
for _, Connection in next, getconnections(ScriptContext.Error) do
    Connection:Disable()
end 
for _, PlayerConnected in next, Players:GetPlayers() do
    table.insert(Information.Clients.Client, PlayerConnected)
end 
for _, Character in next, Workspace.Characters:GetChildren() do
    table.insert(Information.Clients.Characters, Character)
end 
for _, Object in next, Workspace.Filter.SpawnedBread:GetChildren() do
    table.insert(Information.Map.SpawnedCash, Object)
end
for _, Object in next, Workspace.Filter.SpawnedTools:GetChildren() do
    table.insert(Information.Map.SpawnedTools, Object)
end 
for _, Object in next, Workspace.Filter.SpawnedPiles:GetChildren() do
    table.insert(Information.Map.SpawnedScraps, Object)
end 
for _, Object in next, Workspace.Map.Shopz:GetChildren() do
    table.insert(Information.Map.Dealers, Object)
end
--#endregion
--Admins Check--
game.Players.PlayerAdded:Connect(function(AdminUserCheck)
    if AdminUserCheck.UserId == 68246168 or AdminUserCheck.UserId == 955294 or AdminUserCheck.UserId == 1095419 or AdminUserCheck.UserId == 50585425 or AdminUserCheck.UserId == 48405917 or AdminUserCheck.UserId == 9212846 or AdminUserCheck.UserId == 47352513 or AdminUserCheck.UserId == 48058122 then
		Notify(NS.Title,NS.Icon,"Mod Alert\n"..AdminUserCheck.Name..", Is in the server.", 120)
    elseif AdminUserCheck.UserId == 42066711 or AdminUserCheck.UserId == 513615792 then
		Notify(NS.Title,NS.Icon,"Contractors Alert\n"..AdminUserCheck.Name..", Is in the server.", 120)
    elseif AdminUserCheck.UserId == 151691292 or AdminUserCheck.UserId == 92504899 or AdminUserCheck.UserId == 31967243 then
		Notify(NS.Title,NS.Icon,"Devs Alert\n"..AdminUserCheck.Name..", Is in the server.", 120)
    elseif AdminUserCheck.UserId == 29761878 then
		Notify(NS.Title,NS.Icon,"Owner Alert\n"..AdminUserCheck.Name..", Is in the server.", 120)
    end
end)

for i, v in pairs(game.Players:GetPlayers()) do
    if v.UserId == 68246168 or v.UserId == 955294 or v.UserId == 1095419 or v.UserId == 50585425 or v.UserId == 48405917 or v.UserId == 9212846 or v.UserId == 47352513 or v.UserId == 48058122 then
        Notify(NS.Title,NS.Icon,"Mod Alert\n"..v.Name..", Is in the server.", 120)
    elseif v.UserId == 42066711 or v.UserId == 513615792 then
		Notify(NS.Title,NS.Icon,"Contractors Alert\n"..v.Name..", Is in the server.", 120)
    elseif v.UserId == 151691292 or v.UserId == 92504899 or v.UserId == 31967243 then
		Notify(NS.Title,NS.Icon,"Devs Alert\n"..v.Name..", Is in the server.", 120)
    elseif v.UserId == 29761878 then
		Notify(NS.Title,NS.Icon,"Owner Alert\n"..v.Name..", Is in the server.", 120)
    end
end
--Admin Check End--
local function Bypass()
    local Args = {"A", "B", "GP", "EN"}
    local function ScanTable(Table)
        for i, v in ipairs(Args) do
            if (not rawget(Table, v)) then
                return false
                end
            end  
            return true 
        end
    local Functions do
        for i,v in pairs(getgc(true)) do
            if typeof(v) == "table" and ScanTable(v) then
                Functions = v
                break
            end 
        end 
    end 
    if Functions and (Functions.A and Functions.B) then
        hookfunction(Functions.A, function() end)
        hookfunction(Functions.B, function() end)
    end 
end 
--#region Silent Aim
local Mouse = Player:GetMouse()
local WorldToScreen = Cam.WorldToScreenPoint
local WorldToViewportPoint = Cam.WorldToViewportPoint
local GetPartsObscuringTarget = Cam.GetPartsObscuringTarget
local ExpectedArguments = {
	Raycast = {
		ArgCountRequired = 3,
			Args = {
				"Instance", "Vector3", "Vector3", "RaycastParams"
			}
		}
	};


	local SilentAIMFov = Drawing.new("Circle")
	SilentAIMFov.Thickness = 1
	SilentAIMFov.NumSides = 100
	SilentAIMFov.Radius = 360
	SilentAIMFov.Filled = false
	SilentAIMFov.Visible = false
	SilentAIMFov.ZIndex = 999
	SilentAIMFov.Transparency = 1
	SilentAIMFov.Color = Color3.fromRGB(25,25,25)
	SilentSettings.Visible = false
	--Silent Aim Functions--
	local function GetPositionOnScreen(Vector)
		local Vec3, OnScreen = WorldToScreen(Cam, Vector)
		return Vector2.new(Vec3.X, Vec3.Y), OnScreen
	end

	local function ValidateArguments(Args, RayMethod)
		local Matches = 0

		if #Args < RayMethod.ArgCountRequired then
			return false
		end

		for Pos, Argument in next, Args do
			if typeof(Argument) == RayMethod.Args[Pos] then
				Matches = Matches + 1
			end
		end

		return Matches >= RayMethod.ArgCountRequired
	end

	local function GetDirection(Origin, Position)
		return (Position - Origin).Unit * (Origin - Position).Magnitude
	end

	local function GetMousePosition()
		return Vector2.new(Mouse.X, Mouse.Y)
	end

		local function IsPlayerVisible(TargetPlayer)
		local PlayerCharacter = TargetPlayer.Character
		local LocalPlayerCharacter = Player.Character

		if not (PlayerCharacter or LocalPlayerCharacter) then return end 

		local PlayerRoot = game.FindFirstChild(PlayerCharacter, SilentSettings.Main.TargetPart) or game.FindFirstChild(PlayerCharacter, "HumanoidRootPart")

		if not PlayerRoot then return end 

		local CastPoints, IgnoreList = {PlayerRoot.Position, LocalPlayerCharacter, PlayerCharacter}, {LocalPlayerCharacter, PlayerCharacter}
		local ObscuringObjects = #GetPartsObscuringTarget(Cam, CastPoints, IgnoreList)

		return ((ObscuringObjects == 0 and true) or (ObscuringObjects > 0 and false))
	end

	local function GetClosestPlayer()
		if not SilentSettings.Main.TargetPart then return end

		local Closest
		local DistanceToMouse

		for _, v in next, game.GetChildren(Players) do
			if v == Player then continue end
			if SilentSettings.Main.TeamCheck and v.Team == Player.Team then continue end

			local Character = v.Character
			if not Character then continue end

			if SilentSettings.Main.VisibleCheck and not IsPlayerVisible(v) then continue end

			local HumanoidRootPart = game.FindFirstChild(Character, "HumanoidRootPart")
			local Humanoid = game.FindFirstChild(Character, "Humanoid")

			if not HumanoidRootPart or not Humanoid or Humanoid and Humanoid.Health <= 0 then continue end

			local ScreenPosition, OnScreen = GetPositionOnScreen(HumanoidRootPart.Position)

			if not OnScreen then continue end

			local Distance = (GetMousePosition() - ScreenPosition).Magnitude
			if Distance <= (DistanceToMouse or (SilentSettings.Main.Enabled and SilentSettings.FOVSettings.Radius) or 2000) then
				Closest = ((SilentSettings.Main.TargetPart == "Random" and Character[ValidTargetParts[math.random(1, #ValidTargetParts)]]) or Character[SilentSettings.Main.TargetPart])
				DistanceToMouse = Distance
			end
		end
		return Closest
	end
--#endregion
if game:IsLoaded() then Bypass() end
--#region Esp Handlers
		local function DealerSESP(Dealer, Stock)
			local ItemName = Drawing.new("Text")
			ItemName.Visible = false
			ItemName.Center = true
			ItemName.Outline = true
			ItemName.Font = 2
			ItemName.Size = 13
			ItemName.Color = Color3.new(1, 2.5, 2.5)
			ItemName.Text = "Dealer"

			local RarityText = Drawing.new("Text")
			RarityText.Visible = false
			RarityText.Center = true
			RarityText.Outline = true
			RarityText.Font = 2
			RarityText.Size = 13
			RarityText.Color = Color3.new(1, 2.5, 2.5)
			RarityText.Text = "Type"

			local DistanceText = Drawing.new("Text")
			DistanceText.Visible = false
			DistanceText.Center = true
			DistanceText.Outline = true
			DistanceText.Font = 2
			DistanceText.Size = 13
			DistanceText.Color = Color3.new(1, 2.5, 2.5)
			DistanceText.Text = "Distance"

			local function InfoUpdate()
				local Iu

				Iu = RunService.RenderStepped:Connect(function()
					if Dealer:FindFirstChild("CurrentStocks"):FindFirstChild(Stock).Value == 0 then
						ItemName.Visible = false
						RarityText.Visible = false
						DistanceText.Visible = false

						Iu:Disconnect()
					else
						local Vector, OnScreen = Cam:WorldToViewportPoint(Dealer:FindFirstChild("MainPart").Position)

						if OnScreen then
							ItemName.Position = Vector2.new(Vector.X, Vector.Y - 30)
							RarityText.Position = Vector2.new(Vector.X, Vector.Y - 20)
							DistanceText.Position = Vector2.new(Vector.X, Vector.Y - 10)

							ItemName.Visible = false
							RarityText.Visible = false
							DistanceText.Visible = false

							local ItemDistance = math.ceil((Dealer.MainPart.Position - game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).magnitude)

							if ESPSettings.DealerSESP.Enabled == true then 
								if ItemDistance < ESPSettings.DealerSESP.Distance then
										RarityText.Text = "Stock: "..Stock
										RarityText.Color = Color3.fromRGB(72, 255, 0)
										if ESPSettings.DealerSESP.Enabled == true then
											ItemName.Visible = true
											RarityText.Visible = true
											DistanceText.Visible = true
										else
											ItemName.Visible = false
											RarityText.Visible = false
											DistanceText.Visible = false
										end

									DistanceText.Text = "["..tostring(ItemDistance).."]"
									if Stock == sstockk then
										ItemName.Visible = true
										RarityText.Visible = true
										DistanceText.Visible = true

									else
										ItemName.Visible = false
										RarityText.Visible = false
										DistanceText.Visible = false

									end
								else
									ItemName.Visible = false
									RarityText.Visible = false
									DistanceText.Visible = false
								end
							else
								ItemName.Visible = false
								RarityText.Visible = false
								DistanceText.Visible = false

								Iu:Disconnect()
							end
						else
							ItemName.Visible = false
							RarityText.Visible = false
							DistanceText.Visible = false
						end
					end
				end)
			end
			coroutine.wrap(InfoUpdate)()
		end
			local function ScrapESP(Scrap)
				local ItemName = Drawing.new("Text")
				ItemName.Visible = false
				ItemName.Center = true
				ItemName.Outline = true
				ItemName.Font = 2
				ItemName.Size = 13
				ItemName.Color = Color3.new(1, 2.5, 2.5)
				ItemName.Text = "Scrap"

				local RarityText = Drawing.new("Text")
				RarityText.Visible = false
				RarityText.Center = true
				RarityText.Outline = true
				RarityText.Font = 2
				RarityText.Size = 13
				RarityText.Color = Color3.new(1, 2.5, 2.5)
				RarityText.Text = "Type"

				local DistanceText = Drawing.new("Text")
				DistanceText.Visible = false
				DistanceText.Center = true
				DistanceText.Outline = true
				DistanceText.Font = 2
				DistanceText.Size = 13
				DistanceText.Color = Color3.new(1, 2.5, 2.5)
				DistanceText.Text = "Distance"

				local function InfoUpdate()
					local Iu

					Iu = RunService.RenderStepped:Connect(function()
						if not workspace:IsAncestorOf(Scrap) then
							ItemName.Visible = false
							RarityText.Visible = false
							DistanceText.Visible = false

							Iu:Disconnect()
						else
							local Vector, OnScreen = Cam:WorldToViewportPoint(Scrap:FindFirstChild("MeshPart").Position)

							if OnScreen then
								ItemName.Position = Vector2.new(Vector.X, Vector.Y - 30)
								RarityText.Position = Vector2.new(Vector.X, Vector.Y - 20)
								DistanceText.Position = Vector2.new(Vector.X, Vector.Y - 10)

								ItemName.Visible = false
								RarityText.Visible = false
								DistanceText.Visible = false

								local ItemDistance = math.ceil((Scrap.MeshPart.Position - game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).magnitude)

								if ESPSettings.ScrapESP.Enabled == true then
									if ItemDistance < ESPSettings.ScrapESP.Distance then
										if tostring(Scrap:FindFirstChild("MeshPart"):FindFirstChild("Particle").Color) == "0 1 1 1 0 1 1 1 1 0 " then
											RarityText.Text = "Rarity: Bad"
											RarityText.Color = ESPSettings.ScrapESP.RarityColors.Bad
											if ESPSettings.ScrapESP.BadOnly == true then
												ItemName.Visible = true
												RarityText.Visible = true
												DistanceText.Visible = true
											else
												ItemName.Visible = false
												RarityText.Visible = false
												DistanceText.Visible = false
											end
										end

										DistanceText.Text = "["..tostring(ItemDistance).."]"
									else
										ItemName.Visible = false
										RarityText.Visible = false
										DistanceText.Visible = false
									end
								else
									ItemName.Visible = false
									RarityText.Visible = false
									DistanceText.Visible = false

									Iu:Disconnect()
								end
							else
								ItemName.Visible = false
								RarityText.Visible = false
								DistanceText.Visible = false
							end
						end
					end)
				end
				coroutine.wrap(InfoUpdate)()
			end

			local function BoxESP(Scrap)
				local ItemName = Drawing.new("Text")
				ItemName.Visible = false
				ItemName.Center = true
				ItemName.Outline = true
				ItemName.Font = 2
				ItemName.Size = 13
				ItemName.Color = Color3.new(1, 2.5, 2.5)
				ItemName.Text = "Box"

				local RarityText = Drawing.new("Text")
				RarityText.Visible = false
				RarityText.Center = true
				RarityText.Outline = true
				RarityText.Font = 2
				RarityText.Size = 13
				RarityText.Color = Color3.new(1, 2.5, 2.5)
				RarityText.Text = "Type"

				local DistanceText = Drawing.new("Text")
				DistanceText.Visible = false
				DistanceText.Center = true
				DistanceText.Outline = true
				DistanceText.Font = 2
				DistanceText.Size = 13
				DistanceText.Color = Color3.new(1, 2.5, 2.5)
				DistanceText.Text = "Distance"

				local function InfoUpdate()
					local Iu

					Iu = RunService.RenderStepped:Connect(function()
						if not workspace:IsAncestorOf(Scrap) then
							ItemName.Visible = false
							RarityText.Visible = false
							DistanceText.Visible = false

							Iu:Disconnect()
						else
							local Vector, OnScreen = Cam:WorldToViewportPoint(Scrap:FindFirstChild("MeshPart").Position)

							if OnScreen then
								ItemName.Position = Vector2.new(Vector.X, Vector.Y - 30)
								RarityText.Position = Vector2.new(Vector.X, Vector.Y - 20)
								DistanceText.Position = Vector2.new(Vector.X, Vector.Y - 10)

								ItemName.Visible = false
								RarityText.Visible = false
								DistanceText.Visible = false

								local ItemDistance = math.ceil((Scrap.MeshPart.Position - game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).magnitude)

								if ESPSettings.ScrapESP.Enabled == true then
									if ItemDistance < ESPSettings.ScrapESP.Distance then
										if tostring(Scrap:FindFirstChild("MeshPart"):FindFirstChild("Particle").Color) == "0 0.184314 1 0.4 0 1 0.184314 1 0.4 0 " then
											RarityText.Text = "Rarity: Good"
											RarityText.Color = ESPSettings.ScrapESP.RarityColors.Good

											if ESPSettings.ScrapESP.GoodOnly == true then
												ItemName.Visible = true
												RarityText.Visible = true
												DistanceText.Visible = true
											else
												ItemName.Visible = false
												RarityText.Visible = false
												DistanceText.Visible = false
											end
										elseif tostring(Scrap:FindFirstChild("MeshPart"):FindFirstChild("Particle").Color) == "0 1 0.184314 0.184314 0 1 1 0.184314 0.184314 0 " then
											RarityText.Text = "Rarity: Rare"
											RarityText.Color = ESPSettings.ScrapESP.RarityColors.Rare

											if ESPSettings.ScrapESP.RareOnly == true then
												ItemName.Visible = true
												RarityText.Visible = true
												DistanceText.Visible = true
											else
												ItemName.Visible = false
												RarityText.Visible = false
												DistanceText.Visible = false
											end
										else
											RarityText.Text = "Rarity: Legnedary"
											RarityText.Color = ESPSettings.ScrapESP.RarityColors.Legendary
											if ESPSettings.ScrapESP.LegendaryOnly == true then
												ItemName.Visible = true
												RarityText.Visible = true
												DistanceText.Visible = true
											else
												ItemName.Visible = false
												RarityText.Visible = false
												DistanceText.Visible = false
											end
										end

										DistanceText.Text = "["..tostring(ItemDistance).."]"
									else
										ItemName.Visible = false
										RarityText.Visible = false
										DistanceText.Visible = false
									end
								else
									ItemName.Visible = false
									RarityText.Visible = false
									DistanceText.Visible = false

									Iu:Disconnect()
								end
							else
								ItemName.Visible = false
								RarityText.Visible = false
								DistanceText.Visible = false
							end
						end
					end)
				end
				coroutine.wrap(InfoUpdate)()
			end

			--SafeESP 
			local function SafeESP(Vault, RarityValue)
				local ItemName = Drawing.new("Text")
				ItemName.Visible = false
				ItemName.Center = true
				ItemName.Outline = true
				ItemName.Font = 2
				ItemName.Size = 13
				ItemName.Color = Color3.new(1, 2.5, 2.5)
				ItemName.Text = "Safe"

				local RarityText = Drawing.new("Text")
				RarityText.Visible = false
				RarityText.Center = true
				RarityText.Outline = true
				RarityText.Font = 2
				RarityText.Size = 13
				RarityText.Color = Color3.new(1, 2.5, 2.5)
				RarityText.Text = "Type"

				local StatusText = Drawing.new("Text")
				StatusText.Visible = false
				StatusText.Center = true
				StatusText.Outline = true
				StatusText.Font = 2
				StatusText.Size = 13
				StatusText.Color = Color3.new(1, 2.5, 2.5)
				StatusText.Text = "Status"

				local DistanceText = Drawing.new("Text")
				DistanceText.Visible = false
				DistanceText.Center = true
				DistanceText.Outline = true
				DistanceText.Font = 2
				DistanceText.Size = 13
				DistanceText.Color = Color3.new(1, 2.5, 2.5)
				DistanceText.Text = "Distance"

				local function InfoUpdate()
					local Iu

					Iu = RunService.RenderStepped:Connect(function()
						if not workspace:IsAncestorOf(Vault) then
							ItemName.Visible = false
							RarityText.Visible = false
							StatusText.Visible = false
							DistanceText.Visible = false

							Iu:Disconnect()
						else
							local Vector, OnScreen = Cam:WorldToViewportPoint(Vault:FindFirstChild("MainPart").Position)

							if OnScreen then
								ItemName.Position = Vector2.new(Vector.X, Vector.Y - 30)
								RarityText.Position = Vector2.new(Vector.X, Vector.Y - 20)
								StatusText.Position = Vector2.new(Vector.X, Vector.Y - 0)
								DistanceText.Position = Vector2.new(Vector.X, Vector.Y - 10)

								ItemName.Visible = false
								RarityText.Visible = false
								StatusText.Visible = false
								DistanceText.Visible = false

								local ItemDistance = math.ceil((Vault:FindFirstChild("MainPart").Position - game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).magnitude)

								if ESPSettings.SafeESP.Enabled == true then
									if ItemDistance < ESPSettings.SafeESP.Distance then
										if RarityValue == 2 then
											RarityText.Text = "Rarity: Good"
											RarityText.Color = Color3.new(0, 2.5, 0)

											if ESPSettings.SafeESP.SmallOnly == true then
												ItemName.Visible = true
												RarityText.Visible = true
												StatusText.Visible = true
												DistanceText.Visible = true
											else
												ItemName.Visible = false
												RarityText.Visible = false
												StatusText.Visible = false
												DistanceText.Visible = false
											end
										elseif RarityValue == 3 then
											RarityText.Text = "Rarity: Rare"
											RarityText.Color = Color3.new(1, 0, 0)

											if ESPSettings.SafeESP.BigOnly == true then
												ItemName.Visible = true
												RarityText.Visible = true
												StatusText.Visible = true
												DistanceText.Visible = true
											else
												ItemName.Visible = false
												RarityText.Visible = false
												StatusText.Visible = false
												DistanceText.Visible = false
											end
										end

										DistanceText.Text = "["..tostring(ItemDistance).."]"

										if Vault.Values.Broken.Value == false then
											StatusText.Text = "UnBroken"

											ItemName.Visible = true
											RarityText.Visible = true
											StatusText.Visible = true
											DistanceText.Visible = true

										else
											StatusText.Text = "Broken"

											ItemName.Visible = false
											RarityText.Visible = false
											StatusText.Visible = false
											DistanceText.Visible = false

										end
									else
										ItemName.Visible = false
										RarityText.Visible = false
										StatusText.Visible = false
										DistanceText.Visible = false
									end
								else
									ItemName.Visible = false
									RarityText.Visible = false
									StatusText.Visible = false
									DistanceText.Visible = false

									Iu:Disconnect()
								end
							else
								ItemName.Visible = false
								RarityText.Visible = false
								StatusText.Visible = false
								DistanceText.Visible = false
							end
						end
					end)
				end
				coroutine.wrap(InfoUpdate)()
			end
			

			--  // RegisterESP 
			local function RegisterESP(Register)
				local ItemName = Drawing.new("Text")
				ItemName.Visible = false
				ItemName.Center = true
				ItemName.Outline = true
				ItemName.Font = 2
				ItemName.Size = 13
				ItemName.Color = Color3.new(1, 2.5, 2.5)
				ItemName.Text = "Register"

				local StatusText = Drawing.new("Text")
				StatusText.Visible = false
				StatusText.Center = true
				StatusText.Outline = true
				StatusText.Font = 2
				StatusText.Size = 13
				StatusText.Color = Color3.new(1, 2.5, 2.5)
				StatusText.Text = "Status"

				local DistanceText = Drawing.new("Text")
				DistanceText.Visible = false
				DistanceText.Center = true
				DistanceText.Outline = true
				DistanceText.Font = 2
				DistanceText.Size = 13
				DistanceText.Color = Color3.new(1, 2.5, 2.5)
				DistanceText.Text = "Distance"

				local function InfoUpdate()
					local Iu

					Iu = RunService.RenderStepped:Connect(function()
						if not workspace:IsAncestorOf(Register) then
							ItemName.Visible = false
							StatusText.Visible = false
							DistanceText.Visible = false

							Iu:Disconnect()
						else
							local Vector, OnScreen = Cam:WorldToViewportPoint(Register:FindFirstChild("MainPart").Position)

							if OnScreen then
								ItemName.Position = Vector2.new(Vector.X, Vector.Y - 20)
								StatusText.Position = Vector2.new(Vector.X, Vector.Y - 0)
								DistanceText.Position = Vector2.new(Vector.X, Vector.Y - 10)

								ItemName.Visible = false
								StatusText.Visible = false
								DistanceText.Visible = false

								local ItemDistance = math.ceil((Register:FindFirstChild("MainPart").Position - game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).magnitude)

								if ESPSettings.RegisterESP.Enabled == true then
									if ItemDistance < ESPSettings.RegisterESP.Distance then
										ItemName.Visible = true
										StatusText.Visible = true
										DistanceText.Visible = true

										DistanceText.Text = "["..tostring(ItemDistance).."]"

										if Register.Values.Broken.Value == false then
											StatusText.Text = "UnBroken"

											ItemName.Visible = true
											StatusText.Visible = true
											DistanceText.Visible = true

										else
											StatusText.Text = "Broken"

											ItemName.Visible = false
											StatusText.Visible = false
											DistanceText.Visible = false

										end
									else
										ItemName.Visible = false
										StatusText.Visible = false
										DistanceText.Visible = false
									end
								else
									ItemName.Visible = false
									StatusText.Visible = false
									DistanceText.Visible = false

									Iu:Disconnect()
								end
							else
								ItemName.Visible = false
								StatusText.Visible = false
								DistanceText.Visible = false
							end
						end
					end)
				end
				coroutine.wrap(InfoUpdate)()
			end
--#endregion
			

			--Scrap Added
			game:GetService("Workspace").Filter.SpawnedPiles.ChildAdded:Connect(function(Object)
				if ESPSettings.ScrapESP.Enabled == true then
					coroutine.wrap(ScrapESP)(Object)
				end
			end)
			--Infinite Stamina
			
		local oldStamina
		oldStamina =
			hookfunction(
				getupvalue(getrenv()._G.S_Take, 2),
				function(v1, ...)
					if (Settings.InfiniteStamina) then
					v1 = 0
				end
					return oldStamina(v1, ...)
				end
			)
		-- #endregion
		local StaminaTake = getrenv()._G.S_Take
        local StaminaFunc = getupvalue(StaminaTake, 2) 
        
        for i, v in pairs(getupvalues(StaminaFunc)) do
            if type(v) == "function" and getinfo(v).name == "Upt_S" then
                local OldFunction; 
        
                OldFunction = hookfunction(v, function(...)
                    if Settings.InfiniteStamina == true then
                        local CharacterVar = game:GetService("Players").LocalPlayer.Character
						local CharacterVar2 = game:GetService("Players").LocalPlayer.CharacterAdded:wait()
                        if not CharacterVar or not CharacterVar.Parent then
        
                            getupvalue(StaminaFunc, 6).S = 100
                        elseif CharacterVar2 then
                            getupvalue(StaminaFunc, 6).S = 100
                        end
                    end
        
                    return OldFunction(...)
                end)
            end
        end
			

			--No Jump Cooldown
			local __newindex
			__newindex = hookmetamethod(game, "__newindex", function(t, k, v)
				if (t:IsDescendantOf(Character) and k == "Jump" and v == false) then
					if Settings.NoJumpCooldown == true then
						return
					end
				end

				return __newindex(t, k, v)
			end)
			
-- #region Auto Pickup
coroutine.wrap(function()
	RunService.RenderStepped:Connect(function()
		if Settings.AutoPickScrap == true then
			for i, v in pairs(game:GetService("Workspace").Filter.SpawnedPiles:GetChildren()) do
				if Settings.IsDead == false then
					if (game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position - v:FindFirstChild("MeshPart").Position).Magnitude < 5 then
						if CoolDowns.AutoPickUps.ScrapCooldown == false then
							CoolDowns.AutoPickUps.ScrapCooldown = true
							game:GetService("ReplicatedStorage").Events.PIC_PU:FireServer(string.reverse(v:GetAttribute("zp")))

							wait(1)

							CoolDowns.AutoPickUps.ScrapCooldown = false
						end
					end
				end 
			end
		end
	end)
end)()

coroutine.wrap(function()
	RunService.RenderStepped:Connect(function()
		if Settings.AutoPickTools == true then
			for i, v in pairs(game:GetService("Workspace").Filter.SpawnedTools:GetChildren()) do
				if Settings.IsDead == false then
					if (game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position - v:FindFirstChildWhichIsA("MeshPart").Position).Magnitude < 5 then
						if CoolDowns.AutoPickUps.ToolCooldown == false then
							CoolDowns.AutoPickUps.ToolCooldown = true
							game:GetService("ReplicatedStorage").Events.PIC_TLO:FireServer(v:FindFirstChildWhichIsA("MeshPart"))

							wait(1)

							CoolDowns.AutoPickUps.ToolCooldown = false
						end
					end
				end
			end
		end
	end)
end)()

coroutine.wrap(function()
	RunService.RenderStepped:Connect(function()
		if Settings.AutoPickCash == true then
			for i, v in pairs(game:GetService("Workspace").Filter.SpawnedBread:GetChildren()) do
				if Settings.IsDead == false then
					if (game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position - v.Position).Magnitude < 5 then
						if CoolDowns.AutoPickUps.MoneyCooldown == false then
							CoolDowns.AutoPickUps.MoneyCooldown = true
							game:GetService("ReplicatedStorage").Events.CZDPZUS:FireServer(v)

							wait(1)

							CoolDowns.AutoPickUps.MoneyCooldown = false
						end
					end
				end
			end
		end
	end)
end)()
-- #endregion

			--FlashBang
			game.Workspace.Camera.ChildAdded:Connect(function(Item)
				if Settings.NoFlashbang == true then
					if Item.Name == "BlindEffect" then
						Item.Enabled = false
					end
				end
			end)

			game.Players.LocalPlayer.PlayerGui.ChildAdded:Connect(function(Item)
				if Item.Name == "FlashedGUI" then
					if Settings.NoFlashbang == true then
						Item.Enabled = false
					end
				end
			end)
			

			--Smoke
			game.Workspace.Debris.ChildAdded:Connect(function(Item)
				if Item.Name == "SmokeExplosion" then
					if Settings.NoSmoke == true then
						wait(0.1)
						Item.Particle1:Destroy()
						Item.Particle2:Destroy()
					end
				end
			end)

			game.Players.LocalPlayer.PlayerGui.ChildAdded:Connect(function(Item)
				if Item.Name == "SmokeScreenGUI" then
					if Settings.NoSmoke == true then
						Item.Enabled = false
					end
				end
			end)

			--Pepper Spray Aura
			coroutine.wrap(function()
				RunService.RenderStepped:Connect(function()
					wait(1)
					if Settings.PepperSprayAura == true then
						if Settings.IsDead == false then
							if Player.Character:FindFirstChild("Pepper-spray") then
								for i,v in pairs(Players:GetChildren()) do
									if (game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position - v.Character:FindFirstChild("HumanoidRootPart").Position).Magnitude < 15 then
										Character["Pepper-spray"].RemoteEvent:FireServer("Spray", true)
										Character["Pepper-spray"].RemoteEvent:FireServer("Hit", v.Character)
									else
										Character["Pepper-spray"].RemoteEvent:FireServer("Spray", false)
									end
								end
							end
						end
					end
				end)
			end)()
			

			--No Fail Lockpick
			game.Players.LocalPlayer.PlayerGui.ChildAdded:Connect(function(Item)
				if Settings.NoFailLockpick == true then
					if Item.Name == "LockpickGUI" then
						Item.MF["LP_Frame"].Frames.B1.Bar.UIScale.Scale = 10
						Item.MF["LP_Frame"].Frames.B2.Bar.UIScale.Scale = 10
						Item.MF["LP_Frame"].Frames.B3.Bar.UIScale.Scale = 10
					end
				elseif Settings.NoFailLockpick == false then
					if Item.Name == "LockpickGUI" then
						Item.MF["LP_Frame"].Frames.B1.Bar.UIScale.Scale = 1
						Item.MF["LP_Frame"].Frames.B2.Bar.UIScale.Scale = 1
						Item.MF["LP_Frame"].Frames.B3.Bar.UIScale.Scale = 1
					end
				end
			end)
			

			--Dead Checker
			game.Players.LocalPlayer.CharacterAdded:Connect(function(Character)
				repeat wait() until game.Players.LocalPlayer.Character ~= nil and game.Players.LocalPlayer.Character.Parent ~= nil

				Character = Player.Character
				Settings.IsDead = false

				Character:FindFirstChild("Humanoid").Died:Connect(function()

						if Settings.IsDead == false then
							Settings.IsDead = true 
						end
				end)
			end)

			if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character.Parent then
				Settings.IsDead = false
			end
			

            --Gun Mods
			local function GunModules()
				for i,v in pairs(getgc(true)) do 
					if type(v) == 'table' and rawget(v, 'EquipTime') then 
						if Settings.GunMods.NoRecoil == true then
							coroutine.resume(coroutine.create(function()
								v.Recoil = Settings.GunMods.Values.RecoilAmmount
								v.CameraRecoilingEnabled = false
								v.AngleX_Min = 0 
								v.AngleX_Max = 0 
								v.AngleY_Min = 0
								v.AngleY_Max = 0
								v.AngleZ_Min = 0
								v.AngleZ_Max = 0
							end))
						end
						if Settings.GunMods.Spread == true then
							coroutine.resume(coroutine.create(function()
								v.Spread = Settings.GunMods.Values.SpreadAmmount
							end))
						end
						if Settings.GunMods.InstantEquip == true then
							coroutine.resume(coroutine.create(function()
								v.EquipTime = 0
							end))
						end
						if Settings.GunMods.Removes.EquipAnim == true then
							coroutine.resume(coroutine.create(function()
								v.EquipAnimSpeed = 10000
							end))
						end
						if Settings.GunMods.InstantAim == true then
							coroutine.resume(coroutine.create(function()
								v.AimSettings.AimSpeed = 0
							end))
							coroutine.resume(coroutine.create(function()
								v.SniperSettings.AimSpeed = 0
							end))
						if Settings.GunMods.Removes.AimAnim == true then
							coroutine.resume(coroutine.create(function()
								v.SniperSettings.AimAnimSpeed = 10000
							end))
						end
						end
					end
				end
			end
		
		game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function(Character)
			Character.ChildAdded:Connect(function(Object)
				if Object:IsA("Tool") then
					GunModules()
				end
			end)
		end)
		
		if game:GetService("Players").LocalPlayer.Character ~= nil then
			game:GetService("Players").LocalPlayer.Character.ChildAdded:Connect(function(Object)
				if Object:IsA("Tool") then
					GunModules()
				end
			end)
		end

            coroutine.resume(coroutine.create(function()
				RunService.RenderStepped:Connect(function()
					if SilentSettings.FOVSettings.Visible then 
						SilentAIMFov.Visible = SilentSettings.FOVSettings.Visible
						SilentAIMFov.Color = SilentSettings.SilentAimColor
						SilentAIMFov.Position = GetMousePosition() + Vector2.new(0, 36)
					end
				end)
			end))

			local oldNamecall
			oldNamecall = hookmetamethod(game, "__namecall", function(...)
				local Method = getnamecallmethod()
				local Arguments = {...}
				local self = Arguments[1]
	
				if SilentSettings.Main.Enabled and self == workspace then
					if Method == "Raycast" then
						if ValidateArguments(Arguments, ExpectedArguments.Raycast) then
							local A_Origin = Arguments[2]
	
							local HitPart = GetClosestPlayer()
							if HitPart then
								Arguments[3] = GetDirection(A_Origin, HitPart.Position)
	
								return oldNamecall(unpack(Arguments))
							end
						end
					end
				end
				return oldNamecall(...)
			end)

			-- #region Anti Stuff

		local MT = getrawmetatable(game)
		setreadonly(MT, false)
		local NameCall = MT.__namecall

		MT.__namecall = newcclosure(function(self, ...)
			local Method = getnamecallmethod()
			local Args = {...}

			if Method == "FireServer" and Args[1] == "BHHh" then
				if Settings.NoBarbwire == true then
					return wait(9e9)
				end	
			elseif Method == "FireServer" and Args[1] == "FlllD" or Args[1] == "FlllH" then
				if Settings.NoFallDamage == true then
					return wait(9e9)
				end
			elseif Method == "FireServer" and Args[1] == "__--r" or Args[1] == "HITRGP" then
				if Settings.NoRagdoll == true then
					return wait(9e9)
				end
			elseif Method == "FireServer" and Args[1] == "FllH" then
				if Settings.NoDowned == true then
					return wait(9e9)
				end
			end

			return NameCall(self, ...)
		end)
			

			--Anti Afk
			local VirtualUser = game:GetService("VirtualUser")

			Player.Idled:connect(function()
				VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
				wait(1)
				VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
			end)
			
            --DealerESP
			LibraryESP:AddObjectListener(workspace.Map.Shopz, {
				Name = "Dealer",
				CustomName = "Dealer",
				Color = Color3.fromRGB(197, 253, 255),
				IsEnabled = "DealerESP"
			})

			LibraryESP:AddObjectListener(workspace.Map.Shopz, {
				Name = "ArmoryDealer",
				CustomName = "Armory Dealer",
				Color = Color3.fromRGB(158, 168, 255),
				IsEnabled = "ArmoryDealerESP"
			})
			

			--AtmESP 
			LibraryESP:AddObjectListener(workspace.Map.ATMz, {
				Name = "ATM",
				CustomName = "ATM",
				Color = Color3.fromRGB(197, 255, 120),
				IsEnabled = "AtmESP"
			})


			RunService.RenderStepped:Connect(function()
					
				if Settings.CamFovToggled == true then
					game.Workspace.Camera.FieldOfView = Settings.CamFov
				else
					game.Workspace.Camera.FieldOfView = 70
				end

				if Settings.FullBright == true then
					game:GetService("Lighting").Brightness = 1
					game:GetService("Lighting").ClockTime = 14
					game:GetService("Lighting").FogEnd = 100000
					game:GetService("Lighting").GlobalShadows = false
					game:GetService("Lighting").OutdoorAmbient = Color3.fromRGB(128, 128, 128)
				end

				if Settings.UnlockDoorsNearby == true then
					if Settings.IsDead == false then
						for i, v in pairs(game:GetService("Workspace").Map.Doors:GetChildren()) do
							if (game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position - v:FindFirstChild("DoorBase").Position).Magnitude <= 5 then
								if v:FindFirstChild("Values"):FindFirstChild("Locked").Value == true then
									v:FindFirstChild("Events"):FindFirstChild("Toggle"):FireServer("Unlock", v.Lock)
								end
							end
						end
					end
				end

				if Settings.OpenDoorsNearby == true then
					if Settings.IsDead == false then
						for i, v in pairs(game:GetService("Workspace").Map.Doors:GetChildren()) do
							if (game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position - v:FindFirstChild("DoorBase").Position).Magnitude <= 5 then
								if v:FindFirstChild("Values"):FindFirstChild("Open").Value == false then
									v:FindFirstChild("Events"):FindFirstChild("Toggle"):FireServer("Open", v.Knob2)
								end
							end
						end
					end
				end

				if Settings.IsDead == false then
					if Player.Character:FindFirstChild("Pepper-spray") then
						if Settings.InfinitePepperSpray == true then
							game.Players.LocalPlayer.Character["Pepper-spray"].Ammo.Value = 100
							game.Players.LocalPlayer.Character["Pepper-spray"].RemoteEvent:FireServer("Update", 100)
						end
					end
				end

				if Settings.IsDead == false then
					if Settings.WalkSpeed.Enabled == true then
						Player.Character:FindFirstChild("Humanoid").WalkSpeed = Settings.WalkSpeed.Amount
					end

					if Settings.JumpPower.Enabled == true then
						Player.Character:FindFirstChild("Humanoid").JumpPower = Settings.JumpPower.Amount
					end
				end


				if Player.PlayerGui:FindFirstChild("MouseGUI") then
					Player.PlayerGui:FindFirstChild("MouseGUI").HitmarkerSound.Volume = Settings.VolumeHitsound
					Player.PlayerGui:FindFirstChild("MouseGUI").HeadshotSound.Volume = Settings.VolumeHitsound
				end
			end)
--#region AuraHits

--#region BreakSafe
local function AutoBreakSafe(Safe)
	local HitArgs = {}
	HitArgs[1] = "\240\159\154\168"
	HitArgs[2] = tick()
	HitArgs[3] = Character:FindFirstChild("Crowbar")
	HitArgs[4] = "2389ZFX33"
	HitArgs[5] = GenerateSeed("BreakSafe")
	HitArgs[6] = false
	HitArgs[7] = Character:FindFirstChild("Crowbar"):FindFirstChild("Handle")
	HitArgs[8] = Safe.MainPart
	HitArgs[9] = Safe
	HitArgs[10] = Safe.MainPart.Position
	HitArgs[11] = Safe.MainPart.Position
	for i=1, 4 do
		ReplicatedStorage.Events["XMHH2.1"]:FireServer(unpack(HitArgs))
    end
end
task.spawn(function()
while wait(1) do
	if Settings.AutoBreakSafes then
		pcall(function()
			local ClosesSafe, ValuesFolder = ClosestSafe(5)
				if Character:FindFirstChild("Crowbar") then
					if ValuesFolder.Broken.Value == false then
						if (ClosesSafe.MainPart.Position - Character.HumanoidRootPart.Position).magnitude < 5 then
							AutoBreakSafe(ClosesSafe)
						end
					end
				end
			end)
		end
	end
end)
--#endregion
--#region KillAura
local function KillAura(Target)
	local HitArgs = {}
    HitArgs[1] = "\240\159\154\168"
    HitArgs[2] = tick()
    HitArgs[3] = Character:FindFirstChildOfClass("Tool")
    HitArgs[4] = "2389ZFX33"
    HitArgs[5] = GenerateSeed("Hit")
    HitArgs[6] = false
    HitArgs[7] = Character["Left Arm"]
    HitArgs[8] = Target["Head"]
    HitArgs[9] = Target
    HitArgs[10] = Target["Head"].Position
    HitArgs[11] = Target["Head"].Position
    for i=1, 4 do
		ReplicatedStorage.Events["XMHH2.1"]:FireServer(unpack(HitArgs))
    end
end

task.spawn(function()
    while wait(0.07) do
        if Settings.Killaura then
            pcall(function()
                for _,v in next, Players:GetChildren() do
                    if v.Character and v~=Player then
                        if v.Character:FindFirstChildOfClass("Humanoid") and v.Character:FindFirstChild("HumanoidRootPart") then
                            if v.Character.Humanoid.Health > 4 then
                                if (v.Character.HumanoidRootPart.Position - Character.HumanoidRootPart.Position).magnitude < 20 then
                                    KillAura(v.Character)
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
end)
--#enderegion

--#region TpHit
local function Hit(Target, Part, Debounce, Debounce2)
	local BackTp = Character.HumanoidRootPart.CFrame
	local Seed = GenerateSeed("Hit")
	wait(Debounce)
		Character.HumanoidRootPart.CFrame = Target["HumanoidRootPart"].CFrame + Vector3.new(0,2,0)
		wait(Debounce2)

        for _,v in next, Players:GetChildren() do if v ~= Player and v.Character then if v.Character:FindFirstChildOfClass("Humanoid") then
            if (Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).magnitude < 15 then
		
				local HitArgs = {}
				HitArgs[1] = "\240\159\154\168"
				HitArgs[2] = time
				HitArgs[3] = Character:FindFirstChildOfClass("Tool")
				HitArgs[4] = "2389ZFX33"
				HitArgs[5] = Seed
				HitArgs[6] = false
				HitArgs[7] = Character["Right Arm"]
				HitArgs[8] = v.Character[Part]
				HitArgs[9] = v.Character
				HitArgs[10] = Character["Right Arm"].Position
				HitArgs[11] = v.Character[Part].Position
				ReplicatedStorage.Events["XMHH2.1"]:FireServer(unpack(HitArgs)) ReplicatedStorage.Events["XMHH2.1"]:FireServer(unpack(HitArgs)) 
				ReplicatedStorage.Events["XMHH2.1"]:FireServer(unpack(HitArgs)) ReplicatedStorage.Events["XMHH2.1"]:FireServer(unpack(HitArgs))
			end
		end
	end
end
	Character.HumanoidRootPart.CFrame = BackTp
end

local function Get(String)
    local Found
    local strl = String:lower()

        for i,v in next, Players:GetChildren() do
            if v.Name:lower():sub(1, #String) == String:lower() or v.DisplayName:lower():sub(1, #String) == String:lower() then
                Found = v.Character
            end
		end

    return Found  
end
--#endregion
--#enderegion

local meta, old = getrawmetatable(game), {};
            for i, v in next, meta do old[i] = v end;
            
            local char = '˞';
            
            setreadonly(meta, false);
            
            meta.__namecall = newcclosure(function(...)
                local method = getnamecallmethod();
                local args = {...};
            
                if method == 'FireServer' and args[1].Name == 'SayMessageRequest' and Settings.EZBypass then
                    args[2] = string.gsub(args[2], 'ez', function(c)
                        return char .. c;
                    end);
                    args[2] = string.gsub(args[2], 'Ez', function(c)
                        return char .. c;
                    end);
                    args[2] = string.gsub(args[2], 'eZ', function(c)
                        return char .. c;
                    end);
                    args[2] = string.gsub(args[2], 'EZ', function(c)
                        return char .. c;
                    end);
            
                    return old.__namecall(unpack(args));
                end;
            
                return old.__namecall(...);
            end);
	setreadonly(meta, true);


local SShub = Library:CreateWindow(Name, Vector2.new(492, 600))
CoreGui:FindFirstChild(Name).main.top.title.Text = Name.."|"..GameName.."|"
local General = SShub:CreateTab("General")
local Combat = SShub:CreateTab("Combat")
local Misc = SShub:CreateTab("Misc")
local Visuals = SShub:CreateTab("Visuals")
local Teleports = SShub:CreateTab("Teleports")
local Settingss = SShub:CreateTab("Settings")

local MainL = General:CreateSector("Player", "left")
local MainL2 = General:CreateSector("Anti Stuff", "right")

local MainCo = Combat:CreateSector("SilentAim", "left")
local MainGun = Combat:CreateSector("Mods", "right")
local MainAur = Combat:CreateSector("Stuff", "right")

local MainMs = Misc:CreateSector("Misc", "left")
local MainAu = Misc:CreateSector("Auto Farms", "right")

local MainP = Visuals:CreateSector("Player ESP", "left")
local MainScrap = Visuals:CreateSector("Scrap ESP", "right")
local MainSafes = Visuals:CreateSector("Safes ESP", "right")
local MainRegister = Visuals:CreateSector("Register ESP", "right")
local MainTStock = Visuals:CreateSector("Stock ESP", "left")

local MainTele = Teleports:CreateSector("Teleports", "right")
local MainT = Teleports:CreateSector("Teleports", "left")
local MainT1 = Teleports:CreateSector("Closests Teleportation", "left")

local MainC = Settingss:CreateSector("Credits", "left")
local MainUI = Settingss:CreateSector("UI", "left")
Settingss:CreateConfigSystem("right")

local InfStamina = MainL:AddToggle("Infinite Stamina", Settings.InfiniteStamina, function(V)
	Settings.InfiniteStamina = V
end, "InfiniteStamina")
InfStamina:AddKeybind("None", "InfiniteStamina Keybind")

MainL:AddToggle("No Jump Cooldown", Settings.NoJumpCooldown, function(V)
	Settings.NoJumpCooldown = V
end,"NoJumpCooldown")

MainL:AddToggle("Infinite Jump", Settings.SpaceJump, function(V)
	Settings.SpaceJump = V

	game:GetService("UserInputService").JumpRequest:connect(function()
		if Settings.SpaceJump == true then
			game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
		end
	end)
end,"InfiniteJump")

MainL:AddToggle("Full Brightness", Settings.FullBright, function(V)
	Settings.FullBright = V
end, "FullBright")

local LockPickNofail = MainL:AddToggle("No Fail Lockpick", Settings.NoFailLockpick, function(V)
	Settings.NoFailLockpick = V
end,"NoFailLockPick")
LockPickNofail:AddKeybind("None", "NoFailLockPick Keybind")

MainL:AddToggle("No Flash", Settings.NoFlashbang, function(V)
	Settings.NoFlashbang = V
end,"NoFlash")

MainL:AddToggle("No Smoke", Settings.NoSmoke, function(V)
	Settings.NoSmoke = V
end,"NoSmoke")

MainL:AddSlider("Camera Max Zoom", 10, Settings.Zoom, 3000, 10, function(V)
	Player.CameraMaxZoomDistance = V
end,"CameraZoom")

local AntiDowned = MainL2:AddToggle("Anti Downed", false, function(V)
	Settings.NoDowned = V
end, "AntiDowned")
AntiDowned:AddKeybind("None", "AntiDowned Keybind")

local AntiStomp = MainL2:AddToggle("Anti Stomp", false, function(V)
	Settings.AntiStomp = V
	local Downed = ReplicatedStorage.CharStats[game:GetService("Players").LocalPlayer.Name].Downed
	Downed.Changed:Connect(function()
		if Downed.Value == true and Settings.AntiStomp == true then
			for i, v in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
				if v:IsA("BasePart") then
					v:Destroy()
				end
			end
		end
	end)
end, "AntiStomp")

AntiStomp:AddKeybind("None", "AntiStomp Keybind")

local DisableBarbwire = MainL2:AddToggle("Disable Barbwire", Settings.NoBarbwire, function(V)
	Settings.NoBarbwire = V
end, "DisableBarbwire")
DisableBarbwire:AddKeybind("None", "DisableBarbwire Keybind")
local DisableFall = MainL2:AddToggle("Disable Fall Damage", Settings.NoFallDamage, function(V)
	Settings.NoFallDamage = V
end, "DisableFall")
DisableFall:AddKeybind("None", "DisableFall Keybind")
local DisableRagdoll = MainL2:AddToggle("Disable Ragdoll", Settings.NoRagdoll, function(V)
	Settings.NoRagdoll = V
end, "DisableRagdoll")
DisableRagdoll:AddKeybind("None", "DisableRagdoll Keybind")

MainL:AddSeperator("Player Mods")
local FovToggle = MainL:AddToggle("Fov", Settings.CamFovToggled, function(V)
	Settings.CamFovToggled = V
end, "FieldOfView")

FovToggle:AddKeybind("None", "FieldOfView Keybind")

MainL:AddSlider("Field Of View", 70, Settings.CamFov, 120, 10, function(V)
	Settings.CamFov = V
end,"FieldOfViewSlider")

local WalkSpeedToggle = MainL:AddToggle("WalkSpeed Toggler", Settings.WalkSpeed.Enabled, function(V)
	Settings.WalkSpeed.Enabled = V
end, "WalkSpeed")

WalkSpeedToggle:AddKeybind("None", "WalkSpeed Keybind")

local JumpPowerToggle = MainL:AddToggle("JumpPower Toggler", Settings.JumpPower.Enabled, function(V)
	Settings.JumpPower.Enabled = V
end, "JumpPower")

JumpPowerToggle:AddKeybind("None", "JumpPower Keybind")

MainL:AddSlider("WalkSpeed", 16, Settings.WalkSpeed.Amount, 100, 10, function(V)
	Settings.WalkSpeed.Amount = V
end,"WalkSpeedAmmountSlider")

MainL:AddSlider("JumpPower", 30, Settings.JumpPower.Amount, 150, 10, function(V)
	Settings.JumpPower.Amount = V
end,"JumpPowerAmmountSlider")

local AutoScrap = MainAu:AddToggle("Auto Pick Scrap", Settings.AutoPickScrap, function(V)
	Settings.AutoPickScrap = V
end, "AutoPickScrap")
AutoScrap:AddKeybind("None", "AutoPickScrap Keybind")

local AutoTools = MainAu:AddToggle("Auto Pick Tools", Settings.AutoPickTools, function(V)
	Settings.AutoPickTools = V
end, "AutoPickTools")
AutoTools:AddKeybind("None", "AutoPickTools Keybind")

local AutoCash = MainAu:AddToggle("Auto Pick Cash", Settings.AutoPickCash, function(V)
	Settings.AutoPickCash = V
end, "AutoPickCash")
AutoCash:AddKeybind("None", "AutoPickCash Keybind")

local AutoSafes = MainAu:AddToggle("Auto Break Safes", Settings.AutoBreakSafes, function(V)
	Settings.AutoBreakSafes = V
end, "AutoBreakSafes")
AutoSafes:AddKeybind("None", "AutoBreakSafes Keybind")

MainMs:AddToggle("Chat Logs", Settings.ShowChatLogs, function(V)
	Settings.ShowChatLogs = V

	if V == true then
		local ChatFrame = game.Players.LocalPlayer.PlayerGui.Chat.Frame
		ChatFrame.ChatChannelParentFrame.Visible = true
		ChatFrame.ChatBarParentFrame.Position = ChatFrame.ChatChannelParentFrame.Position + UDim2.new(UDim.new(), ChatFrame.ChatChannelParentFrame.Size.Y)
	elseif V == false then
		local ChatFrame = game.Players.LocalPlayer.PlayerGui.Chat.Frame
		ChatFrame.ChatChannelParentFrame.Visible = false
		ChatFrame.ChatBarParentFrame.Position = ChatFrame.ChatChannelParentFrame.Position + UDim2.new(0, 0, 0, 0)
	end
end,"ChatLogs")
MainMs:AddToggle("Ez Bypass", Settings.EZBypass, function(V)
	Settings.EZBypass = V
end,"EzByPass")
MainMs:AddSeperator("Doors")
MainMs:AddToggle("Unlock Nearby Doors", Settings.UnlockDoorsNearby, function(V)
	Settings.UnlockDoorsNearby = V
end,"UnlockNearbyDoors")

MainMs:AddToggle("Open Nearby Doors", Settings.OpenDoorsNearby, function(V)
	Settings.OpenDoorsNearby = V
end,"OpenNearbyDoors")

MainMs:AddToggle("NoClip Doors", Settings.NoClipD, function(V)
	Settings.NoClipD = V

	if Settings.NoClipD == true then
		for _, v in pairs(game:GetService("Workspace").Map.Doors:GetChildren()) do
			if v:FindFirstChild("DoorBase") then
				v.DoorBase.CanCollide = false
			end
			if v:FindFirstChild("DoorA") then
				v.DoorA.CanCollide = false
			end
			if v:FindFirstChild("DoorB") then
				v.DoorB.CanCollide = false
			end
			if v:FindFirstChild("DoorC") then
				v.DoorC.CanCollide = false
			end
			if v:FindFirstChild("DoorD") then
				v.DoorD.CanCollide = false
			end
		end
	else
		for _, v in pairs(game:GetService("Workspace").Map.Doors:GetChildren()) do
			if v:FindFirstChild("DoorBase") then
				v.DoorBase.CanCollide = true
			end
			if v:FindFirstChild("DoorA") then
				v.DoorA.CanCollide = true
			end
			if v:FindFirstChild("DoorB") then
				v.DoorB.CanCollide = true
			end
			if v:FindFirstChild("DoorC") then
				v.DoorC.CanCollide = true
			end
			if v:FindFirstChild("DoorD") then
				v.DoorD.CanCollide = true
			end
		end
	end
end,"DoorNoClip")

MainGun:AddToggle("No Recoil", Settings.GunMods.NoRecoil, function(V)
	Settings.GunMods.NoRecoil = V
end,"NoRecoil")

MainGun:AddSlider("Recoil Ammount", 0, Settings.GunMods.Values.RecoilAmmount, 50, 10, function(V)
	Settings.GunMods.Values.RecoilAmmount = V
end,"RecoilAmmountSlider")

MainGun:AddToggle("No Spread", Settings.GunMods.Spread, function(V)
	Settings.GunMods.Spread = V
end,"NoSpread")

MainGun:AddSlider("Spread Ammount", 0, Settings.GunMods.Values.SpreadAmmount, 50, 10, function(V)
	Settings.GunMods.Values.SpreadAmmount = V
end,"SpreadAmmountSlider")

MainGun:AddToggle("Instant Equip", Settings.GunMods.InstantEquip, function(V)
	Settings.GunMods.InstantEquip = V
end,"InstantEquip")

MainGun:AddToggle("Remove Equip Animation", Settings.GunMods.InstantEquip, function(V)
	Settings.GunMods.Removes.EquipAnim = V
end,"RemoveEquiAnimation")

MainGun:AddToggle("Instant Aim", Settings.GunMods.InstantAim, function(V)
	Settings.GunMods.InstantAim = V
end,"InstantAim")

MainGun:AddToggle("Remove Aim Ainimation", Settings.GunMods.InstantEquip, function(V)
	Settings.GunMods.Removes.AimAnim = V
end,"RemoveAimAnimation")

MainGun:AddSeperator("xd")
MainGun:AddToggle("Wall Bang", Settings.WallBang, function(V)
	Settings.WallBang = V
	if V == true then
		game:service[[Workspace]]:FindFirstChild('Map'):FindFirstChild('Parts'):FindFirstChild('M_Parts').Parent = game:service[[Workspace]]:FindFirstChild('Characters')
	elseif V == false then
		game:service[[Workspace]]:FindFirstChild('Characters'):FindFirstChild('M_Parts').Parent = game:service[[Workspace]]:FindFirstChild('Map'):FindFirstChild('Parts')
	end
end,"WallBang")

MainGun:AddButton("Melee God Mode", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Tobias020108Back/YBA-AUT/main/Criminality-Semi-Godmode.lua", true))()
end)

MainGun:AddSeperator("Pepper Spray")
MainGun:AddToggle("Infinite Pepper Spray", Settings.InfinitePepperSpray, function(V)
	Settings.InfinitePepperSpray = V
end,"InfinitePepperSpray")

MainGun:AddToggle("Pepper Spray Aura", Settings.PepperSprayAura, function(V)
	Settings.PepperSprayAura = V
end,"PepperSprayAura")
--Silent Aim
local SilentToggle = MainCo:AddToggle("Silent Aim", SilentSettings.Main.Enabled, function(V)
	SilentSettings.Main.Enabled = V
end, "SilentAimToggle")

SilentToggle:AddKeybind("None", "SilentAimToggle Keybind")

local VisibleCheck = MainCo:AddToggle("Visible Check", false, function(V)
	 SilentSettings.Main.VisibleCheck = V
end, "VisibleCheck")
VisibleCheck:AddKeybind("None", "VisibleCheck Keybind")
MainCo:AddDropdown("Hit Part", {"Head", "Torso", "Random"}, "Head", false, function(V)
	SilentSettings.Main.TargetPart = V
end,"HitPartSilentAim")

MainCo:AddSeperator("Fov Settings")

local SilentAimToggle = MainCo:AddToggle("Silent Aim Fov", SilentSettings.FOVSettings.Visible, function(V)
	SilentSettings.FOVSettings.Visible = V
	SilentAIMFov.Visible = V
end, "SilentAimFov")

SilentAimToggle:AddKeybind("None", "SilentAimFov Keybind")

MainCo:AddSlider("Radius", 5, SilentSettings.FOVSettings.Radius, 1080, 10, function(V)
	SilentSettings.FOVSettings.Radius = V
	SilentAIMFov.Radius = V
end,"RadiusSilentAim")

local KillAuraT = MainAur:AddToggle("KillAura", Settings.Killaura, function(V)
	Settings.Killaura = V
end, "KillAura")

KillAuraT:AddKeybind("None", "KillAura Keybind")

MainAur:AddSeperator("Tp Hit")

MainAur:AddTextbox("Player", false, function(V)
	Settings.TpHit.Name = V
	Notify(NS.Title,NS.Icon,"Tp Hit", "Current Player is: "..Settings.TpHit.Name,5)
end,"TpHitPlayer")

MainAur:AddDropdown("Weapon", {"Fists", "FireAxe", "Chainsaw", "Bat"}, Settings.TpHit.Weapon, false, function(V)
	Settings.TpHit.Weapon = V
end,"TpHitDropDownWep")

MainAur:AddDropdown("Hit Part", {"Head", "Torso"}, Settings.TpHit.HitPart, false, function(V)
	Settings.TpHit.HitPart = V
end,"TpHitDropDownPart")

MainAur:AddButton("Tp Hit", function()
local Target = Get(Settings.TpHit.Name)
	if Settings.TpHit.Weapon == "Fists" then
		Hit(Target, Settings.TpHit.HitPart, Settings.TpHit.Configs.Fists, Settings.TpHit.Configs.Fists[2])
	elseif Settings.TpHit.Weapon == "FireAxe" then
		Hit(Target, Settings.TpHit.HitPart, Settings.TpHit.Configs.FireAxe, Settings.TpHit.Configs.FireAxe[2])
	elseif Settings.TpHit.Weapon == "Chainsaw" then
		Hit(Target, Settings.TpHit.HitPart, Settings.TpHit.Configs.Chainsaw, Settings.TpHit.Configs.Chainsaw[2])
	elseif Settings.TpHit.Weapon == "Bat" then
		Hit(Target, Settings.TpHit.HitPart, Settings.TpHit.Configs.Bat, Settings.TpHit.Configs.Bat[2])
	end
end)

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

MainP:AddSlider("ESP Distance", 0, ESPSettings.PlayerESP.Distance, 2000, 10, function(V)
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

MainP:AddSeperator("Dealer")

MainP:AddToggle("Illegal Dealer", false, function(V)
	LibraryESP.DealerESP = V
end,"IllegalDealerESP")

MainP:AddToggle("Armory Dealer", false, function(V)
	LibraryESP.ArmoryDealerESP = V
end,"ArmoryDealerESP")

MainP:AddToggle("ATM ESP", false, function(V)
	LibraryESP.AtmESP = V
end,"ATMESP")


--Scrap Visuals
local ScrapESPToggle = MainScrap:AddToggle("Scrap ESP", ESPSettings.ScrapESP.Enabled, function(V)
	ESPSettings.ScrapESP.Enabled = V

	if V == true then
		for i, v in pairs(game:GetService("Workspace").Filter.SpawnedPiles:GetChildren()) do
			coroutine.wrap(ScrapESP)(v)
		end
	end
end, "ScrapESPToggle")
ScrapESPToggle:AddKeybind("None", "ScrapESPToggle Keybind")
MainScrap:AddSeperator("Rarity")

local BadScrapColor = MainScrap:AddToggle("Bad Only", ESPSettings.ScrapESP.BadOnly, function(V)
	ESPSettings.ScrapESP.BadOnly = V
end,"BadOnly")

BadScrapColor:AddColorpicker(ESPSettings.ScrapESP.RarityColors.Bad, function(V)
	ESPSettings.ScrapESP.RarityColors.Bad = V
end,"BadScrapColor")

-- MainScrap:AddSeperator("Distance")

MainScrap:AddSlider("Scrap Distance", 0, ESPSettings.ScrapESP.Distance, 2000, 10, function(V)
	ESPSettings.ScrapESP.Distance = V
end,"ScrapDistance")


--Safe Visuals
local SafeESPToggle = MainSafes:AddToggle("Safe ESP", ESPSettings.SafeESP.Enabled, function(V)
	ESPSettings.SafeESP.Enabled = V

	if V == true then
		for i, v in pairs(game:GetService("Workspace").Map.BredMakurz:GetChildren()) do
			if tonumber(v:FindFirstChild("Type").Value) == 2 then
				coroutine.wrap(SafeESP)(v, 2)
			elseif tonumber(v:FindFirstChild("Type").Value) == 3 then
				coroutine.wrap(SafeESP)(v, 3)
			end
		end
	end
end, "SafeESPToggle")

SafeESPToggle:AddKeybind("None", "SafeESPToggle Keybind")

MainSafes:AddSeperator("Rarity")

MainSafes:AddToggle("Big Only", ESPSettings.SafeESP.BigOnly, function(V)
	ESPSettings.SafeESP.BigOnly = V
end,"BigOnly")

MainSafes:AddToggle("Small Only", ESPSettings.SafeESP.SmallOnly, function(V)
	ESPSettings.SafeESP.SmallOnly = V
end,"SmallOnly")

MainSafes:AddSeperator("Distance")

MainSafes:AddSlider("Safe Distance", 0, ESPSettings.SafeESP.Distance, 2000, 10, function(V)
	ESPSettings.SafeESP.Distance = V
end,"SafeDistance")


--Register Visuals
local RegisterESPToggle = MainRegister:AddToggle("Register ESP", ESPSettings.RegisterESP.Enabled, function(V)
	ESPSettings.RegisterESP.Enabled = V

	if V == true then
		for i, v in pairs(game:GetService("Workspace").Map.BredMakurz:GetChildren()) do
			if tonumber(v:FindFirstChild("Type").Value) == 1 then
				coroutine.wrap(RegisterESP)(v)
			end
		end
	end
end, "RegisterESPToggle")
RegisterESPToggle:AddKeybind("None", "RegisterESPToggle Keybind")
MainRegister:AddSeperator("Distance")

MainRegister:AddSlider("Register Distance", 0, ESPSettings.RegisterESP.Distance, 2000, 10, function(V)
	ESPSettings.RegisterESP.Distance = V
end,"RegisterDistance")

--#region Teleports
local Teleports = {
    Start = tick(),
    Cooldown = false,
    Time = 5,
    Time_To_Wait = 0
}
local function Teleport(Pos)
    if Character.HumanoidRootPart and not Teleports.Cooldown then
        Character.HumanoidRootPart.CFrame = CFrame.new(0,-9e9, 0)
        wait(1.1)
        Character.HumanoidRootPart.CFrame = Pos
        Teleports.Cooldown = true
        wait(Teleports.Time)
        Teleports.Cooldown = false
    end
end
local TeleportLocation = "Tower"

MainT:AddDropdown("Location", {"Tower","Illegal Pizza","?","Vibe-Check","Subway","Cafe-Locker","HideOut","Thrift Store","Gas Station","Factory","WareHouse","JunkYard"}, TeleportLocation, false, function(V)
	TeleportLocation = V
end,"TeleportsDropDown")
MainT:AddButton("Teleport", function()
if TeleportLocation == "Tower" then
	Teleport(CFrame.new(-4506.96337890625, 105.5683822631836, -820.3717651367188))
elseif TeleportLocation == "Illegal Pizza" then
	Teleport(CFrame.new(-4421.701171875, 5.200174808502197, -137.64849853515625))
elseif TeleportLocation == "?" then
	Teleport(CFrame.new(-4288.22802734375, -94.16966247558594, -814.4773559570312))
elseif TeleportLocation == "Vibe-Check" then
	Teleport(CFrame.new(-4776.74072265625, -201.26571655273438, -935.8676147460938))
elseif TeleportLocation == "Subway" then
	Teleport(CFrame.new(-4707.42041015625, -32.30079650878906, -699.1838989257812))
elseif TeleportLocation == "Cafe-Locker" then
	Teleport(CFrame.new(-4670.06103515625, 6.000002861022949, -257.1016845703125))
elseif TeleportLocation == "HideOut" then
	Teleport(CFrame.new(-4696.15087890625, 16.973363876342773, -948.1644897460938))
elseif TeleportLocation == "Thrift Store" then
	Teleport(CFrame.new(-4660.08056640625, 4.101564407348633, -152.4844512939453))
elseif TeleportLocation == "Gas Station" then
	Teleport(CFrame.new(-4431.490234375, 4.027345657348633, 193.07431030273438))
elseif TeleportLocation == "Factory" then
	Teleport(CFrame.new(-4410.919921875, 5.599993705749512, -554.301025390625))
elseif TeleportLocation == "WareHouse" then
	Teleport(CFrame.new(-4628.36962890625, 6.699222087860107, -562.562744140625))
elseif TeleportLocation == "JunkYard" then
	Teleport(CFrame.new(-3838.040771484375, 3.900392532348633, -507.172119140625))
end
end)
MainT:AddButton("Fix Air Stuck", function()
	ReplicatedStorage.Events.__DFfDD:FireServer("__--r", Vector3.new(0,0,0), CFrame.new(0,0,0))
end)
MainT1:AddButton("Safe (50 Stunds)", function()
local Object = ClosestSafe(50)
	if Object.MainPart then
		Teleport(Object.MainPart.CFrame * CFrame.new(0,2,-2))
	end
end)
MainT1:AddButton("Scrap", function()
local Object = ClosestScrap()
	if Object.MeshPart then
		Teleport(Object.MeshPart.CFrame * CFrame.new(0,2,0))
	end
end)
MainT1:AddButton("Dealer", function()
local Object = ClosestDealer()
	if Object.MainPart then
		Teleport(Object.MainPart.CFrame * CFrame.new(0,2,-2))
	end
end)
--[[
local Example:AddKeybind("None", "flag")

MainExample:AddToggle("WW", Toggle, function(V)

end, "flag")

MainExample:AddSlider("WW", 0, Default, Max, 10, function(V)

end,"flag")

MainExample:AddColorpicker(Default, function(V)

end,"flag")

MainExample:AddDropdown("WW", {"Items"}, "Default", MultiChoice, function(V)

end,"flag")

MainExample:AddButton("WW", function()
	
end)
]]
sstockk = "Crowbar"
RunService.Stepped:Connect(function()
for i, Dealer in pairs(Workspace.Map.Shopz:GetChildren()) do 
	if Dealer:FindFirstChild("Type").Value == "IllegalStore" then
		local Value = Dealer:FindFirstChild("CurrentStocks"):FindFirstChild(sstockk).Value
		local oldValue = Value
			if oldValue ~= Value then
				if Dealer:FindFirstChild("CurrentStocks"):FindFirstChild(sstockk).Value == 0 then
				elseif Dealer:FindFirstChild("CurrentStocks"):FindFirstChild(sstockk).Value >= 1 then
					coroutine.wrap(DealerSESP)(Dealer, sstockk)
				end
				oldValue = Value
			end
		end
	end
end)

local Stock2 = MainTStock:AddLabel("")
local Stock1 = MainTStock:AddLabel("")
MainTStock:AddDropdown("Select Stock", {"SlayerArmour","SlayerSword","__NecromancerKit","CursedDagger","PumpkinHelmet","TheCure","Hammer","Coal","Knuckledusters","Nunchucks","Crowbar","Golfclub","Taiga","Shovel","Rambo","Bat ","Katana","Metal-Bat", "Shiv","Fire-Axe","Bayonet","Chainsaw","Balisong","Uzi","Tommy","MAC-10","G-17","Deagle","M1911","RPG-7","SKS","Mare","AKS-74U","TEC-9","Beretta","Itchaca-37","AKM","BackpackA_1","VestA_3","VestA_2","VestA_1","HelmetA_2","HelmetA_1","BodyFlashlight_1","Smoke-Grenade","C4","Stun-Grenade","Flashbang","Antidote","Rage-potion","Medkit","Bandage","Splint","Lockpick"}, sstockk, false, function(V)
	sstockk = V
	for i, Dealer in pairs(Workspace.Map.Shopz:GetChildren()) do 
		if Dealer:FindFirstChild("Type").Value == "IllegalStore" then
			if Dealer:FindFirstChild("CurrentStocks"):FindFirstChild(sstockk).Value == 0 then
			elseif Dealer:FindFirstChild("CurrentStocks"):FindFirstChild(sstockk).Value >= 1 then
				coroutine.wrap(DealerSESP)(Dealer, sstockk)
			end
		end
	end
end,"StockTable")
if stocked == true then
	Notify(NS.Title,NS.Icon,sstockk.." On Stock!",5)
end
RunService.Stepped:Connect(function()
	Stock2:Refresh("Re-Stock: "..game:GetService("Workspace").Map.Shopz.Dealer.RestockTime.Value)
		for i, Dealer in pairs(Workspace.Map.Shopz:GetChildren()) do 
			if Dealer:FindFirstChild("Type").Value == "IllegalStore" then
				if Dealer:FindFirstChild("CurrentStocks"):FindFirstChild(sstockk).Value == 0 then
					Stock1:Refresh("Not Stocked")
					stocked = false
				elseif Dealer:FindFirstChild("CurrentStocks"):FindFirstChild(sstockk).Value >= 1 then
					Stock1:Refresh("Stocked!")
					stocked = true
				end
			end
		end
	end)

local ESPDS = MainTStock:AddToggle("ESP Dealer Stocked", ESPSettings.DealerSESP.Enabled, function(V)
	ESPSettings.DealerSESP.Enabled = V
	for i, Dealer in pairs(Workspace.Map.Shopz:GetChildren()) do 
		if Dealer:FindFirstChild("Type").Value == "IllegalStore" then
			if Dealer:FindFirstChild("CurrentStocks"):FindFirstChild(sstockk).Value == 0 then
			elseif Dealer:FindFirstChild("CurrentStocks"):FindFirstChild(sstockk).Value >= 1 then
				coroutine.wrap(DealerSESP)(Dealer, sstockk)
			end
		end
	end
end, "ESPDealerStock")
ESPDS:AddKeybind("None", "ESPDealerStock1")
--#endregion
local function TeleportAreaNew(Cframe)
	local User = game.Players.LocalPlayer.Character.HumanoidRootPart
	User.CFrame = Cframe
end

local db = false
local db1 = false
local db2 = false
local db3 = false

local function PartThin(p)
	p.Anchored = true
	p.Size = Vector3.new(2, 10, 2)
	p.Material = Enum.Material.ForceField
	p.Color = Color3.fromRGB(255, 255, 255)
	p.CanCollide = false
	p.Transparency = 1
end

local part = Instance.new("Part", workspace)
PartThin(part)
part.Position = Vector3.new(-4766.666, -32.768, -818.809)

local part1 = Instance.new("Part", workspace)
PartThin(part1)
part1.Position = Vector3.new(-4770.976, -198.929, -842.684)

local tow = Instance.new("Part", workspace)
PartThin(tow)
tow.Position = Vector3.new(-4525.734, 9.314, -778.03)

local tow1 = Instance.new("Part", workspace)
PartThin(tow1)
tow1.Position = Vector3.new(-4525.795, 85.759, -778.03)

part.Touched:Connect(function()
	if Player and Settings.ElevatorTP then
		if not db and not db1 then
			db = true
			TeleportAreaNew(CFrame.new(-4770.976, -198.929, -842.684))
			wait(1)
			db = false
		end
	end
end)

part1.Touched:Connect(function()
	if Player and Settings.ElevatorTP then
		if not db1 and not db then
			db1 = true
			TeleportAreaNew(CFrame.new(-4766.666, -32.768, -818.809))
			wait(1)
			db1 = false
		end
	end
end)

tow.Touched:Connect(function()
	if Player and Settings.TowerTP then
		if not db2 and not db3 then
			db2 = true
			TeleportAreaNew(CFrame.new(-4525.795, 85.759, -778.03))
			wait(1)
			db2 = false
		end
	end
end)

tow1.Touched:Connect(function()
	if Player and Settings.TowerTP then
		if not db3 and not db2 then
			db3 = true
			TeleportAreaNew(CFrame.new(-4525.734, 9.314, -778.03))
			wait(1)
			db3 = false
		end
	end
end)

MainTele:AddToggle("Elevator", Settings.ElevatorTP, function(V)
	Settings.ElevatorTP = V

	if Settings.ElevatorTP == true then
		part.Transparency = 0
		part1.Transparency = 0
	else
		part.Transparency = 1
		part1.Transparency = 1
	end
end)

MainTele:AddToggle("Tower", Settings.TowerTP, function(V)
	Settings.TowerTP = V

	if Settings.TowerTP == true then
		tow.Transparency = 0
		tow1.Transparency = 0
	else
		tow.Transparency = 1
		tow1.Transparency = 1
	end
end)

MainTele:AddSeperator("Quick Elevator")

MainTele:AddButton("Elevator Up", function()
	TeleportAreaNew(CFrame.new(-4768.198, -34.303, -817.605))
end)

MainTele:AddButton("Elevator Down", function()
	TeleportAreaNew(CFrame.new(-4776.88, -201.662, -823.827))
end)

MainTele:AddSeperator("Quick Tower")

MainTele:AddButton("Tower Up", function()
	TeleportAreaNew(CFrame.new(-4519.51, 85.714, -773.943))
end)
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
RunService.Stepped:Connect(function()
	UpdateChar()
	LibraryESP.Colors.BoxColor = ESPSettings.PlayerESP.Colors.BoxColor
	LibraryESP.Colors.NameColor = ESPSettings.PlayerESP.Colors.NameColor
	LibraryESP.Colors.DistanceColor = ESPSettings.PlayerESP.Colors.DistanceColor
	LibraryESP.Colors.HealthColor = ESPSettings.PlayerESP.Colors.HealthColor
	LibraryESP.Colors.ToolColor = ESPSettings.PlayerESP.Colors.ToolColor 
	LibraryESP.Colors.TracerColor = ESPSettings.PlayerESP.Colors.TracerColor
end)
end)

if Success then
print("[2/2] Load Success")
end

if Error then
	Notify(NS.Title,NS.Icon,"Error, Copied to clipboard")
	print("[Error] Copied to clipboard")
	setclipboard(tostring(Error))
end
