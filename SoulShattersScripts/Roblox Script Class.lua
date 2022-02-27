--Credits:

game.StarterGui:SetCore("SendNotification", {
    Title = "NOTIFY!";
    Text = "Script by: Tupi#2739";
    Duration = "5";
    })


game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
game.Players.LocalPlayer.PlayerGui.CharacterSelection.Character.Value = "XSans"
wait(1.6)

--Animations
game.Players.LocalPlayer.Backpack:WaitForChild("Main").XSansMoves.Animations.DashBack.AnimationId = "rbxassetid://5776312470"
game.Players.LocalPlayer.Backpack:WaitForChild("Main").XSansMoves.Animations.DashForward.AnimationId = "rbxassetid://5776291266"
game.Players.LocalPlayer.Backpack:WaitForChild("Main").XSansMoves.Animations.DashLeft.AnimationId = "rbxassetid://5776300541"
game.Players.LocalPlayer.Backpack:WaitForChild("Main").XSansMoves.Animations.DashRight.AnimationId = "rbxassetid://5776309122"
game.Players.LocalPlayer.Backpack:WaitForChild("Main").XSansMoves.Animations.Idle3.AnimationId = "rbxassetid://4495592637"
game.Players.LocalPlayer.Backpack:WaitForChild("Main").XSansMoves.Animations.Run3.AnimationId = "rbxassetid://4196684102"
game.Players.LocalPlayer.Backpack:WaitForChild("Main").XSansMoves.Animations.Walk3.AnimationId = "rbxassetid://4196634355"
game.Players.LocalPlayer.Backpack:WaitForChild("Main").XSansMoves.Animations.Walk2.AnimationId = "rbxassetid://7005162082"
game.Players.LocalPlayer.Backpack:WaitForChild("Main").XSansMoves.Animations.Idle2.AnimationId = "rbxassetid://7005139602"
game.Players.LocalPlayer.Backpack:WaitForChild("Main").XSansMoves.Animations.Run2.AnimationId = "rbxassetid://4576074471"
game.Players.LocalPlayer.Backpack:WaitForChild("Main").XSansMoves.Animations.Block.AnimationId = "rbxassetid://3203734026"
game.Players.LocalPlayer.Backpack:WaitForChild("Main").XSansMoves.Animations.Walk.AnimationId = "rbxassetid://7005162082"
game.Players.LocalPlayer.Backpack:WaitForChild("Main").XSansMoves.Animations.Idle.AnimationId = "rbxassetid://7005139602"
game.Players.LocalPlayer.Backpack:WaitForChild("Main").XSansMoves.Animations.Run.AnimationId = "rbxassetid://4576074471"

game.Players.LocalPlayer.Backpack.Main.WalkSpeed.Value = 30

game.Players.LocalPlayer.Backpack.Main.RunSpeed.Value = 70

wait(2)
--Music
game.Players.LocalPlayer:WaitForChild("StarterPlaylist")
game.Players.LocalPlayer.StarterPlaylist["1Theme"]:Destroy()
local Sound = Instance.new("Sound")
Sound.Parent = game.Players.LocalPlayer.StarterPlaylist
Sound.Volume = 0.5
Sound.Playing = true
Sound.Looped = true
Sound.SoundId = "rbxassetid://3337357801" 
Sound.Name = "Music"

--Gui
--moves 1
game.Players.LocalPlayer.PlayerGui.UI.Ui.MoveDebounceShower.Moves1["1"].Position = UDim2.new(-1.2, 20, 0, 0)
game.Players.LocalPlayer.PlayerGui.UI.Ui.MoveDebounceShower.Moves1["2"].Position = UDim2.new(-0.9, 10, 0, 0)
game.Players.LocalPlayer.PlayerGui.UI.Ui.MoveDebounceShower.Moves1["3"].Position = UDim2.new(-0.6, 0, 0, 0)
--moves 2
game.Players.LocalPlayer.PlayerGui.UI.Ui.MoveDebounceShower.Moves2["1"].Position = UDim2.new(-1.4, 0, 0, 0)
game.Players.LocalPlayer.PlayerGui.UI.Ui.MoveDebounceShower.Moves2["2"].Position = UDim2.new(-1.1, 0, 0, 0)
game.Players.LocalPlayer.PlayerGui.UI.Ui.MoveDebounceShower.Moves2["3"].Position = UDim2.new(-0.8, 0, 0, 0)
game.Players.LocalPlayer.PlayerGui.UI.Ui.MoveDebounceShower.Moves2["4"].Position = UDim2.new(-0.5, 0, 0, 0)
--moves 3
game.Players.LocalPlayer.PlayerGui.UI.Ui.MoveDebounceShower.Moves3["1"].Position = UDim2.new(-1.5, -15, 0, 0)
game.Players.LocalPlayer.PlayerGui.UI.Ui.MoveDebounceShower.Moves3["2"].Position = UDim2.new(-1.2, -15, 0, 0)
game.Players.LocalPlayer.PlayerGui.UI.Ui.MoveDebounceShower.Moves3["3"].Position = UDim2.new(-0.9, -15, 0, 0)
game.Players.LocalPlayer.PlayerGui.UI.Ui.MoveDebounceShower.Moves3["4"].Position = UDim2.new(-0.6, -15, 0, 0)
game.Players.LocalPlayer.PlayerGui.UI.Ui.MoveDebounceShower.Moves3["5"].Position = UDim2.new(-0.3, -15, 0, 0)
--moves 4
game.Players.LocalPlayer.PlayerGui.UI.Ui.MoveDebounceShower.Moves4["1"].Position = UDim2.new(-1.4, 0, 0, 0)
game.Players.LocalPlayer.PlayerGui.UI.Ui.MoveDebounceShower.Moves4["2"].Position = UDim2.new(-1.1, 0, 0, 0)
game.Players.LocalPlayer.PlayerGui.UI.Ui.MoveDebounceShower.Moves4["3"].Position = UDim2.new(-0.8, 0, 0, 0)
game.Players.LocalPlayer.PlayerGui.UI.Ui.MoveDebounceShower.Moves4["4"].Position = UDim2.new(-0.5, 0, 0, 0)
--gui
game.Players.LocalPlayer.PlayerGui.UI.Ui.UpdateLog.Text = "KeyBinds"
wait()
game.Players.LocalPlayer.PlayerGui.UI.Ui.UpdateLog.TextColor3 = Color3.fromRGB(0, 0, 255)
wait(0.5)
game.Players.LocalPlayer.PlayerGui.UI.Ui.UpdateLogInfo.Top.Text = "KeyBinds: Z = Heavy Punch, X = Trow + Cross Blaster, C = Kicks Combo, \n V = Barrage + UpperCut, H = OverWriteHeal, T = Slashes Combo"
wait()
game.Players.LocalPlayer.PlayerGui.CharaIndicator.Enabled = false
wait()

--Custom LMB
local player = game:GetService("Players").LocalPlayer
local MoveAnimations = player.Backpack.Main.XSansMoves.Animations
local ClickAnimations = player.Backpack.Main.XSansMoves.ModuleScript.Animations.NormalCombat
local pass = getrenv()._G.Pass
local remote = game.ReplicatedStorage.Remotes["Events"]

ClickAnimations.Light1.AnimationId = "rbxassetid://5770352035"
ClickAnimations.Light2.AnimationId = "rbxassetid://5770385566"
ClickAnimations.Light3.AnimationId = "rbxassetid://5770410811"
ClickAnimations.Light4.AnimationId = "rbxassetid://5770416576"
ClickAnimations.Light5.AnimationId = "rbxassetid://5770437587"
MoveAnimations.Block.AnimationId = "rbxassetid://4290724438"


--Remove stuff

local Player = game.Players.LocalPlayer
local Backpack = Player.Backpack
Player.Character.CrossBone:Remove()
Player.Character.CrossBone2:Remove()

--sit
local sitstart = Instance.new("Animation") 
sitstart.AnimationId = "rbxassetid://6821079045" 
local sitstartplay = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid"):LoadAnimation(sitstart)
local sitloop = Instance.new("Animation") 
sitloop.AnimationId = "rbxassetid://6821100086" 
local sitloopplay = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid"):LoadAnimation(sitloop)
local sitend = Instance.new("Animation") 
sitend.AnimationId = "rbxassetid://6821115515" 
local sitendplay = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid"):LoadAnimation(sitend) 
local sitting = false 
local mouse = game.Players.LocalPlayer:GetMouse()
mouse.KeyDown:Connect(function(k)
    if k == "p" then if sitting == false then 
        sitting = true
        sitstartplay:Play() 
        wait(1) 
        sitloopplay:Play()
    elseif sitting == true then 
        sitting = false
        sitloopplay:Stop() 
        sitendplay:Play() 
        end
    end 
end)

--Starting

--Name

wait()

game.Players.LocalPlayer.Character.Head.HealthBar.Frame.PName.TextColor3 = Color3.fromRGB(34, 41, 37)

--Moves

---Better Teleport
local mouse = game.Players.LocalPlayer:GetMouse()
mouse.KeyDown:Connect(function(k) 
    if k == "r" then
        function getlockchar()
            local char = game.Players.LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
            return char
        end
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = getlockchar().HumanoidRootPart.CFrame * CFrame.new(0,0,-3)
    end
end)

--Heavy Punch
local m = game.Players.LocalPlayer:GetMouse()
db = true
m.keyDown:connect(function(k)
	k = k:lower()
	if k == "z" then
		if db == true then
for i,v in pairs(game.ReplicatedStorage.RemoteSecurity:GetChildren()) do
    v.Name="Noob"..i
end

local player = game.Players.LocalPlayer
local Character = player.Character
local mouse = player:GetMouse()
local remote = game.ReplicatedStorage.Remotes["SwordHandler"]
local security = game.ReplicatedStorage.RemoteSecurity["Noob382"]


local A_1 = game:GetService("ReplicatedStorage").RemoteSecurity.Noob382
local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
local A_3 = 
{
	["HitTime"] = 2,5, 
	["Type"] = "Normal", 
	["HitEffect"] = "KnifeHitEffect",  
	["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback1, 
    ["Velocity"] = Vector3.new(10, 0, 10),
	["VictimCFrame"] = CFrame.new(), 
	["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
	["Damage"] = 10
}
local Event = game:GetService("ReplicatedStorage").Remotes.Damage
Event:InvokeServer(A_1, A_2, A_3)
			db = false
			wait(5.6)
			db = true
		end
	end
end)
wait()
local m = game.Players.LocalPlayer:GetMouse()
db = true
m.keyDown:connect(function(k)
	k = k:lower()
	if k == "z" then
		if db == true then
for i,v in pairs(game.ReplicatedStorage.RemoteSecurity:GetChildren()) do
    v.Name="Noob"..i
end

local player = game.Players.LocalPlayer
local Character = player.Character
local mouse = player:GetMouse()
local remote = game.ReplicatedStorage.Remotes["SwordHandler"]
local security = game.ReplicatedStorage.RemoteSecurity["Noob382"]


local A_1 = game:GetService("ReplicatedStorage").RemoteSecurity.Noob382
local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
local A_3 = 
{
	["HitTime"] = 2.5, 
	["Type"] = "Normal", 
	["HitEffect"] = "KnifeHitEffect",  
	["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback1, 
    ["Velocity"] = Vector3.new(10, 0, 10),
	["VictimCFrame"] = CFrame.new(), 
	["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
	["Damage"] = 10
}
local Event = game:GetService("ReplicatedStorage").Remotes.Damage
Event:InvokeServer(A_1, A_2, A_3)
			db = false
			wait(5.6)
			db = true
		end
	end
end)
wait()
local m = game.Players.LocalPlayer:GetMouse()
db = true
m.keyDown:connect(function(k)
	k = k:lower()
	if k == "z" then
		if db == true then
for i,v in pairs(game.ReplicatedStorage.RemoteSecurity:GetChildren()) do
    v.Name="Noob"..i
end

local player = game.Players.LocalPlayer
local Character = player.Character
local mouse = player:GetMouse()
local remote = game.ReplicatedStorage.Remotes["SwordHandler"]
local security = game.ReplicatedStorage.RemoteSecurity["Noob382"]


local A_1 = game:GetService("ReplicatedStorage").RemoteSecurity.Noob382
local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
local A_3 = 
{
	["HitTime"] = 2.5, 
	["Type"] = "Normal", 
	["HitEffect"] = "KnifeHitEffect",  
	["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback1, 
    ["Velocity"] = Vector3.new(10, 0, 10),
	["VictimCFrame"] = CFrame.new(), 
	["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
	["Damage"] = 10
}
local Event = game:GetService("ReplicatedStorage").Remotes.Damage
Event:InvokeServer(A_1, A_2, A_3)
			db = false
			wait(5.6)
			db = true
		end
	end
end)
wait()
local m = game.Players.LocalPlayer:GetMouse()
db = true
m.keyDown:connect(function(k)
	k = k:lower()
	if k == "z" then
		if db == true then
for i,v in pairs(game.ReplicatedStorage.RemoteSecurity:GetChildren()) do
    v.Name="Noob"..i
end

local player = game.Players.LocalPlayer
local Character = player.Character
local mouse = player:GetMouse()
local remote = game.ReplicatedStorage.Remotes["SwordHandler"]
local security = game.ReplicatedStorage.RemoteSecurity["Noob382"]


local A_1 = game:GetService("ReplicatedStorage").RemoteSecurity.Noob382
local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
local A_3 = 
{
	["HitTime"] = 2.5, 
	["Type"] = "Normal", 
	["HitEffect"] = "KnifeHitEffect",  
	["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback1, 
    ["Velocity"] = Vector3.new(10, 0, 10),
	["VictimCFrame"] = CFrame.new(), 
	["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
	["Damage"] = 10
}
local Event = game:GetService("ReplicatedStorage").Remotes.Damage
Event:InvokeServer(A_1, A_2, A_3)
			db = false
			wait(5.6)
			db = true
		end
	end
end)
wait()
local m = game.Players.LocalPlayer:GetMouse()
db = true
m.keyDown:connect(function(k)
	k = k:lower()
	if k == "z" then
		if db == true then
for i,v in pairs(game.ReplicatedStorage.RemoteSecurity:GetChildren()) do
    v.Name="Noob"..i
end

local player = game.Players.LocalPlayer
local Character = player.Character
local mouse = player:GetMouse()
local remote = game.ReplicatedStorage.Remotes["SwordHandler"]
local security = game.ReplicatedStorage.RemoteSecurity["Noob382"]


local A_1 = game:GetService("ReplicatedStorage").RemoteSecurity.Noob382
local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
local A_3 = 
{
	["HitTime"] = 2.5, 
	["Type"] = "Normal", 
	["HitEffect"] = "KnifeHitEffect",  
	["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback1, 
    ["Velocity"] = Vector3.new(10, 0, 10),
	["VictimCFrame"] = CFrame.new(), 
	["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
	["Damage"] = 10
}
local Event = game:GetService("ReplicatedStorage").Remotes.Damage
Event:InvokeServer(A_1, A_2, A_3)
			db = false
			wait(5.6)
			db = true
		end
	end
end)
wait()
local m = game.Players.LocalPlayer:GetMouse()
db = true
m.keyDown:connect(function(k)
	k = k:lower()
	if k == "z" then
		if db == true then
for i,v in pairs(game.ReplicatedStorage.RemoteSecurity:GetChildren()) do
    v.Name="Noob"..i
end

local player = game.Players.LocalPlayer
local Character = player.Character
local mouse = player:GetMouse()
local remote = game.ReplicatedStorage.Remotes["SwordHandler"]
local security = game.ReplicatedStorage.RemoteSecurity["Noob382"]


local A_1 = game:GetService("ReplicatedStorage").RemoteSecurity.Noob382
local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
local A_3 = 
{
	["HitTime"] = 2.5, 
	["Type"] = "Normal", 
	["HitEffect"] = "KnifeHitEffect",  
	["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback1, 
    ["Velocity"] = Vector3.new(10, 0, 10),
	["VictimCFrame"] = CFrame.new(), 
	["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
	["Damage"] = 10
}
local Event = game:GetService("ReplicatedStorage").Remotes.Damage
Event:InvokeServer(A_1, A_2, A_3)
			db = false
			wait(5.6)
			db = true
		end
	end
end)
wait()
local m = game.Players.LocalPlayer:GetMouse()
db = true
m.keyDown:connect(function(k)
	k = k:lower()
	if k == "z" then
		if db == true then
for i,v in pairs(game.ReplicatedStorage.RemoteSecurity:GetChildren()) do
    v.Name="Noob"..i
end

local player = game.Players.LocalPlayer
local Character = player.Character
local mouse = player:GetMouse()
local remote = game.ReplicatedStorage.Remotes["SwordHandler"]
local security = game.ReplicatedStorage.RemoteSecurity["Noob382"]


local A_1 = game:GetService("ReplicatedStorage").RemoteSecurity.Noob382
local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
local A_3 = 
{
	["HitTime"] = 2.5, 
	["Type"] = "Normal", 
	["HitEffect"] = "KnifeHitEffect",  
	["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback1, 
    ["Velocity"] = Vector3.new(10, 0, 10),
	["VictimCFrame"] = CFrame.new(), 
	["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
	["Damage"] = 10
}
local Event = game:GetService("ReplicatedStorage").Remotes.Damage
Event:InvokeServer(A_1, A_2, A_3)
			db = false
			wait(5.6)
			db = true
		end
	end
end)
wait()
local m = game.Players.LocalPlayer:GetMouse()
db = true
m.keyDown:connect(function(k)
	k = k:lower()
	if k == "z" then
		if db == true then
for i,v in pairs(game.ReplicatedStorage.RemoteSecurity:GetChildren()) do
    v.Name="Noob"..i
end

local player = game.Players.LocalPlayer
local Character = player.Character
local mouse = player:GetMouse()
local remote = game.ReplicatedStorage.Remotes["SwordHandler"]
local security = game.ReplicatedStorage.RemoteSecurity["Noob382"]


local A_1 = game:GetService("ReplicatedStorage").RemoteSecurity.Noob382
local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
local A_3 = 
{
	["HitTime"] = 2.5, 
	["Type"] = "Normal", 
	["HitEffect"] = "KnifeHitEffect",  
	["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback1, 
    ["Velocity"] = Vector3.new(10, 0, 10),
	["VictimCFrame"] = CFrame.new(), 
	["Sound"] = game:GetService("ReplicatedStorage").Sounds.StarBlazingHit, 
	["Damage"] = 10
}
local Event = game:GetService("ReplicatedStorage").Remotes.Damage
Event:InvokeServer(A_1, A_2, A_3)
			db = false
			wait(5.6)
			db = true
		end
	end
end)
wait()

local player = game.Players.LocalPlayer
repeat wait() until player.Character.Humanoid
local humanoid = player.Character.Humanoid
local mouse = player:GetMouse()


local anim = Instance.new("Animation")
anim.AnimationId = "rbxassetid://4910106480"

mouse.KeyDown:connect(function(key)
	if key == "z" then
		local playAnim = humanoid:LoadAnimation(anim)
		playAnim:Play()
		wait(2)
		playAnim:Stop()

	end
end)
wait()

--Throw + Blaster

local mouse = game.Players.LocalPlayer:GetMouse()
mouse.KeyDown:Connect(function(k)
	if k == "x" then
		local Anim = Instance.new("Animation")
		Anim.AnimationId = "rbxassetid://4820780935"
		local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
		k:Play()
		local A_1 = getrenv()._G.Pass
		local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
		local A_3 = 
			{
				["HitTime"] = 2.5, 
				["Type"] = "Knockback", 
				["HitEffect"] = "KnifeHitEffect",
				["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback2,
				["Sound"] = game:GetService("ReplicatedStorage").Sounds.Knockback,
				["Velocity"] = Vector3.new(0, 60, 0), 
				["CombatInv"] = true,
				["Damage"] = 10
			}
		local Event = game:GetService("ReplicatedStorage").Remotes.Damage
		Event:InvokeServer(A_1, A_2, A_3)
		
		wait(1)
		local v1 = {
			[1] = getrenv()._G.Pass,
			[2] = "CrossBlaster"
		}
		local rem = game:GetService("ReplicatedStorage").Remotes.XSansMoves
		rem:InvokeServer(v1)
	end
end)
wait()

--Heal

local mouse = game.Players.LocalPlayer:GetMouse()
db = true
mouse.keyDown:connect(function(k)
	k = k:lower()
	if k == "h" then
		if db == true then
			local A_1 = 
				{
					[1] = getrenv()._G.Pass,
					[2] = "Overwrite", 
					[3] = "Summon"
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.XSansMoves
			Event:InvokeServer(A_1)
			wait(0.6)
			local A_1 = 
				{
					[1] = getrenv()._G.Pass, 
					[2] = "Overwrite", 
					[3] = "Heal"
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.XSansMoves
			Event:InvokeServer(A_1)
			wait(1)
			local A_1 = 
				{
					[1] = getrenv()._G.Pass,
					[2] = "Overwrite", 
					[3] = "UnSummon"
				}
			local Event = game:GetService("ReplicatedStorage").Remotes.XSansMoves
			Event:InvokeServer(A_1)
			db = false
			wait(1)
			db = true
		end
	end
end)

--JitJack

local mouse = game.Players.LocalPlayer:GetMouse()
mouse.KeyDown:Connect(function(k)
	if k == "c" then
local Anim = Instance.new("Animation")
		Anim.AnimationId = "rbxassetid://5858687214"
		local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
		k:Play()
        local args = {
            [1] = getrenv()._G.Pass,
            [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
            [3] = {
                ["Type"] = "Normal",
                ["HitEffect"] = "KnifeHitEffect",
                ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt2,
                ["Velocity"] = Vector3.new(1, 1, 1),
                ["HitTime"] = 1,
                ["CombatInv"] = true,
                ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
                ["Damage"] = 5
            }
        }


        game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
end
end)

local mouse = game.Players.LocalPlayer:GetMouse()
mouse.KeyDown:Connect(function(k)
	if k == "c" then
        local args = {
            [1] = getrenv()._G.Pass,
            [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
            [3] = {
                ["Type"] = "Normal",
                ["HitEffect"] = "KnifeHitEffect",
                ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt2,
                ["Velocity"] = Vector3.new(1, 1, 1),
                ["HitTime"] = 1,
                ["CombatInv"] = true,
                ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
                ["Damage"] = 5
            }
        }


        game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
end
end)

local mouse = game.Players.LocalPlayer:GetMouse()
mouse.KeyDown:Connect(function(k)
	if k == "c" then
        local args = {
            [1] = getrenv()._G.Pass,
            [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
            [3] = {
                ["Type"] = "Normal",
                ["HitEffect"] = "KnifeHitEffect",
                ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt2,
                ["Velocity"] = Vector3.new(1, 1, 1),
                ["HitTime"] = 1,
                ["CombatInv"] = true,
                ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
                ["Damage"] = 5
            }
        }


        game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
end
end)

local mouse = game.Players.LocalPlayer:GetMouse()
mouse.KeyDown:Connect(function(k)
	if k == "c" then
  wait(1.0)
        local args = {
            [1] = getrenv()._G.Pass,
            [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
            [3] = {
                ["Type"] = "Normal",
                ["HitEffect"] = "KnifeHitEffect",
                ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1,
                ["Velocity"] = Vector3.new(1, 1, 1),
                ["HitTime"] = 1,
                ["CombatInv"] = true,
                ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
                ["Damage"] = 5
            }
        }


        game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
end
end)

local mouse = game.Players.LocalPlayer:GetMouse()
mouse.KeyDown:Connect(function(k)
	if k == "c" then
  wait(1.8)
        local args = {
            [1] = getrenv()._G.Pass,
            [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
            [3] = {
                ["Type"] = "Knockback",
                ["HitEffect"] = "KnifeHitEffect",
                ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback3,
                ["Velocity"] = Vector3.new(50, -0, 50),
                ["HitTime"] = 1,
                ["CombatInv"] = true,
                ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Punch,
                ["Damage"] = 20
            }
        }


        game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
end
end)

--Barrage

local mouse = game.Players.LocalPlayer:GetMouse()
mouse.KeyDown:Connect(function(k)
	if k == "v" then
wait()
local Anim = Instance.new("Animation")
		Anim.AnimationId = "rbxassetid://5667194069"
		local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
		k:Play()
        local args = {
            [1] = getrenv()._G.Pass,
            [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
            [3] = {
                ["Type"] = "Normal",
                ["HitEffect"] = "KnifeHitEffect",
                ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt2,
                ["Velocity"] = Vector3.new(0.2, 0, 0.2),
                ["HitTime"] = 0.6,
                ["CombatInv"] = true,
                ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Punch,
                ["Damage"] = 5
            }
        }


        game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
end
end)

local mouse = game.Players.LocalPlayer:GetMouse()
mouse.KeyDown:Connect(function(k)
	if k == "v" then
wait(0.2)
local Anim = Instance.new("Animation")
		Anim.AnimationId = "rbxassetid://5667196296"
		local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
		k:Play()
        local args = {
            [1] = getrenv()._G.Pass,
            [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
            [3] = {
                ["Type"] = "Normal",
                ["HitEffect"] = "KnifeHitEffect",
                ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt2,
                ["Velocity"] = Vector3.new(0.2, 0, 0.2),
                ["HitTime"] = 0.6,
                ["CombatInv"] = true,
                ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Punch,
                ["Damage"] = 5
            }
        }


        game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
end
end)

local mouse = game.Players.LocalPlayer:GetMouse()
mouse.KeyDown:Connect(function(k)
	if k == "v" then
wait(0.4)
local Anim = Instance.new("Animation")
		Anim.AnimationId = "rbxassetid://5667194069"
		local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
		k:Play()
        local args = {
            [1] = getrenv()._G.Pass,
            [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
            [3] = {
                ["Type"] = "Normal",
                ["HitEffect"] = "KnifeHitEffect",
                ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt2,
                ["Velocity"] = Vector3.new(0.2, 0, 0.2),
                ["HitTime"] = 0.6,
                ["CombatInv"] = true,
                ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Punch,
                ["Damage"] = 5
            }
        }


        game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
end
end)

local mouse = game.Players.LocalPlayer:GetMouse()
mouse.KeyDown:Connect(function(k)
	if k == "v" then
wait(0.6)
local Anim = Instance.new("Animation")
		Anim.AnimationId = "rbxassetid://5667194069"
		local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
		k:Play()
        local args = {
            [1] = getrenv()._G.Pass,
            [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
            [3] = {
                ["Type"] = "Normal",
                ["HitEffect"] = "KnifeHitEffect",
                ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt2,
                ["Velocity"] = Vector3.new(0.2, 0, 0.2),
                ["HitTime"] = 1,
                ["CombatInv"] = true,
                ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Punch,
                ["Damage"] = 5
            }
        }


        game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
end
end)

local mouse = game.Players.LocalPlayer:GetMouse()
mouse.KeyDown:Connect(function(k)
	if k == "v" then
wait(0.8)
local Anim = Instance.new("Animation")
		Anim.AnimationId = "rbxassetid://5667194069"
		local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
		k:Play()
        local args = {
            [1] = getrenv()._G.Pass,
            [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
            [3] = {
                ["Type"] = "Normal",
                ["HitEffect"] = "KnifeHitEffect",
                ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt2,
                ["Velocity"] = Vector3.new(0.2, 0, 0.2),
                ["HitTime"] = 1,
                ["CombatInv"] = true,
                ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Punch,
                ["Damage"] = 5
            }
        }


        game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
end
end)

local mouse = game.Players.LocalPlayer:GetMouse()
mouse.KeyDown:Connect(function(k)
	if k == "v" then
wait(1)
local Anim = Instance.new("Animation")
		Anim.AnimationId = "rbxassetid://5667194069"
		local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
		k:Play()
        local args = {
            [1] = getrenv()._G.Pass,
            [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
            [3] = {
                ["Type"] = "Normal",
                ["HitEffect"] = "KnifeHitEffect",
                ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt2,
                ["Velocity"] = Vector3.new(0.2, 0, 0.2),
                ["HitTime"] = 1,
                ["CombatInv"] = true,
                ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Punch,
                ["Damage"] = 5
            }
        }


        game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
end
end)

local mouse = game.Players.LocalPlayer:GetMouse()
mouse.KeyDown:Connect(function(k)
	if k == "v" then
wait(1.2)
local Anim = Instance.new("Animation")
		Anim.AnimationId = "rbxassetid://5667194069"
		local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
		k:Play()
        local args = {
            [1] = getrenv()._G.Pass,
            [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
            [3] = {
                ["Type"] = "Normal",
                ["HitEffect"] = "KnifeHitEffect",
                ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt2,
                ["Velocity"] = Vector3.new(0.2, 0, 0.2),
                ["HitTime"] = 1,
                ["CombatInv"] = true,
                ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Punch,
                ["Damage"] = 5
            }
        }


        game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
end
end)

local mouse = game.Players.LocalPlayer:GetMouse()
mouse.KeyDown:Connect(function(k)
	if k == "v" then
wait(1.4)
local Anim = Instance.new("Animation")
		Anim.AnimationId = "rbxassetid://5667194069"
		local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
		k:Play()
        local args = {
            [1] = getrenv()._G.Pass,
            [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
            [3] = {
                ["Type"] = "Normal",
                ["HitEffect"] = "KnifeHitEffect",
                ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt2,
                ["Velocity"] = Vector3.new(0.2, 0, 0.2),
                ["HitTime"] = 1,
                ["CombatInv"] = true,
                ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Punch,
                ["Damage"] = 5
            }
        }


        game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
end
end)

local mouse = game.Players.LocalPlayer:GetMouse()
mouse.KeyDown:Connect(function(k)
	if k == "v" then
wait(1.6)
local Anim = Instance.new("Animation")
		Anim.AnimationId = "rbxassetid://5667194069"
		local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
		k:Play()
        local args = {
            [1] = getrenv()._G.Pass,
            [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
            [3] = {
                ["Type"] = "Normal",
                ["HitEffect"] = "KnifeHitEffect",
                ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt2,
                ["Velocity"] = Vector3.new(0.2, 0, 0.2),
                ["HitTime"] = 1,
                ["CombatInv"] = true,
                ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Punch,
                ["Damage"] = 5
            }
        }


        game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
end
end)

local mouse = game.Players.LocalPlayer:GetMouse()
mouse.KeyDown:Connect(function(k)
	if k == "v" then
wait(1.8)
local Anim = Instance.new("Animation")
		Anim.AnimationId = "rbxassetid://5667194069"
		local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
		k:Play()
        local args = {
            [1] = getrenv()._G.Pass,
            [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
            [3] = {
                ["Type"] = "Normal",
                ["HitEffect"] = "KnifeHitEffect",
                ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt2,
                ["Velocity"] = Vector3.new(0.2, 0, 0.2),
                ["HitTime"] = 1,
                ["CombatInv"] = true,
                ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Punch,
                ["Damage"] = 5
            }
        }


        game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
end
end)

local mouse = game.Players.LocalPlayer:GetMouse()
mouse.KeyDown:Connect(function(k)
	if k == "v" then
wait(2)
local Anim = Instance.new("Animation")
		Anim.AnimationId = "rbxassetid://5667194069"
		local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
		k:Play()
        local args = {
            [1] = getrenv()._G.Pass,
            [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
            [3] = {
                ["Type"] = "Normal",
                ["HitEffect"] = "KnifeHitEffect",
                ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt2,
                ["Velocity"] = Vector3.new(0.2, 0, 0.2),
                ["HitTime"] = 1,
                ["CombatInv"] = true,
                ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Punch,
                ["Damage"] = 5
            }
        }


        game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
end
end)

local mouse = game.Players.LocalPlayer:GetMouse()
mouse.KeyDown:Connect(function(k)
	if k == "v" then
wait(2.2)
local Anim = Instance.new("Animation")
		Anim.AnimationId = "rbxassetid://5667194069"
		local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
		k:Play()
        local args = {
            [1] = getrenv()._G.Pass,
            [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
            [3] = {
                ["Type"] = "Normal",
                ["HitEffect"] = "KnifeHitEffect",
                ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt2,
                ["Velocity"] = Vector3.new(0.2, 0, 0.2),
                ["HitTime"] = 1,
                ["CombatInv"] = true,
                ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Punch,
                ["Damage"] = 5
            }
        }


        game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
end
end)

local mouse = game.Players.LocalPlayer:GetMouse()
mouse.KeyDown:Connect(function(k)
	if k == "v" then
wait(2.4)
local Anim = Instance.new("Animation")
		Anim.AnimationId = "rbxassetid://5667194069"
		local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
		k:Play()
        local args = {
            [1] = getrenv()._G.Pass,
            [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
            [3] = {
                ["Type"] = "Normal",
                ["HitEffect"] = "KnifeHitEffect",
                ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt2,
                ["Velocity"] = Vector3.new(0.2, 0, 0.2),
                ["HitTime"] = 1,
                ["CombatInv"] = true,
                ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Punch,
                ["Damage"] = 5
            }
        }


        game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
end
end)

local mouse = game.Players.LocalPlayer:GetMouse()
mouse.KeyDown:Connect(function(k)
	if k == "v" then
wait(2.6)
local Anim = Instance.new("Animation")
		Anim.AnimationId = "rbxassetid://5667194069"
		local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
		k:Play()
        local args = {
            [1] = getrenv()._G.Pass,
            [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
            [3] = {
                ["Type"] = "Normal",
                ["HitEffect"] = "KnifeHitEffect",
                ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt2,
                ["Velocity"] = Vector3.new(0.2, 0, 0.2),
                ["HitTime"] = 1,
                ["CombatInv"] = true,
                ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Punch,
                ["Damage"] = 5
            }
        }


        game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
end
end)

local mouse = game.Players.LocalPlayer:GetMouse()
mouse.KeyDown:Connect(function(k)
	if k == "v" then
wait(2.8)
local Anim = Instance.new("Animation")
		Anim.AnimationId = "rbxassetid://5667194069"
		local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
		k:Play()
        local args = {
            [1] = getrenv()._G.Pass,
            [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
            [3] = {
                ["Type"] = "Normal",
                ["HitEffect"] = "KnifeHitEffect",
                ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt2,
                ["Velocity"] = Vector3.new(0.2, 0, 0.2),
                ["HitTime"] = 1,
                ["CombatInv"] = true,
                ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Punch,
                ["Damage"] = 5
            }
        }


        game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
end
end)

--end barrage (upper cut)  
local mouse = game.Players.LocalPlayer:GetMouse()
mouse.KeyDown:Connect(function(k)
	if k == "v" then
wait(3)
local Anim = Instance.new("Animation")
		Anim.AnimationId = "rbxassetid://4820780935"
		local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
		k:Play()
        local args = {
            [1] = getrenv()._G.Pass,
            [2] = game:service("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value,
            [3] = {
                ["Type"] = "Knockback",
                ["HitEffect"] = "KnifeHitEffect",
                ["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Knockback1,
                ["Velocity"] = Vector3.new(10, 50, 10),
                ["HitTime"] = 1,
                ["CombatInv"] = true,
                ["Sound"] = game:GetService("ReplicatedStorage").Sounds.Kick,
                ["Damage"] = 20
            }
        }


        game:GetService("ReplicatedStorage").Remotes.Damage:InvokeServer(unpack(args))
end
end)

--Dagger Combo

local mouse = game.Players.LocalPlayer:GetMouse()
mouse.KeyDown:Connect(function(k) 
	if k == "t" then 
		local Anim = Instance.new("Animation")
		Anim.AnimationId = "rbxassetid://5770352035"
		local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
		k:Play()
		k:AdjustSpeed(1)
		local A_1 = getrenv()._G.Pass
		local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
		local A_3 = 
			{
				["HitTime"] = 0.5, 
				["Type"] = "Normal", 
				["HitEffect"] = "KnifeHitEffect",
				["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1,
				["Sound"] = game:GetService("ReplicatedStorage").RogueSounds.DaggerHit,
				["Velocity"] = Vector3.new(0, 0.1, 0), 
				["CombatInv"] = true,
				["Damage"] = 1
			}
		local Event = game:GetService("ReplicatedStorage").Remotes.Damage
		Event:InvokeServer(A_1, A_2, A_3)
	end
end)

local mouse = game.Players.LocalPlayer:GetMouse()
mouse.KeyDown:Connect(function(k) 
	if k == "t" then wait(0.4)
		local Anim = Instance.new("Animation")
		Anim.AnimationId = "rbxassetid://5770385566"
		local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
		k:Play()
		k:AdjustSpeed(1)
		local A_1 = getrenv()._G.Pass
		local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
		local A_3 = 
			{
				["HitTime"] = 0.5, 
				["Type"] = "Normal", 
				["HitEffect"] = "KnifeHitEffect",
				["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1,
				["Sound"] = game:GetService("ReplicatedStorage").RogueSounds.DaggerHit,
				["Velocity"] = Vector3.new(0, 0.1, 0), 
				["CombatInv"] = true,
				["Damage"] = 1
			}
		local Event = game:GetService("ReplicatedStorage").Remotes.Damage
		Event:InvokeServer(A_1, A_2, A_3)
	end
end)

local mouse = game.Players.LocalPlayer:GetMouse()
mouse.KeyDown:Connect(function(k) 
	if k == "t" then wait(0.6)
		local Anim = Instance.new("Animation")
		Anim.AnimationId = "rbxassetid://5770352035"
		local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
		k:Play()
		k:AdjustSpeed(1)
		local A_1 = getrenv()._G.Pass
		local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
		local A_3 = 
			{
				["HitTime"] = 0.5, 
				["Type"] = "Normal", 
				["HitEffect"] = "KnifeHitEffect",
				["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1,
				["Sound"] = game:GetService("ReplicatedStorage").RogueSounds.DaggerHit,
				["Velocity"] = Vector3.new(0, 0.1, 0), 
				["CombatInv"] = true,
				["Damage"] = 1
			}
		local Event = game:GetService("ReplicatedStorage").Remotes.Damage
		Event:InvokeServer(A_1, A_2, A_3)
	end
end)

local mouse = game.Players.LocalPlayer:GetMouse()
mouse.KeyDown:Connect(function(k) 
	if k == "t" then wait(0.8)
		local Anim = Instance.new("Animation")
		Anim.AnimationId = "rbxassetid://5770385566"
		local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
		k:Play()
		k:AdjustSpeed(1)
		local A_1 = getrenv()._G.Pass
		local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
		local A_3 = 
			{
				["HitTime"] = 0.5, 
				["Type"] = "Normal", 
				["HitEffect"] = "KnifeHitEffect",
				["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1,
				["Sound"] = game:GetService("ReplicatedStorage").RogueSounds.DaggerHit,
				["Velocity"] = Vector3.new(0, 0.1, 0), 
				["CombatInv"] = true,
				["Damage"] = 1
			}
		local Event = game:GetService("ReplicatedStorage").Remotes.Damage
		Event:InvokeServer(A_1, A_2, A_3)
	end
end)

local mouse = game.Players.LocalPlayer:GetMouse()
mouse.KeyDown:Connect(function(k) 
	if k == "t" then wait(1)
		local Anim = Instance.new("Animation")
		Anim.AnimationId = "rbxassetid://5770352035"
		local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
		k:Play()
		k:AdjustSpeed(1)
		local A_1 = getrenv()._G.Pass
		local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
		local A_3 = 
			{
				["HitTime"] = 0.5, 
				["Type"] = "Normal", 
				["HitEffect"] = "KnifeHitEffect",
				["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1,
				["Sound"] = game:GetService("ReplicatedStorage").RogueSounds.DaggerHit,
				["Velocity"] = Vector3.new(0, 0.1, 0), 
				["CombatInv"] = true,
				["Damage"] = 1
			}
		local Event = game:GetService("ReplicatedStorage").Remotes.Damage
		Event:InvokeServer(A_1, A_2, A_3)
	end
end)

local mouse = game.Players.LocalPlayer:GetMouse()
mouse.KeyDown:Connect(function(k) 
	if k == "t" then wait(1.2)
		local Anim = Instance.new("Animation")
		Anim.AnimationId = "rbxassetid://5770385566"
		local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
		k:Play()
		k:AdjustSpeed(1)
		local A_1 = getrenv()._G.Pass
		local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
		local A_3 = 
			{
				["HitTime"] = 0.5, 
				["Type"] = "Normal", 
				["HitEffect"] = "KnifeHitEffect",
				["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1,
				["Sound"] = game:GetService("ReplicatedStorage").RogueSounds.DaggerHit,
				["Velocity"] = Vector3.new(0, 0.1, 0), 
				["CombatInv"] = true,
				["Damage"] = 1
			}
		local Event = game:GetService("ReplicatedStorage").Remotes.Damage
		Event:InvokeServer(A_1, A_2, A_3)
	end
end)

local mouse = game.Players.LocalPlayer:GetMouse()
mouse.KeyDown:Connect(function(k) 
	if k == "t" then wait(1.4)
		local Anim = Instance.new("Animation")
		Anim.AnimationId = "rbxassetid://5770352035"
		local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
		k:Play()
		k:AdjustSpeed(1)
		local A_1 = getrenv()._G.Pass
		local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
		local A_3 = 
			{
				["HitTime"] = 0.5, 
				["Type"] = "Normal", 
				["HitEffect"] = "KnifeHitEffect",
				["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1,
				["Sound"] = game:GetService("ReplicatedStorage").RogueSounds.DaggerHit,
				["Velocity"] = Vector3.new(0, 0.1, 0), 
				["CombatInv"] = true,
				["Damage"] = 1
			}
		local Event = game:GetService("ReplicatedStorage").Remotes.Damage
		Event:InvokeServer(A_1, A_2, A_3)
	end
end)

local mouse = game.Players.LocalPlayer:GetMouse()
mouse.KeyDown:Connect(function(k) 
	if k == "t" then wait(1.6)
		local Anim = Instance.new("Animation")
		Anim.AnimationId = "rbxassetid://5770385566"
		local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
		k:Play()
		k:AdjustSpeed(1)
		local A_1 = getrenv()._G.Pass
		local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
		local A_3 = 
			{
				["HitTime"] = 0.5, 
				["Type"] = "Normal", 
				["HitEffect"] = "KnifeHitEffect",
				["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1,
				["Sound"] = game:GetService("ReplicatedStorage").RogueSounds.DaggerHit,
				["Velocity"] = Vector3.new(0, 0.1, 0), 
				["CombatInv"] = true,
				["Damage"] = 1
			}
		local Event = game:GetService("ReplicatedStorage").Remotes.Damage
		Event:InvokeServer(A_1, A_2, A_3)
	end
end)

local mouse = game.Players.LocalPlayer:GetMouse()
mouse.KeyDown:Connect(function(k) 
	if k == "t" then wait(1.8)
		local Anim = Instance.new("Animation")
		Anim.AnimationId = "rbxassetid://5770352035"
		local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
		k:Play()
		k:AdjustSpeed(1)
		local A_1 = getrenv()._G.Pass
		local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
		local A_3 = 
			{
				["HitTime"] = 0.5, 
				["Type"] = "Normal", 
				["HitEffect"] = "KnifeHitEffect",
				["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1,
				["Sound"] = game:GetService("ReplicatedStorage").RogueSounds.DaggerHit,
				["Velocity"] = Vector3.new(0, 0.1, 0), 
				["CombatInv"] = true,
				["Damage"] = 1
			}
		local Event = game:GetService("ReplicatedStorage").Remotes.Damage
		Event:InvokeServer(A_1, A_2, A_3)
	end
end)

local mouse = game.Players.LocalPlayer:GetMouse()
mouse.KeyDown:Connect(function(k) 
	if k == "t" then wait(2)
		local Anim = Instance.new("Animation")
		Anim.AnimationId = "rbxassetid://5770385566"
		local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
		k:Play()
		k:AdjustSpeed(1)
		local A_1 = getrenv()._G.Pass
		local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
		local A_3 = 
			{
				["HitTime"] = 0.5, 
				["Type"] = "Normal", 
				["HitEffect"] = "KnifeHitEffect",
				["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1,
				["Sound"] = game:GetService("ReplicatedStorage").RogueSounds.DaggerHit,
				["Velocity"] = Vector3.new(0, 0.1, 0), 
				["CombatInv"] = true,
				["Damage"] = 1
			}
		local Event = game:GetService("ReplicatedStorage").Remotes.Damage
		Event:InvokeServer(A_1, A_2, A_3)
	end
end)

local mouse = game.Players.LocalPlayer:GetMouse()
mouse.KeyDown:Connect(function(k) 
	if k == "t" then wait(2.2)
		local A_1 = getrenv()._G.Pass
		local A_2 = game:GetService("Players").LocalPlayer.Backpack.Main.LockOnScript.LockOn.Value
		local A_3 = 
			{
				["HitTime"] = 0.2, 
				["Type"] = "Knockback", 
				["HitEffect"] = "KnifeHitEffect",
				["HurtAnimation"] = game:GetService("ReplicatedStorage").Animations.HurtAnimations.Hurt1,
				["Sound"] = game:GetService("ReplicatedStorage").RogueSounds.DaggerHit,
				["Velocity"] = Vector3.new(0, 0, 80), 
				["CombatInv"] = true,
				["Damage"] = 35
			}
		local Event = game:GetService("ReplicatedStorage").Remotes.Damage
		Event:InvokeServer(A_1, A_2, A_3)
	

    end
end)
wait(2)
game.StarterGui:SetCore("SendNotification", {
    Title = "KeyBinds:";
    Text = "Z, X, C, V, H, T";
    })
