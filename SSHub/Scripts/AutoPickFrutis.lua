repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer

if game.Players.LocalPlayer.Team == nil then
    task.wait(2)
    local Button = game.Players.LocalPlayer.PlayerGui.Main.ChooseTeam.Container.Pirates.Frame.ViewportFrame.TextButton
    local Events = {"MouseButton1Click", "MouseButton1Down", "Activated"}
    for i,v in pairs(Events) do
        for i,v in pairs(getconnections(Button[v])) do
            v.Function()
        end
    end
end
local queueteleport = syn and syn.queue_on_teleport or queue_on_teleport or fluxus and fluxus.queue_on_teleport
local Module = loadstring(game:HttpGet"https://raw.githubusercontent.com/miguel831/Roblox-Scripts/main/SSHub/ServerHop")()
local NS = {
	Title = "SSHub",
	Icon = "rbxassetid://8426126371"
}
local function Notify(Title, Icon, Text, Duration)
	game.StarterGui:SetCore("SendNotification", {Title = Title or ""; Text = Text or ""; Icon = Icon or ""; Duration = tonumber(Duration) or 3 })
end
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

local Inv = ReplicatedStorage.Remotes.CommF_:InvokeServer("getInventoryFruits")
local Backpack = Plr.Backpack
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

local ListFruits = {
    "Bomb",
    "Spike",
    "Chop",
    "Spring",
    "Kilo",
    "Smoke",
    "Spin",
    "Flame",
    "Falcon",
    "Ice",
    "Sand",
    "Dark",
    "Diamond",
    "Light",
    "Love",
    "Rubber",
    "Barrier",
    "Magma",
    "Door",
    "Quake",
    "Human-Human: Buddha",
    "String",
    "Bird-Bird: Phoenix",
    "Rumble",
    "Paw",
    "Gravity",
    "Dough",
    "Venom",
    "Control",
    "Dragon",
    "Leopard"
}
local FruitsInBackPack = {}

local Noclip = false
    coroutine.wrap(function()
        RunService.Stepped:Connect(function()
            if Noclip then
                for i, v in pairs(Plr.Character:GetDescendants()) do
                    if v:IsA("BasePart") and v.CanCollide == true then
                        v.CanCollide = false
                    end
                end
                if not Noclip then
                    for i, v in pairs(Plr.Character:GetDescendants()) do
                        if v:IsA("BasePart") and v.CanCollide == false then
                            v.CanCollide = true
                        end
                    end
                end
            end
        end)
    end)()

    local Tween
    local function TeleportTween(To)
        if Tween then Tween:Cancel() Tween = nil end
        local Speed
        local Distance = (To.Position - Plr.Character.PrimaryPart.Position).Magnitude
        if Distance < 500 then
            Plr.Character.PrimaryPart.CFrame = To
            Speed = 350
        elseif Distance < 1200 then
            Speed = 350
        elseif Distance >= 1200 then
            Speed = 300
        end
        local Plataform
        if not workspace:FindFirstChild("TweeningPlataform") then
            Plataform = Instance.new("Part", workspace)
            Plataform.Transparency = 1
            Plataform.Name = "TweeningPlataform"
            Plataform.Size = Vector3.new(30,1,30)
            Plataform.Anchored = true
            Plataform.CFrame = Plr.Character.PrimaryPart.CFrame*CFrame.new(0,0,0)
        end
        Tween = game:GetService("TweenService"):Create(Plataform,TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),{CFrame = To})
        local NoFall
        if not Plr.Character.PrimaryPart:FindFirstChild("BodyVelocity") then
            NoFall = Instance.new("BodyVelocity", Plr.Character.PrimaryPart)
            NoFall.Velocity = Vector3.new(0,0,0)
        end
        Noclip = true
        Tween:Play()
        coroutine.wrap(function()
            repeat task.wait()
                Plr.Character.PrimaryPart.CFrame = Plataform.CFrame
            until not Tween or not Plataform or Distance < 10
        end)()
        Tween.Completed:Connect(function()
            pcall(function()
                Plataform:Destroy()
                NoFall:Destroy()
                Tween = nil
                Noclip = false
            end)
        end)
    end

for _, Object in next, Backpack:GetChildren() do
	for i,v in pairs(ListFruits) do
		if string.find(Object.Name, v) and not string.find(Object.Name, "Talon") then
		    table.insert(FruitsInBackPack, tostring(Object))
		end
	end
end 
Backpack.ChildAdded:Connect(function(Object)
	for i,v in pairs(ListFruits) do
		if string.find(Object.Name, v) and not string.find(Object.Name, "Talon") then
		    table.insert(FruitsInBackPack, tostring(Object))
		end
	end
end)
Backpack.ChildRemoved:Connect(function(Object)
	for i,v in pairs(ListFruits) do
		if string.find(Object.Name, v) and not string.find(Object.Name, "Talon") then
            TableRemove(FruitsInBackPack, tostring(Object))
        end
    end
end)
local Error
local function PickFruits()
    for _,v in pairs(Workspace:GetChildren()) do
        if string.find(tostring(v), "Fruit" or "Fruit ") and v.Parent == Workspace then
            local Time1 = 0
            task.spawn(function()
                repeat task.wait(1)
                    Time1 = Time1 + 1
                until Time1 == 5 or not v.Parent == Workspace
            end)
            while task.wait() and string.find(tostring(v), "Fruit" or "Fruit ") and v.Parent == Workspace and Time1 < 5 do
				Plr.Character.HumanoidRootPart.CFrame = v:FindFirstChild("Handle").CFrame
				firetouchinterest(Plr.Character.HumanoidRootPart, v:FindFirstChild("Handle"), 0)
				firetouchinterest(Plr.Character.HumanoidRootPart, v:FindFirstChild("Handle"), 1)
				Plr.Character.HumanoidRootPart.CFrame = v:FindFirstChild("Handle").CFrame*CFrame.new(0,0,.5)
            end
            if Time1 >= 5 and v.Parent == Workspace then
                Notify(NS.Title,NS.Icon,"Tweening")
                task.wait(5)
                TeleportTween(v:FindFirstChild("Handle").CFrame)
                local Time = 0
                task.spawn(function()
                    repeat task.wait(1)
                        Time = Time + 1
                    until Time == 5 or not v.Parent == Workspace
                end)
                while task.wait() and string.find(tostring(v), "Fruit" or "Fruit ") and v.Parent == Workspace and Time < 5 do
                    Plr.Character.HumanoidRootPart.CFrame = v:FindFirstChild("Handle").CFrame
                    firetouchinterest(Plr.Character.HumanoidRootPart, v:FindFirstChild("Handle"), 0)
                    firetouchinterest(Plr.Character.HumanoidRootPart, v:FindFirstChild("Handle"), 1)
                    Plr.Character.HumanoidRootPart.CFrame = v:FindFirstChild("Handle").CFrame*CFrame.new(0,0,.5)
                end
                if Time >= 5 then
                    task.wait(3)
                    Notify(NS.Title,NS.Icon,"Can't get the fruit.")
                end
            end
		end
    end
end

local function CheckInventory()
    local InvFruits = {}
    for _,Table in pairs(Inv) do
        for _,v in pairs(Table) do
            for _,i in pairs(ListFruits) do
                if string.find(v, i) then
                    table.insert(InvFruits, i)
                end
            end
        end
    end
    return InvFruits
end

local function CheckBackpack()
    local TempTable = {}
    
    for _,i in pairs(CheckInventory()) do
        for _,v in pairs(FruitsInBackPack) do
            if not string.match(v, i) then
                table.insert(TempTable, v:sub(0,#v - #" Fruit"))
            end
        end
        break
    end
    return TempTable
end

local function StoreFruits()
    Plr.Character.Humanoid:UnequipTools()
    pcall(function()
		for _,v in pairs(CheckBackpack()) do
            if Backpack:FindFirstChild(v.." Fruit") then
			    ReplicatedStorage.Remotes.CommF_:InvokeServer("StoreFruit", v.."-"..v, Backpack[v.." Fruit"])
			end
		end
	end)
end

PickFruits()
StoreFruits()
if getgenv().HoopServers then
    Notify(NS.Title,NS.Icon,"Auto hooping servers...")
    task.wait(2)
    queueteleport("getgenv().HoopServers = true")
    queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/miguel831/Roblox-Scripts/main/SSHub/Scripts/AutoPickFrutis.lua'))()")
    Module:Teleport(game.PlaceId)
else
    Notify(NS.Title,NS.Icon,"Auto hoop servers off!\nActivate it on settings.")
end