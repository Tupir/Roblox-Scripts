local Name = "SSHub"
--#region Notify
local NS = {
	Title = "SSHub",
	Icon = "rbxassetid://8426126371"
}
local function Notify(Title, Icon, Text, Duration)
	game.StarterGui:SetCore("SendNotification", {Title = Title or ""; Text = Text or ""; Icon = Icon or ""; Duration = tonumber(Duration) or 3 })
end
--#endregion
local Settings = {
    IsDead = false,
    WaterMark = false,
};

local Esp = {
    Enabled = false,
    Name = false,
    Health = false,
    Team = false,
    Tool = false,
    Backpack = false,
    Tracers = false,
    Distance = false,
    Boxes = false,
    TeamCheck = false,
    MaxDistance = 2000,
    Colors = {
        Name = Color3.fromRGB(255,255,255),
        Health = Color3.fromRGB(255,255,255),
        Team = Color3.fromRGB(255,255,255),
        Tool = Color3.fromRGB(255,255,255),
        Backpack = Color3.fromRGB(255,255,255),
        Tracers = Color3.fromRGB(255,255,255),
        Distance = Color3.fromRGB(255,255,255),
        Boxes = Color3.fromRGB(255,255,255),
        TeamCheck = {Color3.fromRGB(255,0,0), Color3.fromRGB(0,255,0)}
    }
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
	} 
};
local function toHMS(s)
	return string.format("%02i:%02i:%02i", s/60^2, s/60%60, s%60)
end

local Success, Error = pcall(function()
    --#region Libs
    local Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/wally-rblx/LinoriaLib/main/Library.lua'))()
    local PlayerEsp = loadstring(game:HttpGet("https://raw.githubusercontent.com/miguel831/Roblox-Scripts/main/SSHub/Lib/PlayerEsp.lua"))()
    local SaveManager = loadstring(game:HttpGet('https://raw.githubusercontent.com/miguel831/Roblox-Scripts/main/SSHub/Lib/addons/SaveManager.lua'))()
    local Module = loadstring(game:HttpGet"https://raw.githubusercontent.com/miguel831/Roblox-Scripts/main/SSHub/ServerHop")()
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
    local VirtualUser = game:GetService("VirtualUser")
    local Uis = GetService(game, "UserInputService");
    local Plr = Players.LocalPlayer
    local Teams = game:GetService("Teams")
    local Character = Plr.Character or Plr.CharacterAdded:Wait();
    local Cam = Workspace.CurrentCamera;
    local Mouse = Plr:GetMouse()
    local HttpService = game:GetService("HttpService")
    local GameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
    --#endregion
    Plr.Idled:Connect(function()
        VirtualUser:Button2Down(Vector2.new(0,0),Cam.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0,0),Cam.CFrame)
    end)

    local SilentSettings = {
        Main = {
            Enabled = false,
            TeamCheck = false,
            VisibleCheck = false,
            Methods = {},
            TargetPart = "Head"
        },
        Fov = {
            Enabled = false,
            Radius = 360,
            Color = Color3.fromRGB(255, 255, 255)
        }
    }

    --Silent Aim Functions

    local function GetMousePosition()
        return Vector2.new(Mouse.X, Mouse.Y)
    end

    local SilentFov = Drawing.new("Circle")
    SilentFov.Thickness = 1
    SilentFov.NumSides = 100
    SilentFov.Radius = SilentSettings.Fov.Radius
    SilentFov.Filled = false
    SilentFov.Visible = false
    SilentFov.ZIndex = 999
    SilentFov.Transparency = 1
    SilentFov.Color = SilentSettings.Fov.Color

    coroutine.wrap(function()
        RunService.RenderStepped:Connect(function()
            if SilentSettings.Fov.Enabled then
                SilentFov.Visible = true
                SilentFov.Color = SilentSettings.Fov.Color
                SilentFov.Radius = SilentSettings.Fov.Radius
                SilentFov.Position = GetMousePosition() + Vector2.new(0, 36)
            else
                SilentFov.Visible = false
            end
            if Settings.WaterMark then
                Library:SetWatermark("FPS: "..math.round(Workspace:GetRealPhysicsFPS()))
            end
        end)
    end)()
    
    local GetChildren = game.GetChildren
    local GetPlayers = Players.GetPlayers
    local WorldToScreen = Cam.WorldToScreenPoint
    local WorldToViewportPoint = Cam.WorldToViewportPoint
    local GetPartsObscuringTarget = Cam.GetPartsObscuringTarget
    local FindFirstChild = game.FindFirstChild
    local RenderStepped = RunService.RenderStepped

    local ValidTargetParts = {"Head", "HumanoidRootPart"}
    local ExpectedArguments = {
        FindPartOnRayWithIgnoreList = {
            ArgCountRequired = 3,
            Args = {
                "Instance", "Ray", "table", "boolean", "boolean"
            }
        },
        FindPartOnRayWithWhitelist = {
            ArgCountRequired = 3,
            Args = {
                "Instance", "Ray", "table", "boolean"
            }
        },
        FindPartOnRay = {
            ArgCountRequired = 2,
            Args = {
                "Instance", "Ray", "Instance", "boolean", "boolean"
            }
        },
        Raycast = {
            ArgCountRequired = 3,
            Args = {
                "Instance", "Vector3", "Vector3", "RaycastParams"
            }
        }
    }
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
    
    local function CheckOrigin(Origin)
        if typeof(Origin)=="Vector3" then
            if (Plr.Character.HumanoidRootPart.Position-Origin).Magnitude < 30 then
                return true
            end
        else
            return true
        end
    end

    local function IsPlayerVisible(Player)
        local PlayerCharacter = Player.Character
        local LocalPlayerCharacter = Plr.Character
        
        if not (PlayerCharacter or LocalPlayerCharacter) then return end 
        
        local PlayerRoot = FindFirstChild(PlayerCharacter, SilentSettings.Main.TargetPart) or FindFirstChild(PlayerCharacter, "HumanoidRootPart")
        
        if not PlayerRoot then return end 
        
        local CastPoints, IgnoreList = {PlayerRoot.Position, LocalPlayerCharacter, PlayerCharacter}, {LocalPlayerCharacter, PlayerCharacter}
        local ObscuringObjects = #GetPartsObscuringTarget(Cam, CastPoints, IgnoreList)
        
        return ((ObscuringObjects == 0 and true) or (ObscuringObjects > 0 and false))
    end
    
    local function GetClosestPlayer()
        if not SilentSettings.Main.TargetPart then return end
        local Closest
        local DistanceToMouse
        for _, Player in next, GetPlayers(Players) do
            if Player == Plr then continue end
            if SilentSettings.Main.TeamCheck and Player.Team == Plr.Team then continue end
    
            local Character = Player.Character
            if not Character then continue end
            
            if SilentSettings.Main.VisibleCheck and not IsPlayerVisible(Player) then continue end
    
            local HumanoidRootPart = FindFirstChild(Character, "HumanoidRootPart")
            local Humanoid = FindFirstChild(Character, "Humanoid")
            if not HumanoidRootPart or not Humanoid or Humanoid and Humanoid.Health <= 0 then continue end
    
            local ScreenPosition, OnScreen = GetPositionOnScreen(HumanoidRootPart.Position)
            if not OnScreen then continue end
    
            local Distance = (GetMousePosition() - ScreenPosition).Magnitude
            if Distance <= (DistanceToMouse or SilentSettings.Fov.Radius or 2000) then
                Closest = ((SilentSettings.Main.TargetPart == "Random" and Character[ValidTargetParts[math.random(1, #ValidTargetParts)]]) or Character[SilentSettings.Main.TargetPart])
                DistanceToMouse = Distance
            end
        end
        return Closest
    end
    
    local Raynamecall
    Raynamecall = hookmetamethod(game, "__namecall", newcclosure(function(...)
        local Method = getnamecallmethod()
        local Args = {...}
        local self = ...
        local script = getcallingscript()
        if SilentSettings.Main.Enabled and self == Workspace and not checkcaller() --[[and script:IsA("LocalScript")]] then
            if Method == "FindPartOnRayWithIgnoreList" then
                if table.find(SilentSettings.Main.Methods, Method) then
                    if ValidateArguments(Args, ExpectedArguments.FindPartOnRayWithWhitelist) then
                        local HitPart = GetClosestPlayer()
                        if HitPart then
                            local Origin = Args[2].Origin
                            local Direction = GetDirection(Origin, HitPart.Position)
                            Args[2] = Ray.new(Origin, Direction)

                            return Raynamecall(unpack(Args))
                        end
                    end
                end
            elseif Method == "FindPartOnRayWithWhitelist" then
                if table.find(SilentSettings.Main.Methods, Method) then
                    if ValidateArguments(Args, ExpectedArguments.FindPartOnRayWithWhitelist) then
                        local HitPart = GetClosestPlayer()
                        if HitPart then
                            local Origin = Args[2].Origin
                            local Direction = GetDirection(Origin, HitPart.Position)
                            Args[2] = Ray.new(Origin, Direction)

                            return Raynamecall(unpack(Args))
                        end
                    end
                end
            elseif (Method == "FindPartOnRay" or Method == "findPartOnRay") then
                if table.find(SilentSettings.Main.Methods, Method:lower()) then
                    if ValidateArguments(Args, ExpectedArguments.FindPartOnRay) then
                        local HitPart = GetClosestPlayer()
                        if HitPart then
                            local Origin = Args[2].Origin
                            local Direction = GetDirection(Origin, HitPart.Position)
                            Args[2] = Ray.new(Origin, Direction)

                            return Raynamecall(unpack(Args))
                        end
                    end
                end
            elseif Method == "Raycast" then
                if table.find(SilentSettings.Main.Methods, Method) then
                    if ValidateArguments(Args, ExpectedArguments.Raycast) then
                        local HitPart = GetClosestPlayer()
                        if HitPart then
                            local Origin = Args[2]
                            Args[3] = GetDirection(Origin, HitPart.Position)
                            
                            return Raynamecall(unpack(Args))
                        end
                    end
                end
            end
        end
        return Raynamecall(...)
    end))

--[[
    local oldIndex = nil 
    oldIndex = hookmetamethod(game, "__index", newcclosure(function(self, Index)
        if self == Mouse and not checkcaller() and SilentSettings.Main.Enabled and Options.Method.Value == "Mouse.Hit/Target" and GetClosestPlayer() then
            local HitPart = GetClosestPlayer()
            
            if Index == "Target" or Index == "target" then 
                return HitPart
            elseif Index == "Hit" or Index == "hit" then 
                return ((Toggles.Prediction.Value and (HitPart.CFrame + (HitPart.Velocity * PredictionAmount))) or (not Toggles.Prediction.Value and HitPart.CFrame))
            elseif Index == "X" or Index == "x" then 
                return self.X 
            elseif Index == "Y" or Index == "y" then 
                return self.Y 
            elseif Index == "UnitRay" then 
                return Ray.new(self.Origin, (self.Hit - self.Origin).Unit)
            end
        end

        return oldIndex(self, Index)
    end))]]

    PlayerEsp:CreatePlayerEsp()

    local SShub = Library:CreateWindow({Title = Name.." | "..GameName.." | ",Center = true, AutoShow = true, Size = UDim2.fromOffset(560, 600)})
    local Main = SShub:AddTab("Main")
    local Visuals = SShub:AddTab("Visuals")
    local Settingss = SShub:AddTab("Settings")
    
    local MainA = Main:AddLeftGroupbox("Silent & Aimbot")
    local MainM = Main:AddRightGroupbox("Misc")
    local MainPlayerEsp = Visuals:AddLeftGroupbox("Player Esp")
    
    local MainC = Settingss:AddLeftGroupbox("Credits")
    local MainUI = Settingss:AddLeftGroupbox("UI")
    
    SaveManager:SetLibrary(Library)
    SaveManager:SetFolder(Name)
    SaveManager:BuildConfigSection(Settingss)
    
    MainM:AddToggle('WaterMark', {Text = "WaterMark",Default = Settings.WaterMark, Tooltip = 'WaterMark', Callback = function(v)
        Settings.WaterMark = v
        Library:SetWatermarkVisibility(v)
    end}):AddKeyPicker("WaterMark Keybind",{Default = 'None',SyncToggleState = true, Mode = 'Toggle',Text = 'WaterMark'})


    MainA:AddToggle('SilentAim', {Text = "SilentAim", Default = SilentSettings.Main.Enabled, Tooltip = 'Silent Aim', Callback = function(v)
        SilentSettings.Main.Enabled = v
    end}):AddKeyPicker("Silent Aim",{Default = 'None',SyncToggleState = true, Mode = 'Toggle',Text = 'Silent Aim'})

    MainA:AddDropdown('AimPartDropdown', {Values = {"Head", "HumanoidRootPart", "Random"}, Default = SilentSettings.Main.TargetPart, Multi = false, Text = 'Aim Part', Callback = function(v)
        SilentSettings.Main.TargetPart = v
    end})

    MainA:AddDropdown('Methods', {Values = {"Raycast", "findpartonray", "FindPartOnRayWithWhitelist", "FindPartOnRayWithIgnoreList"}, Default = "None", Multi = true, Text = 'Methods', Callback = function(v)
        for Pos,_ in pairs(SilentSettings.Main.Methods) do
            table.remove(SilentSettings.Main.Methods, Pos)
        end
        for i,_ in pairs(v) do
            table.insert(SilentSettings.Main.Methods, tostring(i))
        end
    end})

    MainA:AddToggle('VisibleCheck', {Text = "Visible Check", Default = SilentSettings.Main.VisibleCheck, Tooltip = "VisibleCheck", Callback = function(v)
        SilentSettings.Main.VisibleCheck = v
    end}):AddKeyPicker("VisibleCheck Keybind",{Default = 'None',SyncToggleState = true, Mode = 'Toggle',Text = 'VisibleCheck'})
    
    MainA:AddToggle('TeamCheck', {Text = "Team Check", Default = SilentSettings.Main.TeamCheck, Tooltip = "TeamCheck", Callback = function(v)
        SilentSettings.Main.TeamCheck = v
    end}):AddKeyPicker("TeamCheck Keybind",{Default = 'None',SyncToggleState = true, Mode = 'Toggle',Text = 'TeamCheck'})

    local Fov = MainA:AddToggle('Fov', {Text = "Fov", Default = SilentSettings.Fov.Enabled, Tooltip = "Fov", Callback = function(v)
        SilentSettings.Fov.Enabled = v
    end}):AddKeyPicker("Fov Keybind",{Default = 'None',SyncToggleState = true, Mode = 'Toggle',Text = 'Fov'})
    Fov:AddColorPicker('FovColor', {Default = SilentSettings.Fov.Color, Title = 'RGB', Callback = function(v)
        SilentSettings.Fov.Color = v
    end})

    MainA:AddSlider('FovRadius', {Text = 'Radius',Default = SilentSettings.Fov.Radius, Min = 0,Max = 360,Rounding = 0, Compact = false, Callback = function(v)
        SilentSettings.Fov.Radius = v
    end})

    --Player Visuals

    MainPlayerEsp:AddToggle('Esp', {Text = "Toggle Esp", Default = Esp.Enabled, Tooltip = 'Show other players trought walls', Callback = function(v)
        Esp.Enabled = v
    end}):AddKeyPicker("Esp Keybind",{Default = 'None',SyncToggleState = true, Mode = 'Toggle',Text = 'Players Esp'})

    MainPlayerEsp:AddToggle('BoxesBox', {Text = "Box",Default = Esp.Boxes, Callback = function(v)
        Esp.Boxes = v
    end}):AddColorPicker('BoxesBoxColor', {Default = Esp.Colors.Boxes, Title = 'RGB', Callback = function(v)
        Esp.Colors.Boxes = v
    end})

    MainPlayerEsp:AddToggle('NameText', {Text = "Name",Default = Esp.Name, Callback = function(v)
        Esp.Name = v
    end}):AddColorPicker('NameTextColor', {Default = Esp.Colors.Name, Title = 'RGB', Callback = function(v)
        Esp.Colors.Name = v
    end})

    MainPlayerEsp:AddToggle('HealthText', {Text = "Health", Default = Esp.Health, Callback = function(v)
        Esp.Health = v
    end}):AddColorPicker('HealthTextColor', {Default = Esp.Colors.Health, Title = 'RGB', Callback = function(v)
        Esp.Colors.Health = v
    end})

    MainPlayerEsp:AddToggle('TeamText', {Text = "Team", Default = Esp.Team, Callback = function(v)
        Esp.Team = v
    end}):AddColorPicker('TeamTextColor', {Default = Esp.Colors.Team, Title = 'RGB', Callback = function(v)
        Esp.Colors.Team = v
    end})

    MainPlayerEsp:AddToggle('ToolText', {Text = "Tool", Default = Esp.Tool, Callback = function(v)
        Esp.Tool = v
    end}):AddColorPicker('ToolTextColor', {Default = Esp.Colors.Tool, Title = 'RGB', Callback = function(v)
        Esp.Colors.Tool = v
    end})

    MainPlayerEsp:AddToggle('TracersDraw', {Text = "Tracers", Default = Esp.Tracers, Callback = function(v)
        Esp.Tracers = v
    end}):AddColorPicker('TracersDrawColor', {Default = Esp.Colors.Tracers, Title = 'RGB', Callback = function(v)
        Esp.Colors.Tracers = v
    end})

    MainPlayerEsp:AddToggle('BackpackText', {Text = "Backpack", Default = Esp.Backpack, Callback = function(v)
        Esp.Backpack = v
    end}):AddColorPicker('BackpackTextColor', {Default = Esp.Colors.Backpack, Title = 'RGB', Callback = function(v)
        Esp.Colors.Backpack = v
    end})

    local TeamCheck = MainPlayerEsp:AddToggle('TeamCheck', {Text = "TeamCheck", Default = Esp.TeamCheck, Callback = function(v)
        Esp.TeamCheck = v
    end})
    TeamCheck:AddColorPicker('TeamCheckColor1', {Default = Esp.Colors.TeamCheck[1], Title = 'RGB', Callback = function(v)
        Esp.Colors.TeamCheck[1] = v
    end})
    TeamCheck:AddColorPicker('TeamCheckColor2', {Default = Esp.Colors.TeamCheck[2], Title = 'RGB', Callback = function(v)
        Esp.Colors.TeamCheck[2] = v
    end})

    MainPlayerEsp:AddToggle('DistanceText', {Text = "Distance",Default = Esp.Distance, Callback = function(v)
        Esp.Distance = v
    end}):AddColorPicker('DistanceTextColor', {Default = Esp.Colors.Distance, Title = 'RGB', Callback = function(v)
        Esp.Colors.Distance = v
    end})

    MainPlayerEsp:AddSlider('MaxDistanceValue', {Text = 'ESP Distance',Default = Esp.MaxDistance,Min = 0,Max = 10000,Rounding = 0, Compact = false, Callback = function(v)
        Esp.MaxDistance = v
    end})
    
    MainC:AddLabel("Owner - Tupi")
    
    MainUI:AddButton('Unload', function() Library:Unload() end)
    MainUI:AddLabel('UI Toggler'):AddKeyPicker('MenuKeybind', {Default = 'End', Text = 'Ui Toggler'}) 
    Library.ToggleKeybind = Options.MenuKeybind
    
    coroutine.wrap(function()
        RunService.Stepped:Connect(function()
            PlayerEsp.Players.Enabled = Esp.Enabled
            PlayerEsp.Players.Name[1] = Esp.Name
            PlayerEsp.Players.Health[1] = Esp.Health
            PlayerEsp.Players.Team[1] = Esp.Team
            PlayerEsp.Players.Tool[1] = Esp.Tool
            PlayerEsp.Players.Backpack[1] = Esp.Backpack
            PlayerEsp.Players.Tracers[1] = Esp.Tracers
            PlayerEsp.Players.Distance[1] = Esp.Distance
            PlayerEsp.Players.Boxes[1] = Esp.Boxes
            PlayerEsp.Players.TeamCheck[1] = Esp.TeamCheck

            PlayerEsp.Players.MaxDistance = Esp.MaxDistance

            PlayerEsp.Players.Name[2] = Esp.Colors.Name
            PlayerEsp.Players.Health[2] = Esp.Colors.Health
            PlayerEsp.Players.Team[2] = Esp.Colors.Team
            PlayerEsp.Players.Tool[2] = Esp.Colors.Tool
            PlayerEsp.Players.Backpack[2] = Esp.Colors.Backpack
            PlayerEsp.Players.Tracers[2] = Esp.Colors.Tracers
            PlayerEsp.Players.Distance[2] = Esp.Colors.Distance
            PlayerEsp.Players.Boxes[2] = Esp.Colors.Boxes
            PlayerEsp.Players.TeamCheck[2] = Esp.Colors.TeamCheck[1]
            PlayerEsp.Players.TeamCheck[3] = Esp.Colors.TeamCheck[2]
        end)
    end)()
end)

if Error and not Success then
    local ErrorHandle = loadstring(game:HttpGet("https://raw.githubusercontent.com/miguel831/Roblox-Scripts/main/SSHub/ErrorHandle.lua", true))()
    ErrorHandle(Error)
    Notify(NS.Title,NS.Icon,"Error, Copied to clipboard")
    print("[Error] Copied to clipboard - "..tostring(Error))
    setclipboard(tostring(Error))
end
