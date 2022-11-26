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
    SelectedLocation = "",
    SelectedBreathLocation = "",
    SelectedBossFarm = false,
    SelectedBoss = "",
    KillAura = {
        Enabled = false,
        TypeSelected = ""
    },
    PlrDied = false,
    NoSunDmg = true,
    AutoLootChest = false,
    FarmAllBosses = false,
    SelectedDemons = "",
    DemonsFarm = false,
    BringMob = false
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
		Distance = 2000
	} 
};

local Success, Error = pcall(function()
    print("Stage [2/2] Loader")
    print("[1/2] Loading...")
    --#region Libs
    local repo = 'https://raw.githubusercontent.com/wally-rblx/LinoriaLib/main/'
    local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
    local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
    local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
    local LibraryESPHttps = "https://raw.githubusercontent.com/miguel831/Roblox-Scripts/main/SSHub/Lib/ESP.lua"
    local LibraryESP = loadstring(game:HttpGet(LibraryESPHttps, true))()
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
    local Uis = GetService(game, "UserInputService");
    local Cam = Workspace.CurrentCamera;
    local Mouse = Players.LocalPlayer:GetMouse()
    local Plr = Players.LocalPlayer
    local GameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
    --#endregion
    local antifall2 = nil
    local antifallnpc = nil
    local antifall = nil
    local function TableRemove(Table, Item)
        local Index = nil
        for i, v in ipairs (Table) do 
            if (v == Item) then
                Index = i 
            end
        end
    table.remove(Table, Index)
    end

     local function noclip()
        for i, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") and v.CanCollide == true then
                v.CanCollide = false
                game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
            end
        end
    end
    local Tween
    local noclipE = nil
    local function TeleportTween(To)
        Distance = (To.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
        if Distance < 200 then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = To
            Speed = 350
        elseif Distance < 1000 then
            Speed = 350
        elseif Distance >= 1000 then
            Speed = 250
        end
        Tween = game:GetService("TweenService"):Create(
            game.Players.LocalPlayer.Character.HumanoidRootPart,
            TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),
            {CFrame = To})
        noclipE = game:GetService("RunService").Stepped:Connect(noclip) 
        if not Plr.Character.HumanoidRootPart:FindFirstChild("BodyVelocity") then
        antifall = Instance.new("BodyVelocity", Players.LocalPlayer.Character.HumanoidRootPart)
        antifall.Velocity = Vector3.new(0, 0, 0)
        end
        Tween:Play()
        Tween.Completed:Wait()
        pcall(function()
            Tween = nil
            antifall:Destroy()
            noclipE:Disconnect()
        end)
    end
    local function args(Type, style, count)
        if Type == 1 then
            return {
                [1] = style,
                [2] = nil,
                [3] = Plr.Character,
                [4] = nil,
                [5] = Plr.Character:WaitForChild("Humanoid"),
                [6] = count,
                [7] = "kick"
            }
        elseif Type == 2 then
            return {
                [1] = style,
                [2] = nil,
                [3] = Plr.Character,
                [4] = nil,
                [5] = Plr.Character:WaitForChild("Humanoid"),
                [6] = count
            }
        end
    end

local Hitting = false
    task.spawn(function()
        while task.wait() do
            if Settings.KillAura.Enabled and not Settings.PlrDied and Plr.Character:FindFirstChild("HumanoidRootPart") and Plr.Character:FindFirstChild("Humanoid") then
                if Settings.KillAura.TypeSelected == "Fists" then
                    Hitting=true
                    wait(.2)
                    game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S_:InvokeServer(unpack(args(1,"fist_combat", 7)))
                    for i = 1, 7 do
                        game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S:FireServer(unpack(args(1,"fist_combat", 7)))
                        game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S:FireServer(unpack(args(2,"fist_combat", 919)))
                    end
                    wait(.2)
                    Hitting=false
                    wait(2.5)
                elseif Settings.KillAura.TypeSelected == "Sword" then
                    Hitting=true
                    wait(.2)
                    game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S_:InvokeServer(unpack(args(1,"fist_combat", 7)))
                    for i = 1, 7 do
                        game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S:FireServer(unpack(args(1,"Sword_Combat_Slash", 7)))
                        game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S:FireServer(unpack(args(2,"Sword_Combat_Slash", 919)))
                    end
                    wait(.2)
                    Hitting=false
                    wait(2.5)
                elseif Settings.KillAura.TypeSelected == "Scythe" then
                    Hitting=true
                    wait(.2)
                    game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S_:InvokeServer(unpack(args(1,"fist_combat", 7)))
                    for i = 1, 7 do
                        game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S:FireServer(unpack(args(1,"Scythe_Combat_Slash", 7)))
                        game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S:FireServer(unpack(args(2,"Scythe_Combat_Slash", 919)))
                    end
                    wait(.2)
                    Hitting=false
                    wait(2.5)
                elseif Settings.KillAura.TypeSelected == "Claws" then
                    Hitting=true
                    wait(.2)
                    game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S_:InvokeServer(unpack(args(1,"fist_combat", 7)))
                    for i = 1, 7 do
                        game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S:FireServer(unpack(args(1,"claw_Combat_Slash", 7)))
                        game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S:FireServer(unpack(args(2,"claw_Combat_Slash", 919)))
                    end
                    wait(.2)
                    Hitting=false
                    wait(2.5)
                end
            end
        end
    end)
local World = 1
    if game.PlaceId == 11468159863 then
        World = 2
    elseif game.PlaceId == 6152116144 then
        World = 1
    end

local Bosses = {}

if World == 2 then
    local Second = {
        ["Akeza"] = CFrame.new(2020.34, 556.071, -125.497),
        ["Rengoku"] = CFrame.new(3667.58, 673.185, -408.076),
        ["Inosuke"] = CFrame.new(1588.55, 300.281, -359.55),
        ["Renpeke Kuuchie"] = CFrame.new(-1201.97, 601.276, -627.884),
        ["Enme"] = CFrame.new(3192.03, 368.384, -3901.33),
        ["Muichiro Tokito"] = CFrame.new(4410.76, 673.457, -550.114),
        ["Swampy"] = CFrame.new(-1364.9, 601.273, -207.818)
    }
    Bosses = Second
elseif World == 1 then
    local First = {
        ["Sabito"] = CFrame.new(1230.93, 275.351, -2845.19),
        ["Zanegutsu Kuuchie"] = CFrame.new(-217.212, 425.857, -2283.64),
        ["Shiron"] = CFrame.new(3192.03, 368.384, -3901.33),
        ["Sanemi"] = CFrame.new(1598.74, 348.832, -3688.97),
        ["Giyu"] = CFrame.new(3067.07, 314.459, -3004.74),
        ["Nezuko"] = CFrame.new(3549.87, 342.065, -4596.74),
        ["Yahaba"] = CFrame.new(1385.68, 315.965, -4655.61),
        ["Susamaru"] = CFrame.new(1347.36, 315.792, -4583.32),
        ["Slasher"] = CFrame.new(4357.25, 342.193, -4382),
        ["Bandit Zuko"] = CFrame.new(174.627, 283.407, -1969.9)
    }
    Bosses = First
end

local BossCheck = {}
if World == 2 then
    local Second = {
        ["Inosuke"] = false,
        ["Renpeke Kuuchie"] = false,
        ["Enme"] = false,
        ["Muichiro Tokito"] = false,
        ["Swampy"] = false,
        ["Akeza"] = false,
        ["Rengoku"] = false
    }
    BossCheck = Second
elseif World == 1 then
    local First = {
        ["Sabito"] = false,
        ["Zanegutsu Kuuchie"] = false,
        ["Shiron"] = false,
        ["Sanemi"] = false,
        ["Giyu"] = false,
        ["Nezuko"] = false,
        ["Yahaba"] = false,
        ["Susamaru"] = false,
        ["Slasher"] = false,
        ["Bandit Zuko"] = false
    }
    BossCheck = First
end
spawn(function()
    while wait() do
        pcall(function()
            for _,v in pairs(game:GetService("Workspace").Mobs.Bosses:GetDescendants()) do
                if v:IsA("Humanoid") then
                    v = v.Parent
                    if v.Humanoid.Health > 0 then
                        BossCheck[v.Name] = true
                    else
                        BossCheck[v.Name] = false
                    end
                end
            end
        end)
    end
end)
    
Plr.Character:WaitForChild("Humanoid").Died:Connect(function()
    Settings.PlrDied = true
end)

Plr.CharacterAdded:Connect(function()
    Settings.PlrDied = false
end)
spawn(function()
    while wait() do
        pcall(function()
            if Settings.AutoLootChest then
                local chest = game:GetService("Workspace").Debree:FindFirstChild("Loot_Chest")
            
                if chest and #chest:WaitForChild("Drops"):GetChildren() > 0 then
                    local remote = chest:WaitForChild("Add_To_Inventory")

                    for _,v in next, chest:WaitForChild("Drops"):GetChildren() do
                        mag = (Plr.Character.HumanoidRootPart.Position - chest.Root.Position).Magnitude
                        if mag < 1000 then 
                            if string.find(v.Name, "Ore") or string.find(v.Name, "Elixir") then
                                remote:InvokeServer(v.Name)
                            elseif not game:GetService("ReplicatedStorage")["Player_Data"][game:GetService("Players").LocalPlayer.Name].Inventory:FindFirstChild(v.Name, true) then
                                remote:InvokeServer(v.Name)
                            end
                        end
                    end
                end
            end
        end)
    end
end)
--Selected Boss
local SelectedBossFarm = "Waiting..."
spawn(function()
    while wait() do
        pcall(function()
            if Settings.SelectedBossFarm and Settings.FarmAllBosses then
                SelectedBossFarm = "Error"
            end
            if Settings.SelectedBossFarm and not Settings.FarmAllBosses then
                SelectedBossFarm = "Correct"
                for i,v in pairs(game:GetService("Workspace").Mobs.Bosses:GetDescendants()) do
                    if Settings.SelectedBossFarm and not Settings.FarmAllBosses  then
                        if v:IsA("Humanoid") then
                            v = v.Parent
                            if string.match(v.Name, Settings.SelectedBoss) and Settings.SelectedBossFarm and not Settings.FarmAllBosses then
                                for i2,v2 in pairs(Bosses) do
                                    if Settings.SelectedBossFarm and not Settings.FarmAllBosses then
                                        if string.match(v.Name,i2) and Settings.SelectedBossFarm and not Settings.FarmAllBosses then
                                            if not v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and Settings.SelectedBossFarm and not Settings.FarmAllBosses  and string.match(v.Name, Settings.SelectedBoss) then
                                                if Tween then Tween:Cancel() Tween = nil end
                                                TeleportTween(v2)
                                            end
                                            if v.HumanoidRootPart and v.Humanoid and not Settings.PlrDied and v.Humanoid.Health > 0 and Settings.SelectedBossFarm and not Settings.FarmAllBosses and string.match(v.Name, Settings.SelectedBoss) then
                                                if Tween then Tween:Cancel() Tween = nil end
                                                TeleportTween(v.HumanoidRootPart.CFrame)

                                                antifall2 = Instance.new("BodyVelocity", Plr.Character.HumanoidRootPart)
                                                antifall2.Velocity = Vector3.new(0, 0, 0)
                                                antifallnpc = Instance.new("BodyVelocity", v.HumanoidRootPart)
                                                antifallnpc.Velocity = Vector3.new(0, 0, 0)
                                                Settings.KillAura.Enabled = true
                                                local FarmingPos = v.HumanoidRootPart.CFrame
                                                while wait() and Settings.SelectedBossFarm and not Settings.FarmAllBosses and v.Humanoid:IsDescendantOf(workspace) and v.Humanoid.Health > 0 and not Settings.PlrDied do
                                                    if Settings.BringMob then
                                                    v.HumanoidRootPart.CFrame = FarmingPos
                                                    end
                                                    if not Hitting and Settings.SelectedBossFarm and not Settings.FarmAllBosses then
                                                        Plr.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame*CFrame.new(0,100,0)
                                                    elseif Hitting and Settings.SelectedBossFarm and not Settings.FarmAllBosses then
                                                        Plr.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame*CFrame.new(0,0,3)
                                                    end
                                                    if Settings.SelectedBossFarm == false or not v.Humanoid:IsDescendantOf(workspace) or v.Humanoid.Health <= 0 or Settings.PlrDied or Settings.FarmAllBosses or not string.match(v.Name, Settings.SelectedBoss) then
                                                        Settings.KillAura.Enabled = false
                                                        FarmingPos = nil
                                                        antifall2:Destroy()
                                                        antifallnpc:Destroy()
                                                        wait(2)
                                                        break
                                                    end
                                                end
                                                if Settings.SelectedBossFarm == false or not v.Humanoid:IsDescendantOf(workspace) or v.Humanoid.Health <= 0 or Settings.PlrDied or Settings.FarmAllBosses or not string.match(v.Name, Settings.SelectedBoss) then
                                                    Settings.KillAura.Enabled = false
                                                    FarmingPos = nil
                                                    antifall2:Destroy()
                                                    antifallnpc:Destroy()
                                                    wait(2)
                                                end
                                            end
                                        end
                                    else
                                        break
                                    end
                                end
                            end
                        end
                    else
                        break
                    end
                end
            end
        end)
    end
end)
--All Bosses
local FarmAllBosses = "Waiting..."
spawn(function()
    while wait() do
        pcall(function()
            if Settings.FarmAllBosses and Settings.SelectedBossFarm then
                FarmAllBosses = "Error"
            end
            if Settings.FarmAllBosses and not Settings.SelectedBossFarm then
                FarmAllBosses = "Correct"
                for i,v in pairs(game:GetService("Workspace").Mobs.Bosses:GetDescendants()) do
                    if Settings.FarmAllBosses and not Settings.SelectedBossFarm then
                        if v:IsA("Humanoid") then
                            v = v.Parent
                            for i2,v2 in pairs(Bosses) do
                                if Settings.FarmAllBosses and not Settings.SelectedBossFarm then
                                    if string.match(i2,v.Name) and Settings.FarmAllBosses and not Settings.SelectedBossFarm then
                                        if not v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and Settings.FarmAllBosses and not Settings.SelectedBossFarm then
                                            if Tween then Tween:Cancel() Tween = nil end
                                            TeleportTween(v2)
                                        end
                                        if v.HumanoidRootPart and v.Humanoid and not Settings.PlrDied and v.Humanoid.Health > 0 and Settings.FarmAllBosses and not Settings.SelectedBossFarm then
                                            if Tween then Tween:Cancel() Tween = nil end
                                            TeleportTween(v.HumanoidRootPart.CFrame)

                                            antifall2 = Instance.new("BodyVelocity", Plr.Character.HumanoidRootPart)
                                            antifall2.Velocity = Vector3.new(0, 0, 0)
                                            antifallnpc = Instance.new("BodyVelocity", v.HumanoidRootPart)
                                            antifallnpc.Velocity = Vector3.new(0, 0, 0)
                                            Settings.KillAura.Enabled = true
                                            local FarmingPos = v.HumanoidRootPart.CFrame
                                            while wait() and Settings.FarmAllBosses  and not Settings.SelectedBossFarm and v.Humanoid:IsDescendantOf(workspace) and v.Humanoid.Health > 0 and not Settings.PlrDied do
                                                if Settings.BringMob then
                                                    v.HumanoidRootPart.CFrame = FarmingPos
                                                end
                                                if not Hitting and Settings.FarmAllBosses and not Settings.SelectedBossFarm then
                                                    Plr.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame*CFrame.new(0,100,0)
                                                elseif Hitting and Settings.FarmAllBosses and not Settings.SelectedBossFarm then
                                                    Plr.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame*CFrame.new(0,0,3)
                                                end
                                                if Settings.FarmAllBosses == false or not v.Humanoid:IsDescendantOf(workspace) or v.Humanoid.Health <= 0 or Settings.PlrDied or Settings.SelectedBossFarm then
                                                    Settings.KillAura.Enabled = false
                                                    antifall2:Destroy()
                                                    antifallnpc:Destroy()
                                                    wait(2)
                                                    break
                                                end
                                            end
                                            if Settings.FarmAllBosses == false or not v.Humanoid:IsDescendantOf(workspace) or v.Humanoid.Health <= 0 or Settings.PlrDied or Settings.SelectedBossFarm then
                                                Settings.KillAura.Enabled = false
                                                FarmingPos = nil
                                                antifall2:Destroy()
                                                antifallnpc:Destroy()
                                                wait(2)
                                            end
                                        end
                                    end
                                else
                                    break
                                end
                            end
                        end
                    else
                        break
                    end
                end
            end
        end)
    end
end)
--Demons
local DemonsFarm = "Waiting..."
spawn(function()
    while wait() do
            if Settings.DemonsFarm and Settings.FarmAllBosses or Settings.DemonsFarm and Settings.SelectedBossFarm then
                DemonsFarm = "Error"
            end
            if Settings.DemonsFarm and not Settings.FarmAllBosses or Settings.DemonsFarm and not Settings.SelectedBossFarm then
                DemonsFarm = "Correct"
                for i,v in pairs(game:GetService("Workspace").Mobs.Demons:GetDescendants()) do
                    if Settings.DemonsFarm and not Settings.FarmAllBosses or Settings.DemonsFarm and not Settings.SelectedBossFarm then
                        if v:IsA("Humanoid") then
                            v = v.Parent
                            if Settings.DemonsFarm and not Settings.FarmAllBosses or Settings.DemonsFarm and not Settings.SelectedBossFarm then
                                if not v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and Settings.DemonsFarm and not Settings.FarmAllBosses or Settings.DemonsFarm and not Settings.SelectedBossFarm then
                                    if Tween then Tween:Cancel() Tween = nil end
                                    TeleportTween(CFrame.new(v.Humanoid.WalkToPoint))
                                end
                                if v.HumanoidRootPart and v.Humanoid and not Settings.PlrDied and v.Humanoid.Health > 0 and Settings.DemonsFarm and not Settings.FarmAllBosses or Settings.DemonsFarm and not Settings.SelectedBossFarm then
                                    if Tween then Tween:Cancel() Tween = nil end
                                        TeleportTween(CFrame.new(v.Humanoid.WalkToPoint))

                                        antifall2 = Instance.new("BodyVelocity", Plr.Character.HumanoidRootPart)
                                        antifall2.Velocity = Vector3.new(0, 0, 0)
                                        antifallnpc = Instance.new("BodyVelocity", v.HumanoidRootPart)
                                        antifallnpc.Velocity = Vector3.new(0, 0, 0)
                                        Settings.KillAura.Enabled = true
                                        local FarmingPos = v.HumanoidRootPart.CFrame
                                        while wait() and Settings.DemonsFarm and not Settings.FarmAllBosses or Settings.DemonsFarm and not Settings.SelectedBossFarm and v.Humanoid:IsDescendantOf(workspace) and v.Humanoid.Health > 0 and not Settings.PlrDied do
                                            if Settings.BringMob then
                                                v.HumanoidRootPart.CFrame = FarmingPos
                                            end
                                            if not Hitting and Settings.DemonsFarm and not Settings.FarmAllBosses or Settings.DemonsFarm and not Settings.SelectedBossFarm then
                                                Plr.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame*CFrame.new(0,100,0)
                                            elseif Hitting and Settings.DemonsFarm and not Settings.FarmAllBosses or Settings.DemonsFarm and not Settings.SelectedBossFarm then
                                                Plr.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame*CFrame.new(0,0,3)
                                            end
                                            if Settings.DemonsFarm == false or not v.Humanoid:IsDescendantOf(workspace) or v.Humanoid.Health <= 0 or Settings.PlrDied or Settings.SelectedBossFarm or Settings.FarmAllBosses then
                                                Settings.KillAura.Enabled = false
                                                antifall2:Destroy()
                                                antifallnpc:Destroy()
                                                wait(2)
                                                break
                                            end
                                        end
                                        if Settings.DemonsFarm == false or not v.Humanoid:IsDescendantOf(workspace) or v.Humanoid.Health <= 0 or Settings.PlrDied or Settings.SelectedBossFarm or Settings.FarmAllBosses then
                                            Settings.KillAura.Enabled = false
                                            FarmingPos = nil
                                            antifall2:Destroy()
                                            antifallnpc:Destroy()
                                            wait(2)
                                        end
                                end
                            end
                        end
                    else
                        break
                    end
                end
            end
    end
end)
local SShub = Library:CreateWindow({Title = Name.." | "..GameName.." | Script Req: Have Good Ethernet | Toggle: End",Center = true, AutoShow = true})
local Farm = SShub:AddTab("Farm & Mods")
local Visuals = SShub:AddTab("Visuals")
local Teleports = SShub:AddTab("Teleports")
local Settingss = SShub:AddTab("Settings")

local MainCoo = Farm:AddLeftTabbox("Farming")
local MainCo = MainCoo:AddTab("Bosses")
local MainC1 = MainCoo:AddTab("Demon's")
local MainC2 = MainCoo:AddTab("Npc's")
local MainC3 = MainCoo:AddTab("Options")
local MainC4 = Farm:AddRightGroupbox("Spawned Bosses")
local MainCr = Farm:AddRightGroupbox("Info & Some Mods")

local MainP = Visuals:AddLeftGroupbox("Player ESP")

local MainTele = Teleports:AddRightGroupbox("Teleports")
local MainTrz = Teleports:AddLeftTabbox("Teleports")
local MainTr = Teleports:AddLeftGroupbox("Options")
local MainT = MainTrz:AddTab("Locations")
local MainT1 = MainTrz:AddTab("Breaths")


local MainC = Settingss:AddLeftGroupbox("Credits")
local MainUI = Settingss:AddLeftGroupbox("UI")

SaveManager:SetLibrary(Library)
SaveManager:SetFolder(Name..'/'..game.PlaceId)
SaveManager:BuildConfigSection(Settingss)

if game.PlaceId == 11468159863 then
    MainCo:AddDropdown('BossesDropdown', {Values = {"Inosuke","Renpeke Kuuchie","Enme","Muichiro Tokito","Swampy","Akeza","Rengoku"}, Default = 1, Multi = false, Text = 'Bosses', Tooltip = 'Select ur boss'})
    Options.BossesDropdown:OnChanged(function()
        Settings.SelectedBoss = Options.BossesDropdown.Value
    end)
elseif game.PlaceId == 6152116144 then
    MainCo:AddDropdown('BossesDropdown', {Values = {"Sabito","Zanegutsu Kuuchie","Shiron","Sanemi","Giyu","Nezuko","Yahaba","Susamaru","Slasher","Bandit Zuko"}, Default = 1, Multi = false, Text = 'Bosses', Tooltip = 'Select ur boss'})
    Options.BossesDropdown:OnChanged(function()
        Settings.SelectedBoss = Options.BossesDropdown.Value
    end)
end

MainCo:AddToggle('SelectedBossFarm', {Text = 'Farm Boss (Selected)',Default = Settings.SelectedBossFarm,Tooltip = 'Farm ur selected Boss'})
Toggles.SelectedBossFarm:OnChanged(function()
    Settings.SelectedBossFarm = Toggles.SelectedBossFarm.Value
end)
local SelectedBossFarmLabel = MainCo:AddLabel("Status: Loading...")
MainCo:AddToggle('FarmAllBosses', {Text = 'Farm All Bosses ',Default = Settings.FarmAllBosses,Tooltip = 'Farm all bosses'})
Toggles.FarmAllBosses:OnChanged(function()
    Settings.FarmAllBosses = Toggles.FarmAllBosses.Value
end)
local FarmAllBossesLabel = MainCo:AddLabel("Status: Loading...")
MainCo:AddDivider()
MainCo:AddLabel("If autofarms dont working u can go to Options > Bring Mob\nit may will fix it a bit.",true)
MainCo:AddDivider()
local BreathCheck = MainCr:AddLabel("...")
local DemonCheck = MainCr:AddLabel("...")

local BossCheckLabel = MainC4:AddLabel("Loading...")
local BossCheckLabel1 = MainC4:AddLabel("Loading...")
local BossCheckLabel2 = MainC4:AddLabel("Loading...")
local BossCheckLabel3 = MainC4:AddLabel("Loading...")
local BossCheckLabel4 = MainC4:AddLabel("Loading...")
local BossCheckLabel5 = MainC4:AddLabel("Loading...")
local BossCheckLabel6 = MainC4:AddLabel("Loading...")
local BossCheckLabel7
local BossCheckLabel8
local BossCheckLabel9
if World == 1 then
    BossCheckLabel7 = MainC4:AddLabel("Loading...")
    BossCheckLabel8 = MainC4:AddLabel("Loading...")
    BossCheckLabel9 = MainC4:AddLabel("Loading...")
end

spawn(function()
    while wait() do
        pcall(function()
            local Breath = game:GetService("ReplicatedStorage")["Player_Data"][Plr.Name].BreathingProgress
            local Demon = game:GetService("ReplicatedStorage")["Player_Data"][Plr.Name].DemonProgress
            BreathCheck:SetText("Breathing Progress: " .. Breath["1"].Value .. " / " .. Breath["2"].Value)
            DemonCheck:SetText("Demon Progress: " .. Demon["1"].Value .. " / " .. Demon["2"].Value)
            SelectedBossFarmLabel:SetText("Status: "..SelectedBossFarm)
            FarmAllBossesLabel:SetText("Status: "..FarmAllBosses)
                for i,v in pairs(BossCheck) do
                    if World == 2 then
                        if i == "Inosuke" and v then
                            BossCheckLabel:SetText("Inosuke: 🟢")
                        elseif i == "Renpeke Kuuchie" and v then
                            BossCheckLabel1:SetText("Renpeke Kuuchie: 🟢")
                        elseif i == "Enme" and v then
                            BossCheckLabel2:SetText("Enme: 🟢")
                        elseif i == "Muichiro Tokito" and v then
                            BossCheckLabel3:SetText("Muichiro Tokito: 🟢")
                        elseif i == "Swampy" and v then
                            BossCheckLabel4:SetText("Swampy: 🟢")
                        elseif i == "Akeza" and v then
                            BossCheckLabel5:SetText("Akeza: 🟢")
                        elseif i == "Rengoku" and v then
                            BossCheckLabel6:SetText("Rengoku: 🟢")
                        elseif i == "Inosuke" and not v then
                            BossCheckLabel:SetText("Inosuke: 🔴")
                        elseif i == "Renpeke Kuuchie" and not v then
                            BossCheckLabel1:SetText("Renpeke Kuuchie: 🔴")
                        elseif i == "Enme" and not v then
                            BossCheckLabel2:SetText("Enme: 🔴")
                        elseif i == "Muichiro Tokito" and not v then
                            BossCheckLabel3:SetText("Muichiro Tokito: 🔴")
                        elseif i == "Swampy" and not v then
                            BossCheckLabel4:SetText("Swampy: 🔴")
                        elseif i == "Akeza" and not v then
                            BossCheckLabel5:SetText("Akeza: 🔴")
                        elseif i == "Rengoku" and not v then
                            BossCheckLabel6:SetText("Rengoku: 🔴")
                        end
                    elseif World == 1 then
                        if i == "Sabito" and v then
                            BossCheckLabel:SetText("Sabito: 🟢")
                        elseif i == "Zanegutsu Kuuchie" and v then
                            BossCheckLabel1:SetText("Zanegutsu Kuuchie: 🟢")
                        elseif i == "Shiron" and v then
                            BossCheckLabel2:SetText("Shiron: 🟢")
                        elseif i == "Sanemi" and v then
                            BossCheckLabel3:SetText("Sanemi: 🟢")
                        elseif i == "Giyu" and v then
                            BossCheckLabel4:SetText("Giyu: 🟢")
                        elseif i == "Nezuko" and v then
                            BossCheckLabel5:SetText("Nezuko: 🟢")
                        elseif i == "Yahaba" and v then
                            BossCheckLabel6:SetText("Yahaba: 🟢")
                        elseif i == "Susamaru" and v then
                            BossCheckLabel7:SetText("Susamaru: 🟢")
                        elseif i == "Slasher" and v then
                            BossCheckLabel8:SetText("Slasher: 🟢")
                        elseif i == "Bandit Zuko" and v then
                            BossCheckLabel9:SetText("Bandit Zuko: 🟢")

                        elseif i == "Sabito" and not v then
                            BossCheckLabel:SetText("Sabito: 🔴")
                        elseif i == "Zanegutsu Kuuchie" and not v then
                            BossCheckLabel1:SetText("Zanegutsu Kuuchie: 🔴")
                        elseif i == "Shiron" and not v then
                            BossCheckLabel2:SetText("Shiron: 🔴")
                        elseif i == "Sanemi" and not v then
                            BossCheckLabel3:SetText("Sanemi: 🔴")
                        elseif i == "Giyu" and not v then
                            BossCheckLabel4:SetText("Giyu: 🔴")
                        elseif i == "Nezuko" and not v then
                            BossCheckLabel5:SetText("Nezuko: 🔴")
                        elseif i == "Yahaba" and not v then
                            BossCheckLabel6:SetText("Yahaba: 🔴")
                        elseif i == "Susamaru" and not v then
                            BossCheckLabel7:SetText("Susamaru: 🔴")
                        elseif i == "Slasher" and not v then
                            BossCheckLabel8:SetText("Slasher: 🔴")
                        elseif i == "Bandit Zuko" and not v then
                            BossCheckLabel9:SetText("Bandit Zuko: 🔴")
                        end
                    end
                end
        end)
    end
end)
MainC1:AddToggle('DemonsFarm', {Text = 'Farm All Demons',Default = Settings.DemonsFarm,Tooltip = 'Farm All Demons'})
Toggles.DemonsFarm:OnChanged(function()
    Settings.DemonsFarm = Toggles.DemonsFarm.Value
end)
MainC3:AddDropdown('FarmMethod', {Values = {"Fists","Sword","Scythe","Claws"}, Default = 1, Multi = false, Text = 'Farm Method', Tooltip = 'Select farm method, it will up mastery on the selected one'})
    Options.FarmMethod:OnChanged(function()
        Settings.KillAura.TypeSelected = Options.FarmMethod.Value
    end)
MainC3:AddToggle('BringMob', {Text = 'Bring Mob',Default = Settings.BringMob,Tooltip = 'Always bring the mob when farming'})
Toggles.BringMob:OnChanged(function()
    Settings.BringMob = Toggles.BringMob.Value
end)

MainCr:AddToggle('NoSunDmg', {Text = 'No Sun Damage',Default = Settings.NoSunDmg,Tooltip = 'Dont recive damage from sun as a demon'})
Toggles.NoSunDmg:OnChanged(function()
    Settings.NoSunDmg = Toggles.NoSunDmg.Value
    game:GetService("Players").LocalPlayer.PlayerScripts["Small_Scripts"].Gameplay["Sun_Damage"].Disabled = Settings.NoSunDmg
end)
MainCr:AddToggle('AutoChest', {Text = 'Auto Loot Chests',Default = Settings.AutoLootChest,Tooltip = 'Auto Loot Boss Chests'})
Toggles.AutoChest:OnChanged(function()
    Settings.AutoLootChest = Toggles.AutoChest.Value
end)

local Villages = {
    ["Kiribating Village"] = CFrame.new(120.362045, 282.207642, -1743.01636, 0.999990761, 2.85735684e-08, 0.00429180823, -2.90243012e-08, 1, 1.04959462e-07, -0.00429180823, -1.0508306e-07, 0.999990761),
    ["Zapiwara Cave [Demon Art Spins]"] = CFrame.new(-38.216156, 275.869537, -2403.53711, -0.244779825, 1.40672629e-08, 0.969578683, -3.9969752e-08, 1, -2.45993981e-08, -0.969578683, -4.47752555e-08, -0.244779825),
    ["Ushumaro Village"] = CFrame.new(-90.0373688, 354.723511, -3170.00439, 0.817297578, -1.0121405e-08, 0.576215804, 3.12666586e-08, 1, -2.6782951e-08, -0.576215804, 3.99059843e-08, 0.817297578),
    ["Butterfly Mansion"] = CFrame.new(3001.71753, 316.000519, -3806.40601, -0.998922288, -7.88841792e-09, -0.0464141443, -9.13921649e-09, 1, 2.67364477e-08, 0.0464141443, 2.71318221e-08, -0.998922288),
    ["Final Selection"] = CFrame.new(5258.51709, 365.857056, -2422.04443, 0.0163344685, -1.36483918e-08, -0.999866605, -6.17656548e-09, 1, -1.37511176e-08, 0.999866605, 6.40035847e-09, 0.0163344685),
    ["Zapiwara Mountain"] = CFrame.new(-366.581635, 425.857422, -2371.77124, -0.998583674, -7.39169579e-08, 0.0532043427, -7.35017522e-08, 1, 9.76061187e-09, -0.0532043427, 5.8361751e-09, -0.998583674),
    ["Wind Trainer"] = CFrame.new(1797.46521, 334.100983, -3466.552, 0.99727422, 7.59257635e-09, -0.0737840235, -2.28731412e-09, 1, 7.19870812e-08, 0.0737840235, -7.16220967e-08, 0.99727422),
    ["Kabiwaru Village"] = CFrame.new(2015.54297, 315.908813, -3051.2251, -0.956531584, -6.76903866e-08, -0.291628718, -6.4477355e-08, 1, -2.0628141e-08, 0.291628718, -9.2802005e-10, -0.956531584),
    ["Waroru Cave"] = CFrame.new(689.451843, 261.933289, -2469.948, -0.990007997, -2.02267403e-09, -0.141011208, 3.4283596e-09, 1, -3.8413809e-08, 0.141011208, -3.85134129e-08, -0.990007997),
    ["Ouwbayashi Home"] = CFrame.new(1241.24353, 320.429382, -4568.84521, 0.0538635328, 2.40611175e-08, -0.998548329, -7.93333221e-09, 1, 2.36681608e-08, 0.998548329, 6.64696431e-09, 0.0538635328),
    ["Dangerous Woods"] = CFrame.new(3839.87256, 342.214478, -4177.88428, 0.99924922, -3.67285011e-08, 0.0387428068, 3.67143471e-08, 1, 1.07676823e-09, -0.0387428068, 3.46457113e-10, 0.99924922)
};
local Breaths = {
    ["Urokodaki - Water"] = CFrame.new(705.209229, 261.426819, -2409.51587, -0.566798735, -5.48522401e-08, -0.641887605, -7.38932258e-08, 1, 2.8182352e-09, 0.641887605, 4.95921633e-08, -0.566798735),
    ["Shinobo - Insect"] = CFrame.new(2873.81177, 316.95871, -3917.9397, 0.40715313, 4.81208531e-08, 0.91335988, -8.85969982e-08, 1, -1.31911939e-08, -0.91335988, -7.55501048e-08, 0.40715313),
    ["Kuwajima - Lightning"] = CFrame.new(-322.369507, 426.857788, -2384.4021, 0.361198723, -4.49157973e-08, -0.932488859, 1.14233451e-07, 1, -3.91942434e-09, 0.932488859, -1.05105727e-07, 0.361198723),
    ["Jinger - Wind"] = CFrame.new(1792.31458, 334.338989, -3521.31104, 0.862527311, -5.19402583e-08, -0.506010473, 8.30083167e-08, 1, 3.88463874e-08, 0.506010473, -7.55091492e-08, 0.862527311)
};

MainT:AddDropdown('LocationsDropDown', {Values = {"Kiribating Village","Zapiwara Cave [Demon Art Spins]","Ushumaro Village","Butterfly Mansion","Final Selection","Zapiwara Mountain","Wind Trainer","Kabiwaru Village","Waroru Cave","Ouwbayashi Home","Dangerous Woods"}, Default = 1, Multi = false, Text = 'Locations', Tooltip = 'Select were to go'})
Options.LocationsDropDown:OnChanged(function()
    Settings.SelectedLocation = Options.LocationsDropDown.Value
end)
MainT:AddButton("Tween", function()
    if Tween then Tween:Cancel() Tween = nil end
    TeleportTween(Villages[Settings.SelectedLocation])
end)

MainT1:AddDropdown('BreathLocationsDropDown', {Values = {"Urokodaki - Water","Shinobo - Insect","Kuwajima - Lightning","Jinger - Wind"}, Default = 1, Multi = false, Text = 'Breath Locations', Tooltip = 'Select were to go'})
Options.BreathLocationsDropDown:OnChanged(function()
    Settings.SelectedBreathLocation = Options.BreathLocationsDropDown.Value
end)
MainT1:AddButton("Tween", function()
    if Tween then Tween:Cancel() Tween = nil end
    TeleportTween(Breaths[Settings.SelectedBreathLocation])
end)
MainTr:AddButton("Stop Tween", function()
    if Tween then Tween:Cancel() Tween = nil end
end)
if World == 1 then
MainTele:AddButton("Server Hop (Low Players)", function()
    game:GetService("TeleportService"):TeleportCancel()
    Module:Teleport(game.PlaceId)
end)
MainTele:AddButton("Second Word (Low Players)", function()
    game:GetService("TeleportService"):TeleportCancel()
    Module:Teleport(11468159863)
end)
elseif World == 2 then
MainTele:AddButton("First World (Low Players)", function()
    game:GetService("TeleportService"):TeleportCancel()
    Module:Teleport(6152116144)
end)
MainTele:AddButton("Server Hop (Low Players)", function()
    game:GetService("TeleportService"):TeleportCancel()
    Module:Teleport(game.PlaceId)
end)
end
MainTele:AddDivider()
if World == 1 then
MainTele:AddButton("Server Hop (Normal)", function()
game:GetService("TeleportService"):TeleportCancel()
game:GetService("TeleportService"):Teleport(game.PlaceId, Plr)
end)
MainTele:AddButton("Second Word (Normal)", function()
    game:GetService("TeleportService"):TeleportCancel()
    game:GetService("TeleportService"):Teleport(11468159863, Plr)
end)
elseif World == 2 then
MainTele:AddButton("First Word (Normal)", function()
    game:GetService("TeleportService"):TeleportCancel()
    game:GetService("TeleportService"):Teleport(6152116144, Plr)
    end)
MainTele:AddButton("Server Hop (Normal)", function()
    game:GetService("TeleportService"):TeleportCancel()
    game:GetService("TeleportService"):Teleport(game.PlaceId, Plr)
end)
end
--Player Visuals
local PlayerESPsToggle = MainP:AddToggle('PlayerESPsToggle', {Text = "Toggle ESP's",Default = ESPSettings.PlayerESP.Enabled,Tooltip = 'Show other players trought walls'})
Toggles.PlayerESPsToggle:OnChanged(function()
    ESPSettings.PlayerESP.Enabled = Toggles.PlayerESPsToggle.Value
	LibraryESP.Tracers = ESPSettings.PlayerESP.TracersOn
	LibraryESP.Names = ESPSettings.PlayerESP.NamesOn
	LibraryESP.Health = ESPSettings.PlayerESP.HealthOn
	LibraryESP.Distance = ESPSettings.PlayerESP.DistanceOn
	LibraryESP.Tool = ESPSettings.PlayerESP.ToolOn
	LibraryESP.Boxes = ESPSettings.PlayerESP.BoxesOn
	LibraryESP.FaceCamera = ESPSettings.PlayerESP.FaceCamOn
	LibraryESP:Toggle(ESPSettings.PlayerESP.Enabled)
end)

PlayerESPsToggle:AddKeyPicker("PlayerESPsToggle Keybind",{Default = 'None',SyncToggleState = true, Mode = 'Toggle',Text = 'Players Esp',NoUI = false})

MainP:AddSlider('ESPDistance', {Text = 'ESP Distance',Default = ESPSettings.PlayerESP.Distance,Min = 0,Max = 2000,Rounding = 2,Compact = false})
Options.ESPDistance:OnChanged(function()
	LibraryESP.DistanceS = Options.ESPDistance.Value
	ESPSettings.PlayerESP.Distance = Options.ESPDistance.Value
end)

local BoxColor = MainP:AddToggle('BoxesES', {Text = "Boxes",Default = ESPSettings.PlayerESP.BoxesOn})
Toggles.BoxesES:OnChanged(function()
	ESPSettings.PlayerESP.BoxesOn = Toggles.BoxesES.Value
	LibraryESP.Boxes = ESPSettings.PlayerESP.BoxesOn
end)


BoxColor:AddColorPicker('BoxESColor', {Default = ESPSettings.PlayerESP.Colors.BoxColor,Title = 'RGB'})
Options.BoxESColor:OnChanged(function()
    ESPSettings.PlayerESP.Colors.BoxColor = Options.BoxESColor.Value
end)

local TracerColor = MainP:AddToggle('TracersES', {Text = "Tracers",Default = ESPSettings.PlayerESP.TracersOn})
Toggles.TracersES:OnChanged(function()
	ESPSettings.PlayerESP.TracersOn = Toggles.TracersES.Value
	LibraryESP.Tracers = ESPSettings.PlayerESP.TracersOn
end)

TracerColor:AddColorPicker('TracersESColor', {Default = ESPSettings.PlayerESP.Colors.TracerColor,Title = 'RGB'})
Options.TracersESColor:OnChanged(function()
    ESPSettings.PlayerESP.Colors.TracerColor = Options.TracersESColor.Value
end)

local NameColor = MainP:AddToggle('NameES', {Text = "Name",Default = ESPSettings.PlayerESP.NamesOn})
Toggles.NameES:OnChanged(function()
	ESPSettings.PlayerESP.NamesOn = Toggles.NameES.Value
	LibraryESP.Names = ESPSettings.PlayerESP.NamesOn
end)

NameColor:AddColorPicker('NameESColor', {Default = ESPSettings.PlayerESP.Colors.NameColor,Title = 'RGB'})
Options.NameESColor:OnChanged(function()
    ESPSettings.PlayerESP.Colors.NameColor = Options.NameESColor.Value
end)

local HealthColor = MainP:AddToggle('HealthES', {Text = "Health",Default = ESPSettings.PlayerESP.HealthOn})
Toggles.HealthES:OnChanged(function()
	ESPSettings.PlayerESP.HealthOn = Toggles.HealthES.Value
	LibraryESP.Health = ESPSettings.PlayerESP.HealthOn
end)

HealthColor:AddColorPicker('HealthESColor', {Default = ESPSettings.PlayerESP.Colors.HealthColor,Title = 'RGB'})
Options.HealthESColor:OnChanged(function()
    ESPSettings.PlayerESP.Colors.HealthColor = Options.HealthESColor.Value
end)

local DistanceColor = MainP:AddToggle('DistanceES', {Text = "Distance",Default = ESPSettings.PlayerESP.DistanceOn})
Toggles.DistanceES:OnChanged(function()
	ESPSettings.PlayerESP.DistanceOn = Toggles.DistanceES.Value
	LibraryESP.Distance = ESPSettings.PlayerESP.DistanceOn
end)

DistanceColor:AddColorPicker('DistanceESColor', {Default = ESPSettings.PlayerESP.Colors.DistanceColor,Title = 'RGB'})
Options.DistanceESColor:OnChanged(function()
    ESPSettings.PlayerESP.Colors.DistanceColor = Options.DistanceESColor.Value
end)

local ToolColor = MainP:AddToggle('ToolES', {Text = "Tool",Default = ESPSettings.PlayerESP.ToolOn})
Toggles.ToolES:OnChanged(function()
	ESPSettings.PlayerESP.ToolOn = Toggles.ToolES.Value
	LibraryESP.Tool = ESPSettings.PlayerESP.ToolOn
end)

ToolColor:AddColorPicker('ToolESColor', {Default = ESPSettings.PlayerESP.Colors.ToolColor,Title = 'RGB'})
Options.ToolESColor:OnChanged(function()
    ESPSettings.PlayerESP.Colors.ToolColor = Options.ToolESColor.Value
end)

MainP:AddToggle('FaceCamES', {Text = "FaceCam",Default = ESPSettings.PlayerESP.FaceCamOn})
Toggles.FaceCamES:OnChanged(function()
	ESPSettings.PlayerESP.FaceCamOn = Toggles.FaceCamES.Value
	LibraryESP.FaceCamera = ESPSettings.PlayerESP.FaceCamOn
end)
--
MainC:AddLabel("Owner - Tupi")

MainUI:AddButton('Unload', function() Library:Unload() end)
MainUI:AddLabel('Ui Toggler'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true, Text = 'Ui Toggler' }) 

Library.ToggleKeybind = Options.MenuKeybind
RunService.Stepped:Connect(function()
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
