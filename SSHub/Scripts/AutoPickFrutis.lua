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
Notify(NS.Title,NS.Icon, "AutoPickFruits Running")
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
    "Portal",
    "Quake",
    "Buddha",
    "String",
    "Phoenix",
    "Rumble",
    "Paw",
    "Blizzard",
    "Gravity",
    "Dough",
    "Venom",
    "Control",
    "Spirit",
    "Dragon",
    "Leopard"
}
local FruitsInBackPack = {}


local ListFruitsSpawned = {
    "bomb",
    "spike",
    "chop",
    "spring",
    "kilo",
    "smoke",
    "spin",
    "flame",
    "falcon",
    "ice",
    "sand",
    "dark",
    "diamond",
    "light",
    "love",
    "rubber",
    "barrier",
    "magma",
    "portal",
    "quake",
    "buddha",
    "string",
    "phoenix",
    "rumble",
    "paw",
    "blizzard",
    "gravity",
    "dough",
    "venom",
    "control",
    "spirit",
    "dragon",
    "leopard"
}

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
        Tween.Completed:wait()
        Plataform:Destroy()
        NoFall:Destroy()
        Tween = nil
        Noclip = false
    end

for _, Object in next, Backpack:GetChildren() do
	for i,v in pairs(ListFruits) do
		if string.find(Object.Name, v.." Fruit") then
		    table.insert(FruitsInBackPack, tostring(Object))
		end
	end
end 
Backpack.ChildAdded:Connect(function(Object)
	for i,v in pairs(ListFruits) do
		if string.find(Object.Name, v.." Fruit") then
		    table.insert(FruitsInBackPack, tostring(Object))
		end
	end
end)
Backpack.ChildRemoved:Connect(function(Object)
	for i,v in pairs(ListFruits) do
		if string.find(Object.Name, v.." Fruit") then
            TableRemove(FruitsInBackPack, tostring(Object))
        end
    end
end)
local Error
local function PickFruits()
    for _,v in pairs(Workspace:GetChildren()) do
        if string.find(tostring(v), "Fruit" or "Fruit ") and v.Parent == Workspace then
            if string.find(tostring(v), "Fruit" or "Fruit ") and v.Parent == Workspace then
                if string.match(v.Name, "Fruit ") then
                    for _m,v2 in pairs(v:GetChildren()) do
                        if v2:IsA("MeshPart") then
                            if string.find(v2.Name, "Meshes/") then
                                Notify(NS.Title,NS.Icon, v2.Name.." (In Ground)")
                                if getgenv().WeebHook then
                                    pcall(function()
                                        if string.find(getgenv().WeebHook,"https://discord.com/api/webhooks/") then
                                            local HttpService = game:GetService("HttpService")
                                            local Data = {
                                                ["username"] = "SSHub",
                                                ["embeds"] = {
                                                    {
                                                        ["title"] = "Fruit Finded!",
                                                        ["color"] = 9893552,
                                                        ["fields"] = {
                                                            {
                                                                ["name"] = "Fruit",
                                                                ["value"] = v2.Name.." (In Ground)",
                                                                ["inline"] = true
                                                            },
                                                        }
                                                    }
                                                }
                                            }
                                            local Headers = {["Content-Type"] = "application/json"}
                                            local Encoded = HttpService:JSONEncode(Data)
                                            local Request = http_request or request or HttpPost or syn.request
                                            local Final = {Url = getgenv().WeebHook, Body = Encoded, Method = "POST", Headers = Headers}
                                            Request(Final)
                                        end
                                    end)
                                end
                            end
                        end
                    end
                else
                    Notify(NS.Title,NS.Icon, v.Name.." (In Ground)")
                    if getgenv().WeebHook then
                        pcall(function()
                            if string.find(getgenv().WeebHook,"https://discord.com/api/webhooks/") then
                                local HttpService = game:GetService("HttpService")
                                local Data = {
                                    ["username"] = "SSHub",
                                    ["embeds"] = {
                                        {
                                            ["title"] = "Fruit Finded!",
                                            ["color"] = 9893552,
                                            ["fields"] = {
                                                {
                                                    ["name"] = "Fruit",
                                                    ["value"] = v.Name.." (In Ground)",
                                                    ["inline"] = true
                                                },
                                            }
                                        }
                                    }
                                }
                                local Headers = {["Content-Type"] = "application/json"}
                                local Encoded = HttpService:JSONEncode(Data)
                                local Request = http_request or request or HttpPost or syn.request
                                local Final = {Url = getgenv().WeebHook, Body = Encoded, Method = "POST", Headers = Headers}
                                Request(Final)
                            end
                        end)
                    end
                end
                for i = 1, 10 do
                    task.wait(.1)
                    firetouchinterest(Plr.Character.HumanoidRootPart, v:FindFirstChild("Handle"), 0)
                    firetouchinterest(Plr.Character.HumanoidRootPart, v:FindFirstChild("Handle"), 1)
                end
                Plr.Character.Humanoid:UnequipTools()
                task.wait(1)
                if v.Parent == Workspace then
                    Notify(NS.Title,NS.Icon,"Re-Trying")
                    Plr.Character.HumanoidRootPart.CFrame = CFrame.new(-4966.533203125, 314.5412902832031, -3023.95849609375)
                    TeleportTween(v:FindFirstChild("Handle").CFrame)
                    if string.find(tostring(v), "Fruit" or "Fruit ") and v.Parent == Workspace then
                        for i = 1, 10 do
                            task.wait(.1)
                            firetouchinterest(Plr.Character.HumanoidRootPart, v:FindFirstChild("Handle"), 0)
                            firetouchinterest(Plr.Character.HumanoidRootPart, v:FindFirstChild("Handle"), 1)
                        end
                        Plr.Character.Humanoid:UnequipTools()
                        task.wait(1)
                        if v.Parent == Workspace then
                            Notify(NS.Title,NS.Icon,"Can't get the fruit: "..v.Name)
                        end
                    end
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
    pcall(function()
        Plr.Character.Humanoid:UnequipTools()
        for _,v in pairs(CheckBackpack()) do
            if Backpack:FindFirstChild(v.." Fruit") then
                if string.find(v, "Bird-Bird: ") then
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("StoreFruit", v.."-"..v, Backpack["Bird-Bird: "..v.." Fruit"])
                elseif string.find(v, "Human-Human: ") then
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("StoreFruit", v.."-"..v, Backpack["Human-Human: "..v.." Fruit"])
                else
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("StoreFruit", v.."-"..v, Backpack[v.." Fruit"])
                end
            end
        end
    end)
end
PickFruits()
wait(1)
StoreFruits()
if getgenv().WhenSpawn then
    local a
    a = Workspace.ChildAdded:Connect(function(v)
        if getgenv().WhenSpawn and string.find(tostring(v), "Fruit" or "Fruit ") and v.Parent == Workspace then
            wait(.5)
            PickFruits()
            wait(1) 
            StoreFruits()
            if not getgenv().WhenSpawn then
                a:Disconnect()
            end
        end
    end)
end

if getgenv().HoopServers then
    Notify(NS.Title,NS.Icon,"U have 3 seconds if u want desactive hoopserver! Re-Execute the script with getgenv().HoopServers = false")
    task.wait(3)
end
if getgenv().HoopServers then
    Notify(NS.Title,NS.Icon,"Auto hooping servers...")
    task.wait(2)
    queueteleport("getgenv().HoopServers = true")
    if getgenv().WeebHook then
 	    queueteleport("getgenv().WeebHook = "..getgenv().WeebHook)
    end
    queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/miguel831/Roblox-Scripts/main/SSHub/Scripts/AutoPickFrutis.lua'))()")
    Module:Teleport(game.PlaceId)
else
    Notify(NS.Title,NS.Icon,"Auto hoop servers off!\nActivate it on settings.")
end
