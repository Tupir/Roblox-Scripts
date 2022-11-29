loadstring(game:HttpGet("https://raw.githubusercontent.com/miguel831/Roblox-Scripts/main/SSHub/Testing.lua", true))()
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
    AutoEatSoul = false,
    FarmAllBosses = false,
    FarmAllBossesType = "",
    SelectedDemons = "",
    DemonsFarm = false,
    BringMob = false,
    FarmAltitude = 90,
    InfStamina = false,
    InfBreath = false,
    NearestEnemyFarm = false,
    ShowChatLogs = true,
    AliveBossesList = false
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

    local function TableRemove(Table, Item)
        local Index = nil
        for i, v in ipairs (Table) do 
            if (v == Item) then
                Index = i 
            end
        end
    table.remove(Table, Index)
    end

    local function NoclipF()
        for i, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") and v.CanCollide == true then
                v.CanCollide = false
                Plr.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
            end
        end
    end

    local Tween
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
        local NoFall
        if not Plr.Character.HumanoidRootPart:FindFirstChild("BodyVelocity") then
            NoFall = Instance.new("BodyVelocity", Plr.Character.HumanoidRootPart)
            NoFall.Velocity = Vector3.new(0, 0, 0)
        end
        local Noclip = nil
        Noclip = game:GetService("RunService").Stepped:Connect(NoclipF) 
        Tween:Play()
        Tween.Completed:wait()
        pcall(function()
            Tween = nil
            NoFall:Destroy()
            Noclip:Disconnect()
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
    coroutine.wrap(function()
        while task.wait() do
            if Settings.KillAura.Enabled then
                if not Settings.PlrDied and Plr.Character:FindFirstChild("HumanoidRootPart") and Plr.Character:FindFirstChild("Humanoid") then
                    if Settings.KillAura.TypeSelected == "Fists" then
                        Hitting=true
                        wait(.1)
                        game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S_:InvokeServer(unpack(args(1,"fist_combat", 7)))
                        for i = 1, 7 do
                            game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S:FireServer(unpack(args(1,"fist_combat", 7)))
                            game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S:FireServer(unpack(args(2,"fist_combat", 919)))
                        end
                        wait(.1)
                        Hitting=false
                        wait(2)
                    elseif Settings.KillAura.TypeSelected == "Sword" then
                        Hitting=true
                        wait(.1)
                        game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S_:InvokeServer(unpack(args(1,"fist_combat", 7)))
                        for i = 1, 7 do
                            game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S:FireServer(unpack(args(1,"Sword_Combat_Slash", 7)))
                            game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S:FireServer(unpack(args(2,"Sword_Combat_Slash", 919)))
                        end
                        wait(.1)
                        Hitting=false
                        wait(2)
                    elseif Settings.KillAura.TypeSelected == "Scythe" then
                        Hitting=true
                        wait(.1)
                        game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S_:InvokeServer(unpack(args(1,"fist_combat", 7)))
                        for i = 1, 7 do
                            game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S:FireServer(unpack(args(1,"Scythe_Combat_Slash", 7)))
                            game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S:FireServer(unpack(args(2,"Scythe_Combat_Slash", 919)))
                        end
                        wait(.1)
                        Hitting=false
                        wait(2)
                    elseif Settings.KillAura.TypeSelected == "Claws" then
                        Hitting=true
                        wait(.1)
                        game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S_:InvokeServer(unpack(args(1,"fist_combat", 7)))
                        for i = 1, 7 do
                            game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S:FireServer(unpack(args(1,"claw_Combat_Slash", 7)))
                            game:GetService("ReplicatedStorage").Remotes.To_Server.Handle_Initiate_S:FireServer(unpack(args(2,"claw_Combat_Slash", 919)))
                        end
                        wait(.1)
                        Hitting=false
                        wait(2)
                    end
                end
            end
        end
    end)()

local World
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
        ["Renpeke"] = CFrame.new(-1201.97, 601.276, -627.884),
        ["Enme"] = CFrame.new(1598.01220703125, 483.6178283691406, -687.4105834960938),
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
        ["Nezuko"] = CFrame.new(3549.87,- 342.065, -4596.74),
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
        ["Inosuke"] = {Alive = false, MaxHealth = 1, Health = 1},
        ["Renpeke"] = {Alive = false, MaxHealth = 1, Health = 1},
        ["Enme"] = {Alive = false, MaxHealth = 1, Health = 1},
        ["Muichiro Tokito"] = {Alive = false, MaxHealth = 1, Health = 1},
        ["Swampy"] = {Alive = false, MaxHealth = 1, Health = 1},
        ["Akeza"] = {Alive = false, MaxHealth = 1, Health = 1},
        ["Rengoku"] = {Alive = false, MaxHealth = 1, Health = 1}
    }
    BossCheck = Second
elseif World == 1 then
    local First = {
        ["Sabito"] = {Alive = false, MaxHealth = 1, Health = 1},
        ["Zanegutsu Kuuchie"] = {Alive = false, MaxHealth = 1, Health = 1},
        ["Shiron"] = {Alive = false, MaxHealth = 1, Health = 1},
        ["Sanemi"] = {Alive = false, MaxHealth = 1, Health = 1},
        ["Giyu"] = {Alive = false, MaxHealth = 1, Health = 1},
        ["Nezuko"] = {Alive = false, MaxHealth = 1, Health = 1},
        ["Yahaba"] = {Alive = false, MaxHealth = 1, Health = 1},
        ["Susamaru"] = {Alive = false, MaxHealth = 1, Health = 1},
        ["Slasher"] = {Alive = false, MaxHealth = 1, Health = 1},
        ["Bandit Zuko"] = {Alive = false, MaxHealth = 1, Health = 1}
    }
    BossCheck = First
end
    
Plr.Character:WaitForChild("Humanoid").Died:Connect(function()
    Settings.PlrDied = true
end)

Plr.CharacterAdded:Connect(function()
    Settings.PlrDied = false
end)

local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    wait(1)
    vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

coroutine.wrap(function()
    while task.wait() do
        pcall(function()
                for _,v in pairs(game:GetService("Workspace").Mobs.Bosses:GetDescendants()) do
                    if v:IsA("Humanoid") then
                        v = v.Parent
                        for i2,v2 in pairs(BossCheck) do
                            if string.match(v.Name,i2) then
                                if v.Humanoid.Health > 1 then
                                    BossCheck[v.Name].MaxHealth = v.Humanoid.MaxHealth
                                    BossCheck[v.Name].Health = math.round(v.Humanoid.Health)
                                end
                                if v.Humanoid.Health > 0 then
                                    BossCheck[v.Name].Alive = true
                                else
                                    BossCheck[v.Name].Alive = false
                                end
                            end
                        end
                    end
                end
                if Settings.AutoEatSoul then
                    local Debree = game:GetService("Workspace").Debree
                    for _,v in next, Debree:GetChildren() do
                        if string.match(v.Name, "Soul") then
                            local mag = (Plr.Character.HumanoidRootPart.Position - v.Handle.Position).Magnitude
                            if mag < 200 then
                                local remote = v.Handle:WaitForChild("Eatthedamnsoul")
                                remote:FireServer()
                            end
                        end
                    end
                end
                if Settings.AutoLootChest then
                    local Debree = game:GetService("Workspace").Debree
                    for _,v in next, Debree:GetChildren() do
                        if string.match(v.Name, "Loot_Chest") then
                            local mag = (Plr.Character.HumanoidRootPart.Position - v.Root.Position).Magnitude
                            if mag < 200 then
                                if v and #v:WaitForChild("Drops"):GetChildren() > 0 then
                                    local Remote = v:WaitForChild("Add_To_Inventory")
                                    for _,v2 in next, v:WaitForChild("Drops"):GetChildren() do
                                        if string.find(v2.Name, "Ore") or string.find(v2.Name, "Elixir") then
                                            Remote:InvokeServer(v2.Name)
                                        elseif not game:GetService("ReplicatedStorage")["Player_Data"][Plr.Name].Inventory:FindFirstChild(v2.Name, true) then
                                            Remote:InvokeServer(v2.Name)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                if Settings.InfStamina then
                    getrenv()._G:Stamina(-9e9)
                end
                if Settings.InfBreath then
                    getrenv()._G:Breath(-9e9)
                end
        end)
    end
end)()
local function ClosestCivilian()
    local Target = nil; local magn = math.huge
    for i,v in pairs(game:GetService("Workspace").Mobs:GetDescendants()) do
        if v:IsA("Humanoid") then
            v = v.Parent
            if string.find(v.Name, "Civilian") then
                local mag = (Plr.Character.HumanoidRootPart.Position - v.Humanoid.WalkToPoint).Magnitude
                if mag < magn then 
                    magn = mag 
                    Target = v
                end
            end
        end
    end
    return Target
end
local function ClosestDemon()
    local Target = nil; local magn = math.huge
    for i,v in pairs(game:GetService("Workspace").Mobs:GetDescendants()) do
        if v:IsA("Humanoid") then
            v = v.Parent
            if string.find(v.Name, "Demon") then
                local mag = (Plr.Character.HumanoidRootPart.Position - v.Humanoid.WalkToPoint).Magnitude
                if mag < magn then 
                    magn = mag 
                    Target = v
                end
            end
        end
    end
    return Target
end
local function ClosestEnemy()
    local Target = nil; local magn = math.huge
    for i,v in pairs(game:GetService("Workspace").Mobs:GetDescendants()) do
        if v:IsA("Humanoid") then
            v = v.Parent
            local mag = (Plr.Character.HumanoidRootPart.Position - v.Humanoid.WalkToPoint).Magnitude
            if mag < magn then 
                magn = mag 
                Target = v
            end
        end
    end
    return Target
end
local function ClosestBoss()
    local Target = nil; local magn = math.huge
    for i,v in pairs(game:GetService("Workspace").Mobs.Bosses:GetDescendants()) do
        if v:IsA("Humanoid") then
            v = v.Parent
            local mag = (Plr.Character.HumanoidRootPart.Position - v.Humanoid.WalkToPoint).Magnitude
            if mag < magn then 
                magn = mag 
                Target = v
            end
        end
    end
    return Target, Bosses[Target.Name]
end

coroutine.wrap(function()
    while task.wait() do
        pcall(function()
            if Settings.NearestEnemyFarm then
                local Enemy = ClosestEnemy()
                if not Enemy:FindFirstChild("HumanoidRootPart") and Enemy:FindFirstChild("Humanoid") and Enemy.Humanoid.Health > 0 and not Settings.PlrDied then             
                    if Tween then Tween:Cancel() Tween = nil end
                    TeleportTween(CFrame.new(Enemy.Humanoid.WalkToPoint))
                end
                if Settings.NearestEnemyFarm and Enemy:FindFirstChild("HumanoidRootPart") and Enemy:FindFirstChild("Humanoid") and Enemy.Humanoid.Health > 0 and not Settings.PlrDied then
                    if Tween then Tween:Cancel() Tween = nil end
                    TeleportTween(Enemy.HumanoidRootPart.CFrame)
                    local NoFall = Instance.new("BodyVelocity", Plr.Character.HumanoidRootPart)
                    NoFall.Velocity = Vector3.new(0, 0, 0)
                    local Noclip = nil
                    Noclip = game:GetService("RunService").Stepped:Connect(NoclipF) 
                    Settings.KillAura.Enabled = true
                    local FarmingPos = Enemy.HumanoidRootPart.CFrame
                    while task.wait() and Settings.NearestEnemyFarm and Enemy.Humanoid:IsDescendantOf(workspace) and Enemy.Humanoid.Health > 0 and not Settings.PlrDied do
                        pcall(function()
                            if Enemy.Humanoid and Enemy.Humanoid:IsDescendantOf(workspace) and Enemy.Humanoid.Health > 0 and not Settings.PlrDied then
                                if Settings.BringMob then
                                    Enemy.HumanoidRootPart.CFrame = FarmingPos
                                end
                                if not Hitting and Settings.NearestEnemyFarm then
                                    Plr.Character.HumanoidRootPart.CFrame = Enemy.HumanoidRootPart.CFrame*CFrame.new(0,Settings.FarmAltitude,0)
                                elseif Hitting and Settings.NearestEnemyFarm then
                                    Plr.Character.HumanoidRootPart.CFrame = Enemy.HumanoidRootPart.CFrame*CFrame.new(0, 7, 0)*CFrame.Angles(math.rad(-90), 0, 0)
                                end
                            elseif not Enemy.Humanoid:IsDescendantOf(workspace) or Enemy.Humanoid.Health <= 0 or Settings.PlrDied then
                                Settings.KillAura.Enabled = false
                                FarmingPos = nil
                                if Settings.AutoLootChest == true or Settings.AutoEatSoul == true then
                                    Noclip:Disconnect()
                                    NoFall:Destroy()
                                    wait(1)
                                end
                            end
                        end)
                    end
                    if not Settings.NearestEnemyFarm or Settings.PlrDied then
                        Settings.KillAura.Enabled = false
                        FarmingPos = nil
                        Noclip:Disconnect()
                        NoFall:Destroy()
                    end
                end
            end
        end)
    end
end)()
--Selected Boss
local SelectedBossFarm = "Waiting..."
coroutine.wrap(function()
    while task.wait() do
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

                                                local NoFall = Instance.new("BodyVelocity", Plr.Character.HumanoidRootPart)
                                                NoFall.Velocity = Vector3.new(0, 0, 0)
                                                local Noclip = nil
                                                Noclip = game:GetService("RunService").Stepped:Connect(NoclipF) 
                                                
                                                Settings.KillAura.Enabled = true
                                                local FarmingPos = v.HumanoidRootPart.CFrame
                                                while task.wait() and Settings.SelectedBossFarm and not Settings.FarmAllBosses and v.Humanoid:IsDescendantOf(workspace) and v.Humanoid.Health > 0 and not Settings.PlrDied and string.match(v.Name, Settings.SelectedBoss) do
                                                        
                                                            pcall(function()
                                                                if Settings.SelectedBossFarm and not Settings.FarmAllBosses and v.Humanoid and v.Humanoid:IsDescendantOf(workspace) and v.Humanoid.Health > 0 and not Settings.PlrDied then
                                                                    if Settings.BringMob then
                                                                        v.HumanoidRootPart.CFrame = FarmingPos
                                                                    end
                                                                    if not Hitting and Settings.SelectedBossFarm and not Settings.FarmAllBosses then
                                                                        Plr.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame*CFrame.new(0,Settings.FarmAltitude,0)
                                                                    elseif Hitting and Settings.SelectedBossFarm and not Settings.FarmAllBosses then
                                                                        Plr.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame*CFrame.new(0, 7, 0)*CFrame.Angles(math.rad(-90), 0, 0)
                                                                    end
                                                                elseif not Settings.SelectedBossFarm or not v.Humanoid:IsDescendantOf(workspace) or v.Humanoid.Health <= 0 or Settings.PlrDied or Settings.FarmAllBosses or not string.match(v.Name, Settings.SelectedBoss) then
                                                                    Settings.KillAura.Enabled = false
                                                                    FarmingPos = nil
                                                                    if Settings.AutoLootChest == true then
                                                                        Noclip:Disconnect()
                                                                        NoFall:Destroy()
                                                                        wait(1)
                                                                    end
                                                                end
                                                            end)

                                                end
                                                if not Settings.SelectedBossFarm or not v.Humanoid:IsDescendantOf(workspace) or v.Humanoid.Health <= 0 or Settings.PlrDied or Settings.FarmAllBosses or not string.match(v.Name, Settings.SelectedBoss) then
                                                    Settings.KillAura.Enabled = false
                                                    FarmingPos = nil
                                                    Noclip:Disconnect()
                                                    NoFall:Destroy()
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
end)()
--All Bosses
local FarmAllBosses = "Waiting..."

coroutine.wrap(function()
    while task.wait() do
        pcall(function()
            if Settings.FarmAllBosses then
                if Settings.FarmAllBossesType == "List" and Settings.FarmAllBosses then
                    for i,v in pairs(game:GetService("Workspace").Mobs.Bosses:GetDescendants()) do
                        if v:IsA("Humanoid") then
                            v = v.Parent
                            for i2,v2 in pairs(Bosses) do
                                if string.find(i2, v.Name) then
                                    if not v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and not Settings.PlrDied then
                                        if Tween then Tween:Cancel() Tween = nil end
                                        TeleportTween(v2)
                                    end
                                    if v:FindFirstChild("HumanoidRootPart") and v.Humanoid and v.Humanoid.Health > 0 and not Settings.PlrDied and Settings.FarmAllBosses and Settings.FarmAllBossesType == "List" then
                                        if Tween then Tween:Cancel() Tween = nil end
                                        TeleportTween(v.HumanoidRootPart.CFrame)
                                        local NoFall = Instance.new("BodyVelocity", Plr.Character.HumanoidRootPart)                     
                                        NoFall.Velocity = Vector3.new(0, 0, 0)
                                        local Noclip = nil
                                        Noclip = game:GetService("RunService").Stepped:Connect(NoclipF) 
                                        Settings.KillAura.Enabled = true
                                        local FarmingPos = v.HumanoidRootPart.CFrame
                                        while task.wait() and Settings.FarmAllBosses and v.Humanoid and v.Humanoid:IsDescendantOf(workspace) and v.Humanoid.Health > 0 and not Settings.PlrDied and Settings.FarmAllBossesType == "List"  do
                                            pcall(function()
                                                if Settings.FarmAllBosses and v.Humanoid and v.Humanoid:IsDescendantOf(workspace) and v.Humanoid.Health > 0 and not Settings.PlrDied then
                                                    if Settings.BringMob then
                                                        v.HumanoidRootPart.CFrame = FarmingPos
                                                    end
                                                    if not Hitting and Settings.FarmAllBosses then
                                                        Plr.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame*CFrame.new(0,Settings.FarmAltitude,0)
                                                    elseif Hitting and Settings.FarmAllBosses then
                                                        Plr.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame*CFrame.new(0, 7, 0)*CFrame.Angles(math.rad(-90), 0, 0)
                                                    end
                                                elseif not v.Humanoid:IsDescendantOf(workspace) or v.Humanoid.Health <= 0 or Settings.PlrDied then
                                                    Settings.KillAura.Enabled = false
                                                    FarmingPos = nil
                                                    if Settings.AutoLootChest then
                                                        Noclip:Disconnect()
                                                        NoFall:Destroy()
                                                        wait(1)
                                                    end
                                                end
                                            end)
                                        end
                                        if not Settings.FarmAllBosses or Settings.PlrDied or Settings.FarmAllBossesType == "Closest" then
                                            Settings.KillAura.Enabled = false
                                            FarmingPos = nil
                                            Noclip:Disconnect()
                                            NoFall:Destroy()
                                        end
                                    end
                                end
                            end
                        end
                    end
                elseif Settings.FarmAllBossesType == "Closest" and Settings.FarmAllBosses then
                    local Enemy, Pos = ClosestBoss()
                    if not Enemy:FindFirstChild("HumanoidRootPart") and Enemy:FindFirstChild("Humanoid") and Enemy.Humanoid.Health > 0 and not Settings.PlrDied then
                        if Tween then Tween:Cancel() Tween = nil end
                        TeleportTween(Pos)
                    end
                    if Enemy:FindFirstChild("HumanoidRootPart") and Enemy.Humanoid and Enemy.Humanoid.Health > 0 and not Settings.PlrDied and Settings.FarmAllBosses and Settings.FarmAllBossesType == "Closest" then
                        if Tween then Tween:Cancel() Tween = nil end
                        TeleportTween(Enemy.HumanoidRootPart.CFrame)
                        local NoFall = Instance.new("BodyVelocity", Plr.Character.HumanoidRootPart)                     
                        NoFall.Velocity = Vector3.new(0, 0, 0)
                        local Noclip = nil
                        Noclip = game:GetService("RunService").Stepped:Connect(NoclipF) 
                        Settings.KillAura.Enabled = true
                        local FarmingPos = Enemy.HumanoidRootPart.CFrame
                        while task.wait() and Settings.FarmAllBosses and Enemy.Humanoid and Enemy.Humanoid:IsDescendantOf(workspace) and Enemy.Humanoid.Health > 0 and not Settings.PlrDied and Settings.FarmAllBossesType == "Closest" do
                            pcall(function()
                                if Settings.FarmAllBosses and Enemy.Humanoid and Enemy.Humanoid:IsDescendantOf(workspace) and Enemy.Humanoid.Health > 0 and not Settings.PlrDied then
                                    if Settings.BringMob then
                                        Enemy.HumanoidRootPart.CFrame = FarmingPos
                                    end
                                    if not Hitting and Settings.FarmAllBosses then
                                        Plr.Character.HumanoidRootPart.CFrame = Enemy.HumanoidRootPart.CFrame*CFrame.new(0,Settings.FarmAltitude,0)
                                    elseif Hitting and Settings.FarmAllBosses then
                                        Plr.Character.HumanoidRootPart.CFrame = Enemy.HumanoidRootPart.CFrame*CFrame.new(0, 7, 0)*CFrame.Angles(math.rad(-90), 0, 0)
                                    end
                                elseif not Enemy.Humanoid:IsDescendantOf(workspace) or Enemy.Humanoid.Health <= 0 or Settings.PlrDied then
                                    Settings.KillAura.Enabled = false
                                    FarmingPos = nil
                                    if Settings.AutoLootChest == true then
                                        Noclip:Disconnect()
                                        NoFall:Destroy()
                                        wait(1)
                                    end
                                end
                            end)
                        end
                        if not Settings.FarmAllBosses or Settings.PlrDied or Settings.FarmAllBossesType == "List" then
                            Settings.KillAura.Enabled = false
                            FarmingPos = nil
                            Noclip:Disconnect()
                            NoFall:Destroy()
                        end
                    end
                end
            end
        end)
    end
end)()
--Demons
local DemonsFarm = "Waiting..."
coroutine.wrap(function()
    while task.wait() do
        pcall(function()
            if Settings.DemonsFarm then
                DemonsFarm = "Error"
            end
            if Settings.DemonsFarm then
                DemonsFarm = "Correct"
                local Enemy = ClosestDemon()
                    if Settings.DemonsFarm then
                        if not Enemy:FindFirstChild("HumanoidRootPart") and Enemy:FindFirstChild("Humanoid") and Enemy.Humanoid.Health > 0 and Settings.DemonsFarm then
                            if Tween then Tween:Cancel() Tween = nil end
                            TeleportTween(CFrame.new(Enemy.Humanoid.WalkToPoint))
                        end
                        if Enemy.HumanoidRootPart and Enemy.Humanoid and not Settings.PlrDied and Enemy.Humanoid.Health > 0 and Settings.DemonsFarm then
                            if Tween then Tween:Cancel() Tween = nil end
                            TeleportTween(Enemy.HumanoidRootPart.CFrame)
                            local NoFall = Instance.new("BodyVelocity", Plr.Character.HumanoidRootPart)
                            NoFall.Velocity = Vector3.new(0, 0, 0)
                            local Noclip = nil
                            Noclip = game:GetService("RunService").Stepped:Connect(NoclipF) 
                            Settings.KillAura.Enabled = true
                            local FarmingPos = Enemy.HumanoidRootPart.CFrame
                            while task.wait() and Settings.DemonsFarm and Enemy.Humanoid and Enemy.Humanoid:IsDescendantOf(workspace) and Enemy.Humanoid.Health > 0 and not Settings.PlrDied do
                                if Settings.DemonsFarm and Enemy.Humanoid and Enemy.Humanoid:IsDescendantOf(workspace) and Enemy.Humanoid.Health > 0 and not Settings.PlrDied then
                                    if Settings.BringMob then
                                        Enemy.HumanoidRootPart.CFrame = FarmingPos
                                    end
                                    if not Hitting and Settings.DemonsFarm then
                                        Plr.Character.HumanoidRootPart.CFrame = Enemy.HumanoidRootPart.CFrame*CFrame.new(0,Settings.FarmAltitude,0)
                                    elseif Hitting and Settings.DemonsFarm then
                                        Plr.Character.HumanoidRootPart.CFrame = Enemy.HumanoidRootPart.CFrame*CFrame.new(0, 7, 0)*CFrame.Angles(math.rad(-90), 0, 0)
                                    end
                                elseif not Enemy.Humanoid:IsDescendantOf(workspace) or Enemy.Humanoid.Health <= 0 or Settings.PlrDied then
                                    Settings.KillAura.Enabled = false
                                    FarmingPos = nil
                                end
                            end
                            if not Settings.DemonsFarm or not Enemy.Humanoid:IsDescendantOf(workspace) or Enemy.Humanoid.Health <= 0 or Settings.PlrDied then
                                Settings.KillAura.Enabled = false
                                FarmingPos = nil
                                Noclip:Disconnect()
                                NoFall:Destroy()
                            end
                        end
                    end
            end
        end)
    end
end)()
local CivilianFarm = "Waiting..."
coroutine.wrap(function()
    while task.wait() do
        pcall(function()
            if Settings.CivilianFarm then
                CivilianFarm = "Error"
            end
            if Settings.CivilianFarm then
                CivilianFarm = "Correct"
                local Enemy = ClosestCivilian()
                if Settings.CivilianFarm then
                    if not Enemy:FindFirstChild("HumanoidRootPart") and Enemy:FindFirstChild("Humanoid") and Enemy.Humanoid.Health > 0 and Settings.CivilianFarm then
                        if Tween then Tween:Cancel() Tween = nil end
                        TeleportTween(CFrame.new(Enemy.Humanoid.WalkToPoint))
                    end
                    if Enemy.HumanoidRootPart and Enemy.Humanoid and not Settings.PlrDied and Enemy.Humanoid.Health > 0 and Settings.CivilianFarm then
                        if Tween then Tween:Cancel() Tween = nil end
                        TeleportTween(Enemy.HumanoidRootPart.CFrame)
                        local NoFall = Instance.new("BodyVelocity", Plr.Character.HumanoidRootPart)
                        NoFall.Velocity = Vector3.new(0, 0, 0)
                        local Noclip = nil
                        Noclip = game:GetService("RunService").Stepped:Connect(NoclipF) 
                        Settings.KillAura.Enabled = true
                        local FarmingPos = Enemy.HumanoidRootPart.CFrame
                        while task.wait() and Settings.CivilianFarm and Enemy.Humanoid and Enemy.Humanoid:IsDescendantOf(workspace) and Enemy.Humanoid.Health > 0 and not Settings.PlrDied do
                            if Settings.CivilianFarm and Enemy.Humanoid and Enemy.Humanoid:IsDescendantOf(workspace) and Enemy.Humanoid.Health > 0 and not Settings.PlrDied then
                                if Settings.BringMob then
                                    Enemy.HumanoidRootPart.CFrame = FarmingPos
                                end
                                if not Hitting and Settings.CivilianFarm then
                                    Plr.Character.HumanoidRootPart.CFrame = Enemy.HumanoidRootPart.CFrame*CFrame.new(0,Settings.FarmAltitude,0)
                                elseif Hitting and Settings.CivilianFarm then
                                    Plr.Character.HumanoidRootPart.CFrame = Enemy.HumanoidRootPart.CFrame* CFrame.new(0, 0, -0.5)
                                end
                            elseif not Enemy.Humanoid:IsDescendantOf(workspace) or Enemy.Humanoid.Health <= 0 or Settings.PlrDied then
                                Settings.KillAura.Enabled = false
                                FarmingPos = nil
                                Noclip:Disconnect()
                                NoFall:Destroy()
                                if Settings.AutoEatSoul then
                                    wait(1)
                                end
                            end
                        end
                        if not Settings.CivilianFarm or not Enemy.Humanoid:IsDescendantOf(workspace) or Enemy.Humanoid.Health <= 0 or Settings.PlrDied then
                            Settings.KillAura.Enabled = false
                            FarmingPos = nil
                            Noclip:Disconnect()
                            NoFall:Destroy()
                        end
                    end
                end
            end
        end)
    end
end)()

local SShub = Library:CreateWindow({Title = Name.." | "..GameName.." | Script Req: Have Good Ethernet and Fps | Toggle: End",Center = true, AutoShow = true, Size = UDim2.fromOffset(635, 600)})
local Farm = SShub:AddTab("Farm & Mods")
local Visuals = SShub:AddTab("Visuals")
local Teleports = SShub:AddTab("Teleports")
local Settingss = SShub:AddTab("Settings")

local MainCoo = Farm:AddLeftTabbox("Farming")
local MainCo = MainCoo:AddTab("Bosses")
local MainC1 = MainCoo:AddTab("Demon & Npc")
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
    MainCo:AddDropdown('BossesDropdown', {Values = {"Inosuke","Renpeke","Enme","Muichiro Tokito","Swampy","Akeza","Rengoku"}, Default = 1, Multi = false, Text = 'Bosses', Tooltip = 'Select ur boss'})
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


MainC1:AddToggle('DemonsFarm', {Text = 'Farm All Demons',Default = Settings.DemonsFarm,Tooltip = 'Farm All Demons'})
Toggles.DemonsFarm:OnChanged(function()
    Settings.DemonsFarm = Toggles.DemonsFarm.Value
end)
local DemonsFarmLabel = MainC1:AddLabel("Status: Loading...")
MainC1:AddToggle('CivilianFarm', {Text = 'Farm All Civilian',Default = Settings.CivilianFarm,Tooltip = 'Farm All Civilian'})
Toggles.CivilianFarm:OnChanged(function()
    Settings.CivilianFarm = Toggles.CivilianFarm.Value
end)
local CivilianFarmLabel = MainC1:AddLabel("Status: Loading...")
MainC1:AddToggle('NearestEnemyFarm', {Text = 'Farms Nearest Enemy',Default = Settings.NearestEnemyFarm,Tooltip = 'Farm All Nearest Enemy'})
Toggles.NearestEnemyFarm:OnChanged(function()
    Settings.NearestEnemyFarm = Toggles.NearestEnemyFarm.Value
end)
MainC1:AddLabel("(Better for Mugen Train)")
MainCo:AddDivider()
MainCo:AddLabel("If autofarms dont working correctly u can go to\nOptions > Bring Mob it may will fix it a bit.\nBe sure no one is close to boss.\nU can try change farm altitude in Options too.",true)
MainCo:AddDivider()
local BreathCheck = MainCr:AddLabel("...")
local DemonCheck = MainCr:AddLabel("...")
MainC4:AddToggle('AliveBossesList', {Text = 'Update Alive Bosses List',Default = Settings.AliveBossesList,Tooltip = ''})
Toggles.AliveBossesList:OnChanged(function()
    Settings.AliveBossesList = Toggles.AliveBossesList.Value
end)
local BossCheckLabel
local BossCheckLabel1
local BossCheckLabel2
local BossCheckLabel3
local BossCheckLabel4
local BossCheckLabel5
local BossCheckLabel6
local BossCheckLabel7
local BossCheckLabel8
local BossCheckLabel9

if World == 1 then
    BossCheckLabel = MainC4:AddLabel("Loading...")
    BossCheckLabel1 = MainC4:AddLabel("Loading...")
    BossCheckLabel2 = MainC4:AddLabel("Loading...")
    BossCheckLabel3 = MainC4:AddLabel("Loading...")
    BossCheckLabel4 = MainC4:AddLabel("Loading...")
    BossCheckLabel5 = MainC4:AddLabel("Loading...")
    BossCheckLabel6 = MainC4:AddLabel("Loading...")
    BossCheckLabel7 = MainC4:AddLabel("Loading...")
    BossCheckLabel8 = MainC4:AddLabel("Loading...")
    BossCheckLabel9 = MainC4:AddLabel("Loading...")
elseif World == 2 then
    BossCheckLabel = MainC4:AddLabel("Loading...")
    BossCheckLabel1 = MainC4:AddLabel("Loading...")
    BossCheckLabel2 = MainC4:AddLabel("Loading...")
    BossCheckLabel3 = MainC4:AddLabel("Loading...")
    BossCheckLabel4 = MainC4:AddLabel("Loading...")
    BossCheckLabel5 = MainC4:AddLabel("Loading...")
    BossCheckLabel6 = MainC4:AddLabel("Loading...")
end

coroutine.wrap(function()
    while task.wait() do
        pcall(function()
            local Breath = game:GetService("ReplicatedStorage")["Player_Data"][Plr.Name].BreathingProgress
            local Demon = game:GetService("ReplicatedStorage")["Player_Data"][Plr.Name].DemonProgress
            BreathCheck:SetText("Breathing Progress: " .. Breath["1"].Value .. " / " .. Breath["2"].Value)
            DemonCheck:SetText("Demon Progress: " .. Demon["1"].Value .. " / " .. Demon["2"].Value)
            SelectedBossFarmLabel:SetText("Status: "..SelectedBossFarm)
            FarmAllBossesLabel:SetText("Status: "..FarmAllBosses)
            DemonsFarmLabel:SetText("Status: "..DemonsFarm)
            CivilianFarmLabel:SetText("Status: "..CivilianFarm)
            if Settings.AliveBossesList then
                for i,v in pairs(BossCheck) do
                    if World == 2 then
                        if i == "Inosuke" and v.Alive then
                            BossCheckLabel:SetText("Inosuke: 🟢 Health: ("..v.MaxHealth.."/"..v.Health..")")
                        elseif i == "Renpeke" and v.Alive then
                            BossCheckLabel1:SetText("Renpeke: 🟢 Health: ("..v.MaxHealth.."/"..v.Health..")")
                        elseif i == "Enme" and v.Alive then
                            BossCheckLabel2:SetText("Enme: 🟢 Health: ("..v.MaxHealth.."/"..v.Health..")")
                        elseif i == "Muichiro Tokito" and v.Alive then
                            BossCheckLabel3:SetText("Muichiro Tokito: 🟢 Health: ("..v.MaxHealth.."/"..v.Health..")")
                        elseif i == "Swampy" and v.Alive then
                            BossCheckLabel4:SetText("Swampy: 🟢 Health: ("..v.MaxHealth.."/"..v.Health..")")
                        elseif i == "Akeza" and v.Alive then
                            BossCheckLabel5:SetText("Akeza: 🟢 Health: ("..v.MaxHealth.."/"..v.Health..")")
                        elseif i == "Rengoku" and v.Alive then
                            BossCheckLabel6:SetText("Rengoku: 🟢 Health: ("..v.MaxHealth.."/"..v.Health..")")
                        elseif i == "Inosuke" and not v.Alive then
                            BossCheckLabel:SetText("Inosuke: 🔴")
                        elseif i == "Renpeke" and not v.Alive then
                            BossCheckLabel1:SetText("Renpeke: 🔴")
                        elseif i == "Enme" and not v.Alive then
                            BossCheckLabel2:SetText("Enme: 🔴")
                        elseif i == "Muichiro Tokito" and not v.Alive then
                            BossCheckLabel3:SetText("Muichiro Tokito: 🔴")
                        elseif i == "Swampy" and not v.Alive then
                            BossCheckLabel4:SetText("Swampy: 🔴")
                        elseif i == "Akeza" and not v.Alive then
                            BossCheckLabel5:SetText("Akeza: 🔴")
                        elseif i == "Rengoku" and not v.Alive then
                            BossCheckLabel6:SetText("Rengoku: 🔴")
                        end
                    elseif World == 1 then
                        if i == "Sabito" and v.Alive then
                            BossCheckLabel:SetText("Sabito: 🟢 Health: ("..v.MaxHealth.."/"..v.Health..")")
                        elseif i == "Zanegutsu Kuuchie" and v.Alive then
                            BossCheckLabel1:SetText("Zanegutsu Kuuchie: 🟢 Health: ("..v.MaxHealth.."/"..v.Health..")")
                        elseif i == "Shiron" and v.Alive then
                            BossCheckLabel2:SetText("Shiron: 🟢 Health: ("..v.MaxHealth.."/"..v.Health..")")
                        elseif i == "Sanemi" and v.Alive then
                            BossCheckLabel3:SetText("Sanemi: 🟢 Health: ("..v.MaxHealth.."/"..v.Health..")")
                        elseif i == "Giyu" and v.Alive then
                            BossCheckLabel4:SetText("Giyu: 🟢 Health: ("..v.MaxHealth.."/"..v.Health..")")
                        elseif i == "Nezuko" and v.Alive then
                            BossCheckLabel5:SetText("Nezuko: 🟢 Health: ("..v.MaxHealth.."/"..v.Health..")")
                        elseif i == "Yahaba" and v.Alive then
                            BossCheckLabel6:SetText("Yahaba: 🟢 Health: ("..v.MaxHealth.."/"..v.Health..")")
                        elseif i == "Susamaru" and v.Alive then
                            BossCheckLabel7:SetText("Susamaru: 🟢 Health: ("..v.MaxHealth.."/"..v.Health..")")
                        elseif i == "Slasher" and v.Alive then
                            BossCheckLabel8:SetText("Slasher: 🟢 Health: ("..v.MaxHealth.."/"..v.Health..")")
                        elseif i == "Bandit Zuko" and v.Alive then
                            BossCheckLabel9:SetText("Bandit Zuko: 🟢 Health: ("..v.MaxHealth.."/"..v.Health..")")
                        elseif i == "Sabito" and not v.Alive then
                            BossCheckLabel:SetText("Sabito: 🔴")
                        elseif i == "Zanegutsu Kuuchie" and not v.Alive then
                            BossCheckLabel1:SetText("Zanegutsu Kuuchie: 🔴")
                        elseif i == "Shiron" and not v.Alive then
                            BossCheckLabel2:SetText("Shiron: 🔴")
                        elseif i == "Sanemi" and not v.Alive then
                            BossCheckLabel3:SetText("Sanemi: 🔴")
                        elseif i == "Giyu" and not v.Alive then
                            BossCheckLabel4:SetText("Giyu: 🔴")
                        elseif i == "Nezuko" and not v.Alive then
                            BossCheckLabel5:SetText("Nezuko: 🔴")
                        elseif i == "Yahaba" and not v.Alive then
                            BossCheckLabel6:SetText("Yahaba: 🔴")
                        elseif i == "Susamaru" and not v.Alive then
                            BossCheckLabel7:SetText("Susamaru: 🔴")
                        elseif i == "Slasher" and not v.Alive then
                            BossCheckLabel8:SetText("Slasher: 🔴")
                        elseif i == "Bandit Zuko" and not v.Alive then
                            BossCheckLabel9:SetText("Bandit Zuko: 🔴")
                        end
                    end
                end
            end
        end)
    end
end)()

MainC3:AddDropdown('FarmMethod', {Values = {"Fists","Sword","Scythe","Claws"}, Default = 1, Multi = false, Text = 'Auto Farms Method (Mastery)', Tooltip = 'Select farm method, it will up mastery on the selected one'})
    Options.FarmMethod:OnChanged(function()
        Settings.KillAura.TypeSelected = Options.FarmMethod.Value
end)
MainC3:AddDropdown('FarmAllBossesType', {Values = {"List","Closest"}, Default = 1, Multi = false, Text = 'Farm All Bosses Method', Tooltip = 'Select ur Farm Method'})
Options.FarmAllBossesType:OnChanged(function()
    Settings.FarmAllBossesType = Options.FarmAllBossesType.Value
end)
MainC3:AddSlider('FarmAltitude', {Text = 'Farm Altitude (Recommended Default)',Default = Settings.FarmAltitude,Min = -30,Max = 150,Rounding = 0,Compact = false})
Options.FarmAltitude:OnChanged(function()
    Settings.FarmAltitude = Options.FarmAltitude.Value
end)
MainC3:AddToggle('BringMob', {Text = 'Bring Mob',Default = Settings.BringMob,Tooltip = 'Always bring the mob when farming'})
Toggles.BringMob:OnChanged(function()
    Settings.BringMob = Toggles.BringMob.Value
end)
MainCr:AddToggle('ShowChatLogs', {Text = 'Show Chat Logs',Default = Settings.ShowChatLogs,Tooltip = 'Show roblox chat'})
Toggles.ShowChatLogs:OnChanged(function()
    Settings.ShowChatLogs = Toggles.ShowChatLogs.Value
    if Toggles.ShowChatLogs.Value == true then
		local ChatFrame = game.Players.LocalPlayer.PlayerGui.Chat.Frame
		ChatFrame.ChatChannelParentFrame.Visible = true
		ChatFrame.ChatBarParentFrame.Position = ChatFrame.ChatChannelParentFrame.Position + UDim2.new(UDim.new(), ChatFrame.ChatChannelParentFrame.Size.Y)
	elseif Toggles.ShowChatLogs.Value == false then
		local ChatFrame = game.Players.LocalPlayer.PlayerGui.Chat.Frame
		ChatFrame.ChatChannelParentFrame.Visible = false
		ChatFrame.ChatBarParentFrame.Position = ChatFrame.ChatChannelParentFrame.Position + UDim2.new(0, 0, 0, 0)
	end
end)
MainCr:AddToggle('NoSunDmg', {Text = 'No Sun Damage',Default = Settings.NoSunDmg,Tooltip = 'Dont recive damage from sun as a demon'})
Toggles.NoSunDmg:OnChanged(function()
    Settings.NoSunDmg = Toggles.NoSunDmg.Value
    game:GetService("Players").LocalPlayer.PlayerScripts["Small_Scripts"].Gameplay["Sun_Damage"].Disabled = Settings.NoSunDmg
end)
MainCr:AddToggle('AutoChest', {Text = 'Auto Loot Chests',Default = Settings.AutoLootChest,Tooltip = 'Auto Loot Nearby Chests'})
Toggles.AutoChest:OnChanged(function()
    Settings.AutoLootChest = Toggles.AutoChest.Value
end)
MainCr:AddToggle('AutoEatSoul', {Text = 'Auto Eat Souls',Default = Settings.AutoEatSoul,Tooltip = 'Auto Eat Nearby Souls'})
Toggles.AutoEatSoul:OnChanged(function()
    Settings.AutoEatSoul = Toggles.AutoEatSoul.Value
end)
MainCr:AddToggle('InfStamina', {Text = 'Inf Stamina',Default = Settings.InfStamina,Tooltip = 'U have infinite Stamina'})
Toggles.InfStamina:OnChanged(function()
    Settings.InfStamina = Toggles.InfStamina.Value
end)
MainCr:AddToggle('InfBreath', {Text = 'Inf Breath',Default = Settings.InfBreath,Tooltip = 'U have infinite Breath'})
Toggles.InfBreath:OnChanged(function()
    Settings.InfBreath = Toggles.InfBreath.Value
end)

local Villages = {}
if World == 1 then
    local First = {
    ["Kiribating Village"] = CFrame.new(120.362045, 282.207642, -1743.01636, 0.999990761, 2.85735684e-08, 0.00429180823, -2.90243012e-08, 1, 1.04959462e-07, -0.00429180823, -1.0508306e-07, 0.999990761),
    ["Zapiwara Cave [Demon Art Spins]"] = CFrame.new(-38.216156, 275.869537, -2403.53711, -0.244779825, 1.40672629e-08, 0.969578683, -3.9969752e-08, 1, -2.45993981e-08, -0.969578683, -4.47752555e-08, -0.244779825),
    ["Ush2ma3o Village"] = CFrame.new(-30.0373688, 354.723511, -3170.00439, 0.817297578, -1.0121405e-08, 0.576215804, 3.12666586e-08, 1, -2.6782951e-08, -0.576215804, 3.99059843e-08, 0.817297578),
    ["Butterfly Mansion"] = CFrame.new(3001.71753, 316.000519, -3806.40601, -0.998922288, -7.88841792e-09, -0.0464141443, -9.13921649e-09, 1, 2.67364477e-08, 0.0464141443, 2.71318221e-08, -0.998922288),
    ["Final Selection"] = CFrame.new(5258.51709, 365.857056, -2422.04443, 0.0163344685, -1.36483918e-08, -0.999866605, -6.17656548e-09, 1, -1.37511176e-08, 0.999866605, 6.40035847e-09, 0.0163344685),
    ["Zapiwara Mountain"] = CFrame.new(-366.581635, 425.857422, -2371.77124, -0.998583674, -7.39169579e-08, 0.0532043427, -7.35017522e-08, 1, 9.76061187e-09, -0.0532043427, 5.8361751e-09, -0.998583674),
    ["Wind Trainer"] = CFrame.new(1797.46521, 334.100983, -3466.552, 0.99727422, 7.59257635e-09, -0.0737840235, -2.28731412e-09, 1, 7.19870812e-08, 0.0737840235, -7.16220967e-08, 0.99727422),
    ["Kabiwaru Village"] = CFrame2ne3(2015.54297, 315.908813, -3051.2251, -0.956531584, -6.76903866e-08, -0.291628718, -6.4477355e-08, 1, -2.0628141e-08, 0.291628718, -9.2802005e-10, -0.956531584),
    ["Waroru Cave"] = CFrame.new(689.451843, 261.933289, -2469.948, -0.990007997, -2.02267403e-09, -0.141011208, 3.4283596e-09, 1, -3.8413809e-08, 0.141011208, -3.85134129e-08, -0.990007997),
    ["Ouwbayashi Home"] = CFrame.new(1241.24353, 320.429382, -4568.84521, 0.0538635328, 2.40611175e-08, -0.998548329, -7.93333221e-09, 1, 2.36681608e-08, 0.998548329, 6.64696431e-09, 0.0538635328),
    ["Dangerous Woods"] = CFrame.new(3839.87256, 342.214478, -4177.88428, 0.99924922, -3.67285011e-08, 0.0387428068, 3.67143471e-08, 1, 1.07676823e-09, -0.0387428068, 3.46457113e-10, 0.99924922)
    }
    Villages = First
elseif World == 2 then
    local Second = {
        ["Nomay Village"] = CFrame.new(3562.02734375, 673.1098022460938, -2109.169189453125 ),
        ["Cave 1 [Demon Art Spins]"] = CFrame.new(4233.64599609375, 673.673095703125, 586.3038330078125),
        ["Mugen Train Station"] = CFrame.new(787.9573974609375, 497.2205810546875, 906.1786499023438),
        ["Rengoku's Home"] = CFrame.new(3710.528838125, 673.1098022460938, -308.9883728027344),
        ["Frozen Lake"] = CFrame.new(2049.289794921875, 483.02081298828125, -769.8289184570312),
        ["Village 2"] = CFrame.new(1205.9620361328125, 569.3946533203125, 77.27154541015625),
        ["Mist trainer location"] = CFrame.new(4325.09912109375, 673.032470703125, -569.9601440429688),
        ["Wop's training grounds"] = CFrame.new(230.7153778076172, 597.5810546875, 479.040283203125),
        ["Beast Cave"] = CFrame.new(1840.2613525390625, 483.6178283691406, 37.301151275634766),
        ["Wop City"] = CFrame.new(-88.75889587402344, 601.2758178710938, -376.92303466796875),
        ["Akeza Cave"] = CFrame.new(1902.863037109375, 556.0687255859375, -150.78372192382812),
        ["Cave 2"] = CFrame.new(1108.785400390625, 487.3731689453125, -1193.9532470703125)
    }
    Villages = Second
end
local Breaths = {
    ["Urokodaki - Water"] = CFrame.new(705.209229, 261.426819, -2409.51587, -0.566798735, -5.48522401e-08, -0.641887605, -7.38932258e-08, 1, 2.8182352e-09, 0.641887605, 4.95921633e-08, -0.566798735),
    ["Shinobo - Insect"] = CFrame.new(2873.81177, 316.95871, -3917.9397, 0.40715313, 4.81208531e-08, 0.91335988, -8.85969982e-08, 1, -1.31911939e-08, -0.91335988, -7.55501048e-08, 0.40715313),
    ["Kuwajima - Lightning"] = CFrame.new(-322.369507, 426.857788, -2384.4021, 0.361198723, -4.49157973e-08, -0.932488859, 1.14233451e-07, 1, -3.91942434e-09, 0.932488859, -1.05105727e-07, 0.361198723),
    ["Jinger - Wind"] = CFrame.new(1792.31458, 334.338989, -3521.31104, 0.862527311, -5.19402583e-08, -0.506010473, 8.30083167e-08, 1, 3.88463874e-08, 0.506010473, -7.55091492e-08, 0.862527311)
};
if World == 1 then
    MainT:AddDropdown('LocationsDropDown', {Values = {"Kiribating Village","Zapiwara Cave [Demon Art Spins]","Ushumaro Village","Butterfly Mansion","Final Selection","Zapiwara Mountain","Wind Trainer","Kabiwaru Village","Waroru Cave","Ouwbayashi Home","Dangerous Woods"}, Default = 1, Multi = false, Text = 'Locations', Tooltip = 'Select were to go'})
    Options.LocationsDropDown:OnChanged(function()
        Settings.SelectedLocation = Options.LocationsDropDown.Value
    end)
elseif World == 2 then
    MainT:AddDropdown('LocationsDropDown', {Values = {"Nomay Village","Cave 1 [Demon Art Spins]","Mugen Train Station","Frozen Lake","Village 2","Mist trainer location","Wop's training grounds","Beast Cave","Wop City","Akeza Cave","Cave 2"}, Default = 1, Multi = false, Text = 'Locations', Tooltip = 'Select were to go'})
    Options.LocationsDropDown:OnChanged(function()
        Settings.SelectedLocation = Options.LocationsDropDown.Value
    end)
end
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
if World == 1 then
    MainTr:AddButton("Teleport to Muzan", function()
        if Tween then Tween:Cancel() Tween = nil end
        if workspace:FindFirstChild("Muzan") then
            TeleportTween(CFrame.new(workspace:WaitForChild("Muzan"):WaitForChild("SpawnPos").Value))
        else
            Notify(NS.Title,NS.Icon,"Muzan not spawned wait for night",3)
        end
    end)
end
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
