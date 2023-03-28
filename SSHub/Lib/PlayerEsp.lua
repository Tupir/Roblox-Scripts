-- #region Services
local RunService = game:GetService("RunService")
local Cam = workspace.CurrentCamera;
local Players = game:GetService("Players")
local Plr = Players.LocalPlayer
local WorldToViewportPoint = Cam.WorldToViewportPoint
local WorldToScreen = Cam.WorldToScreenPoint
local GetPartsObscuringTarget = Cam.GetPartsObscuringTarget
--#endregion

local Class = {
    "MeshPart",
    "UnionOperation",
    "Part"
}

local function TableRemove(Table, Item)
    local Index = nil
    for i, v in ipairs (Table) do 
        if (v == Item) then
            Index = i 
        end
    end
table.remove(Table, Index)
end

local function Draw(obj, props)
	local new = Drawing.new(obj)

	props = props or {}
	for i,v in pairs(props) do
		new[i] = v
	end
    
    return new
end

local SShubEsp = {
    Enabled = true,
    Players = {
        Enabled = false,
        Name = {false, Color3.fromRGB(255,255,255)},
        Health = {false, Color3.fromRGB(255,255,255)},
        Team = {false, Color3.fromRGB(255,255,255)},
        Tool = {false, Color3.fromRGB(255,255,255)},
        Backpack = {false, Color3.fromRGB(255,255,255)},
        Tracers = {false, Color3.fromRGB(255,255,255)},
        Distance = {false, Color3.fromRGB(255,255,255)},
        Boxes = {false, Color3.fromRGB(255,255,255)},
        TeamCheck = {false, Color3.fromRGB(255,0,0), Color3.fromRGB(0,255,0)},
        BoxShift = 1.5,
	    BoxSize = 2500,
        BoxStretch = 0.75,
        MaxDistance = 10000,
        Draws = {}
    },
    Extra = {
        Enabled = true
    }
}

function SShubEsp:NewIndex(Index, Value, Extras)
    Index = Index or "Global"
    if SShubEsp.Extra[Index] == nil then
        SShubEsp.Extra[Index]={
            Enabled = Value or true,
            Boxes = {Enabled = true, Color = Color3.fromRGB(255,255,255), Y = 0, X = 0, Size = 0},
            GoblalColor = {false, Color3.fromRGB(255,255,255)},
            Title = {true, Color3.fromRGB(255,255,255), "Title"},
            Distance = {true, Color3.fromRGB(255,255,255)},
            Separation = 12,
            MaxDistance = 10000,
            Draws = {}
        }
        if Extras ~= nil and typeof(Extras) == "table" then
            for i,v in pairs(Extras) do
                if SShubEsp.Extra[Index][i] == nil then
                    SShubEsp.Extra[Index][i] = v
                end 
            end
        end
    end
end

local function GeneratePlayerEsp(Player)
    local function InfoUpdate()
        repeat task.wait() until Player.Character ~= nil and Player.Character:FindFirstChild("Humanoid") and Player.Character:FindFirstChild("Humanoid").Health > 0 and Player.Character:FindFirstChild("HumanoidRootPart")
        SShubEsp.Players.Draws[Player.Name] = {
            Box = {},
            ["Backpack"] = Draw("Text", {
                Visible = false,
                Center = true,
                Outline = true,
                Color = SShubEsp.Players.Backpack[2],
                Font = 3,
                Size = 16,
                Text = "Backpack"
            }),
            ["Tool"] = Draw("Text", {
                Visible = false,
                Center = true,
                Outline = true,
                Color = SShubEsp.Players.Tool[2],
                Font = 3,
                Size = 16,
                Text = "Tool"
            }),
            ["Distance"] = Draw("Text", {
                Visible = false,
                Center = true,
                Outline = true,
                Color = SShubEsp.Players.Distance[2],
                Font = 3,
                Size = 16,
                Text = "Distance"
            }),
            ["Team"] = Draw("Text", {
                Visible = false,
                Center = true,
                Outline = true,
                Color = SShubEsp.Players.Team[2],
                Font = 3,
                Size = 16,
                Text = "Team"
            }),
            ["Health"] = Draw("Text", {
                Visible = false,
                Center = true,
                Outline = true,
                Color = SShubEsp.Players.Health[2],
                Font = 3,
                Size = 16,
                Text = "Health"
            }),
            ["Name"] = Draw("Text", {
                Visible = false,
                Center = true,
                Outline = true,
                Color = SShubEsp.Players.Name[2],
                Font = 3,
                Size = 16,
                Text = "Name"
            })
        }

        for i = 1, 8 do
            table.insert(SShubEsp.Players.Draws[Player.Name].Box, Draw("Line", {
                Thickness = 1.5,
                Color = SShubEsp.Players.Boxes[2],
                Transparency = 1,
                Visible = SShubEsp.Players.Boxes[1]
            }))
        end

        local function TextsVis(State)
            pcall(function()
                for _,v in pairs(SShubEsp.Players.Draws[Player.Name]) do
                    if v ~= nil and type(v) == "table" then
                        v.Visible = State
                    end
                end
            end)
        end

        local function RemoveEsp()
            SShubEsp.Players.Draws[Player.Name]=nil
        end

        local function RemoveTexts()
            pcall(function()
                for _,v in pairs(SShubEsp.Players.Draws[Player.Name]) do
                    if v ~= nil and type(v) == "table" then
                        v:Remove()
                    end
                end
            end)
        end

        local function BoxVis(State)
            pcall(function()
                for _,v in pairs(SShubEsp.Players.Draws[Player.Name].Box) do
                    if v ~= nil and type(v) == "table" then
                        v.Visible = State
                    end
                end
            end)
        end

        local function BoxColor(Color)
            pcall(function()
                for _,v in pairs(SShubEsp.Players.Draws[Player.Name].Box) do
                    if v ~= nil and type(v) == "table" then
                        v.Color = Color
                    end
                end
            end)
        end

        local function RemoveBox()
            pcall(function()
                for _,v in pairs(SShubEsp.Players.Draws[Player.Name].Box) do
                    if v ~= nil and type(v) == "table" then
                        v:Remove()
                    end
                end
            end)
        end

        if Player.Character ~= nil and Player.Character:FindFirstChild("HumanoidRootPart") then
            local Iu
            Iu = RunService.RenderStepped:Connect(function()
                if workspace:IsAncestorOf(Player.Character) and Player.Character:FindFirstChild("Humanoid").Health>0 then
                    if SShubEsp.Enabled then
                        if SShubEsp.Players.Enabled then
                            local Distance = math.round((Cam.CFrame.Position-Player.Character:FindFirstChild("HumanoidRootPart").Position).magnitude)
                            if Distance < SShubEsp.Players.MaxDistance then
                                local RootPart = Player.Character:FindFirstChild("HumanoidRootPart")
                                local Humanoid = Player.Character:FindFirstChild("Humanoid")
                                local RootVector, OnScreen = WorldToViewportPoint(Cam, RootPart.Position)
                                
                                local Size = SShubEsp.Players.BoxSize/RootVector.Z
                                local NewSizeX = Size --[[* SShubEsp.Players.BoxStretch]] / 2
                                local NewSizeY = Size * SShubEsp.Players.BoxShift / 2

                                local UpLeft = Vector2.new(RootVector.X-NewSizeX, RootVector.Y-NewSizeY)
                                local UpRight = Vector2.new(RootVector.X+NewSizeX, RootVector.Y-NewSizeY)
                                local LowLeft = Vector2.new(RootVector.X-NewSizeX, RootVector.Y+NewSizeY)
                                local LowRight = Vector2.new(RootVector.X+NewSizeX, RootVector.Y+NewSizeY)

                                local DirectionH = Vector2.new(Size/4, 0)
                                local DirectionV = Vector2.new(0, Size/4)

                                local TextsPos = Vector2.new(RootVector.X, RootVector.Y+NewSizeY-10)
                                local Torso = Vector2.new(RootVector.X, RootVector.Y)
                                
                                if OnScreen then
                                    if SShubEsp.Players.Name[1] then
                                        SShubEsp.Players.Draws[Player.Name]["Name"].Text = Player.Name
                                        SShubEsp.Players.Draws[Player.Name]["Name"].Position = TextsPos
                                        SShubEsp.Players.Draws[Player.Name]["Name"].Visible = true
                                        SShubEsp.Players.Draws[Player.Name]["Name"].Color = SShubEsp.Players.Name[2]
                                    else
                                        SShubEsp.Players.Draws[Player.Name]["Name"].Visible = false
                                    end

                                    local TotalPos = TextsPos
                                    for Index,v in pairs(SShubEsp.Players.Draws[Player.Name]) do
                                        if v.Visible and SShubEsp.Players[Index][1] then
                                            v.Position = TotalPos + Vector2.new(0,12)
                                            v.Color = SShubEsp.Players[Index][2]
                                            TotalPos = v.Position
                                        end
                                    end
                                    
                                    if SShubEsp.Players.Distance[1] then
                                        SShubEsp.Players.Draws[Player.Name]["Distance"].Visible = true
                                        SShubEsp.Players.Draws[Player.Name]["Distance"].Text = "Distance: "..Distance.."m"
                                    else
                                        SShubEsp.Players.Draws[Player.Name]["Distance"].Visible = false
                                    end

                                    if SShubEsp.Players.Health[1] and Humanoid.Health > 0 then
                                        SShubEsp.Players.Draws[Player.Name]["Health"].Visible = true
                                        SShubEsp.Players.Draws[Player.Name]["Health"].Text = "Health: "..tostring(math.round(Humanoid.Health/Humanoid.MaxHealth*100)).."% "
                                    else
                                        SShubEsp.Players.Draws[Player.Name]["Health"].Visible = false
                                    end

                                    if SShubEsp.Players.Team[1] and Player.Team ~= nil then
                                        if SShubEsp.Players.TeamCheck[1] then
                                            if Player.Team ~= Plr.Team then
                                                SShubEsp.Players.Draws[Player.Name]["Team"].Visible = true
                                                SShubEsp.Players.Draws[Player.Name]["Team"].Text = "Team: "..tostring(Player.Team)
                                                SShubEsp.Players.Draws[Player.Name]["Team"].Color = SShubEsp.Players.TeamCheck[2]
                                            else
                                                SShubEsp.Players.Draws[Player.Name]["Team"].Visible = true
                                                SShubEsp.Players.Draws[Player.Name]["Team"].Text = "Team: "..tostring(Player.Team)
                                                SShubEsp.Players.Draws[Player.Name]["Team"].Color = SShubEsp.Players.TeamCheck[3]
                                            end
                                        else
                                            SShubEsp.Players.Draws[Player.Name]["Team"].Visible = true
                                            SShubEsp.Players.Draws[Player.Name]["Team"].Text = "Team: "..tostring(Player.Team)
                                        end
                                    else
                                        SShubEsp.Players.Draws[Player.Name]["Team"].Visible = false
                                    end

                                    if SShubEsp.Players.Tool[1] and Player.Character:FindFirstChildOfClass("Tool") then
                                        SShubEsp.Players.Draws[Player.Name]["Tool"].Visible = true
                                        SShubEsp.Players.Draws[Player.Name]["Tool"].Text = "["..tostring(Player.Character:FindFirstChildOfClass("Tool")).."]" or "["..Player.Character:FindFirstChildOfClass("Tool").Name.."]"
                                    else
                                        SShubEsp.Players.Draws[Player.Name]["Tool"].Visible = false
                                    end
                                    if SShubEsp.Players.Backpack[1] and #Player.Backpack:GetChildren() > 0 then
                                        local BackpackTable = {}
                                        for i,v in pairs(Player.Backpack:GetChildren()) do
                                            table.insert(BackpackTable,tostring(v))
                                        end
                                        Player.Backpack.ChildAdded:Connect(function(Child)
                                            table.insert(BackpackTable,Child)
                                        end)
                                        Player.Backpack.ChildRemoved:Connect(function(Child)
                                            TableRemove(BackpackTable,Child)
                                        end)
                                        SShubEsp.Players.Draws[Player.Name]["Backpack"].Visible = true
                                        SShubEsp.Players.Draws[Player.Name]["Backpack"].Text = "["..table.concat(BackpackTable, ", ").."]"
                                    else
                                        SShubEsp.Players.Draws[Player.Name]["Backpack"].Visible = false
                                    end

                                    if SShubEsp.Players.Boxes[1] then
                                        BoxVis(true)
                                        BoxColor(SShubEsp.Players.Boxes[2])
                                        SShubEsp.Players.Draws[Player.Name].Box[1].From = UpRight
                                        SShubEsp.Players.Draws[Player.Name].Box[1].To = UpRight - DirectionH

                                        SShubEsp.Players.Draws[Player.Name].Box[2].From = UpRight
                                        SShubEsp.Players.Draws[Player.Name].Box[2].To = UpRight + DirectionV

                                        SShubEsp.Players.Draws[Player.Name].Box[3].From = UpLeft
                                        SShubEsp.Players.Draws[Player.Name].Box[3].To = UpLeft + DirectionH

                                        SShubEsp.Players.Draws[Player.Name].Box[4].From = UpLeft
                                        SShubEsp.Players.Draws[Player.Name].Box[4].To = UpLeft + DirectionV

                                        SShubEsp.Players.Draws[Player.Name].Box[5].From = LowRight
                                        SShubEsp.Players.Draws[Player.Name].Box[5].To = LowRight - DirectionH

                                        SShubEsp.Players.Draws[Player.Name].Box[6].From = LowRight
                                        SShubEsp.Players.Draws[Player.Name].Box[6].To = LowRight - DirectionV

                                        SShubEsp.Players.Draws[Player.Name].Box[7].From = LowLeft
                                        SShubEsp.Players.Draws[Player.Name].Box[7].To = LowLeft + DirectionH

                                        SShubEsp.Players.Draws[Player.Name].Box[8].From = LowLeft
                                        SShubEsp.Players.Draws[Player.Name].Box[8].To = LowLeft - DirectionV
                                    else
                                        BoxVis(false)
                                    end
                                else
                                    TextsVis(false)
                                    BoxVis(false)
                                end
                            else
                                TextsVis(false)
                                BoxVis(false)
                            end
                        else
                            TextsVis(false)
                            BoxVis(false)
                        end
                    else
                        TextsVis(false)
                        BoxVis(false)
                    end
                else
                    Iu:Disconnect()
                    RemoveBox()
                    RemoveTexts()
                    RemoveEsp()
                end
            end)
        end
    end
    coroutine.wrap(InfoUpdate)()
end

function SShubEsp:CreatePlayerEsp()
    for i,v in pairs(Players:GetPlayers()) do
        if v ~= Plr then
            GeneratePlayerEsp(v)
            v.CharacterAdded:Connect(function(c)
                repeat task.wait() until c:FindFirstChild("Humanoid")
                GeneratePlayerEsp(v)
            end)
        end
    end
    Players.PlayerAdded:Connect(function(player)
        if player ~= Plr then
            player.CharacterAdded:Connect(function(c)
                repeat task.wait() until c:FindFirstChild("Humanoid")
                GeneratePlayerEsp(player)
            end)
        end
    end)
end

function SShubEsp:NewEsp(Instance, Add, ExtraTexts)
    local Esp = {
        Index = Add.Index or "Global",
        Boxes = {
            Enabled = Add.Boxes.Enabled or true,
            Color = Add.Boxes.Color or Color3.fromRGB(255,255,255),
            X = Add.Boxes.X or 0.75,
            Y = Add.Boxes.Y or 1.5,
            Size = Add.Boxes.Size or 2500
        },
        Title = {
            Enabled = Add.Title.Enabled or true,
            Color = Add.Title.Color or Color3.fromRGB(255,255,255),
            Text = Add.Title.Text or tostring(Instance) or ""
        },
        Distance = {
            Enabled = Add.Title.Enabled or true,
            Color = Add.Title.Color or Color3.fromRGB(255,255,255),
        }
    }
    if Instance ~= nil then
        if table.find(Class, Instance.ClassName) then
            SShubEsp:NewIndex(Esp.Index, true, ExtraTexts)

            SShubEsp.Extra[Esp.Index].Boxes.Enabled = Esp.Boxes.Enabled
            SShubEsp.Extra[Esp.Index].Boxes.Color = Esp.Boxes.Color
            SShubEsp.Extra[Esp.Index].Boxes.Size = Esp.Boxes.Size
            SShubEsp.Extra[Esp.Index].Boxes.X = Esp.Boxes.X
            SShubEsp.Extra[Esp.Index].Boxes.Y = Esp.Boxes.Y

            SShubEsp.Extra[Esp.Index].Title[1] = Esp.Title.Enabled
            SShubEsp.Extra[Esp.Index].Title[2] = Esp.Title.Color
            SShubEsp.Extra[Esp.Index].Title[3] = Esp.Title.Text

            local function InfoUpdate()
                SShubEsp.Extra[Esp.Index].Draws[tostring(Instance)] = {
                    Box = {},
                    ["Title"] = Draw("Text", {
                        Visible = false,
                        Center = true,
                        Outline = true,
                        Color = SShubEsp.Extra[Esp.Index].Title[2],
                        Font = 3,
                        Size = 16,
                        Text = SShubEsp.Extra[Esp.Index].Title[3]
                    }),
                    ["Distance"] = Draw("Text", {
                        Visible = false,
                        Center = true,
                        Outline = true,
                        Color = SShubEsp.Extra[Esp.Index].Distance[2],
                        Font = 3,
                        Size = 16,
                        Text = "0"
                    })
                }
                
                for i,v in pairs(ExtraTexts) do
                    if SShubEsp.Extra[Esp.Index].Draws[tostring(Instance)][i] == nil then
                        SShubEsp.Extra[Esp.Index].Draws[tostring(Instance)][i] = Draw("Text", {
                            Visible = false,
                            Center = true,
                            Outline = true,
                            Color = SShubEsp.Extra[Esp.Index][i][2],
                            Font = 3,
                            Size = 16,
                            Text = SShubEsp.Extra[Esp.Index][i][3]
                        })
                    end
                end

                for i = 1, 8 do
                    table.insert(SShubEsp.Extra[Esp.Index].Draws[tostring(Instance)].Box, Draw("Line", {
                        Thickness = 1.5,
                        Color = SShubEsp.Extra[Esp.Index].Boxes.Color,
                        Transparency = 1,
                        Visible = SShubEsp.Extra[Esp.Index].Boxes.Enabled
                    }))
                end
        
                local function TextsVis(State)
                    pcall(function()
                        for _,v in pairs(SShubEsp.Extra[Esp.Index].Draws[tostring(Instance)]) do
                            if v ~= nil and type(v) == "table" then
                                v.Visible = State
                            end
                        end
                    end)
                end
        
                local function RemoveEsp()
                    SShubEsp.Extra[Esp.Index].Draws[tostring(Instance)]=nil
                end
        
                local function RemoveTexts()
                    pcall(function()
                        for _,v in pairs(SShubEsp.Extra[Esp.Index].Draws[tostring(Instance)]) do
                            if v ~= nil and type(v) == "table" then
                                v:Remove()
                            end
                        end
                    end)
                end
        
                local function BoxVis(State)
                    pcall(function()
                        for _,v in pairs(SShubEsp.Extra[Esp.Index].Draws[tostring(Instance)].Box) do
                            if v ~= nil and type(v) == "table" then
                                v.Visible = State
                            end
                        end
                    end)
                end
        
                local function BoxColor(Color)
                    pcall(function()
                        for _,v in pairs(SShubEsp.Extra[Esp.Index].Draws[tostring(Instance)].Box) do
                            if v ~= nil and type(v) == "table" then
                                v.Color = Color
                            end
                        end
                    end)
                end
        
                local function RemoveBox()
                    pcall(function()
                        for _,v in pairs(SShubEsp.Extra[Esp.Index].Draws[tostring(Instance)].Box) do
                            if v ~= nil and type(v) == "table" then
                                v:Remove()
                            end
                        end
                    end)
                end
        
                local Iu
                Iu = RunService.RenderStepped:Connect(function()
                    if workspace:IsAncestorOf(Instance) then
                        if SShubEsp.Enabled then
                            if SShubEsp.Extra.Enabled then
                                local Distance = math.round((Cam.CFrame.Position-Instance.Position).magnitude)
                                if Distance < SShubEsp.Extra[Esp.Index].MaxDistance then
                                    local RootVector, OnScreen = WorldToViewportPoint(Cam, Instance.Position)
                                    
                                    local Size = SShubEsp.Extra[Esp.Index].Boxes.Size/RootVector.Z
                                    local NewSizeX = Size --[[* SShubEsp.Extra[Esp.Index].Boxes.X]] / 2
                                    local NewSizeY = Size * SShubEsp.Extra[Esp.Index].Boxes.Y / 2

                                    local UpLeft = Vector2.new(RootVector.X-NewSizeX, RootVector.Y-NewSizeY)
                                    local UpRight = Vector2.new(RootVector.X+NewSizeX, RootVector.Y-NewSizeY)
                                    local LowLeft = Vector2.new(RootVector.X-NewSizeX, RootVector.Y+NewSizeY)
                                    local LowRight = Vector2.new(RootVector.X+NewSizeX, RootVector.Y+NewSizeY)

                                    local DirectionH = Vector2.new(Size/4, 0)
                                    local DirectionV = Vector2.new(0, Size/4)

                                    local TextsPos = Vector2.new(RootVector.X, RootVector.Y+NewSizeY-10)
                                    local Center = Vector2.new(RootVector.X, RootVector.Y)
                                    
                                    if OnScreen then
                                        if SShubEsp.Extra[Esp.Index].Title[1] then
                                            SShubEsp.Extra[Esp.Index].Draws[tostring(Instance)]["Title"].Text = SShubEsp.Extra[Esp.Index].Title[3]
                                            SShubEsp.Extra[Esp.Index].Draws[tostring(Instance)]["Title"].Position = TextsPos
                                            SShubEsp.Extra[Esp.Index].Draws[tostring(Instance)]["Title"].Visible = true
                                            SShubEsp.Extra[Esp.Index].Draws[tostring(Instance)]["Title"].Color = SShubEsp.Extra[Esp.Index].Title[2]
                                        else
                                            SShubEsp.Extra[Esp.Index].Draws[tostring(Instance)]["Title"].Visible = false
                                        end

                                        if SShubEsp.Extra[Esp.Index].Distance[1] then
                                            SShubEsp.Extra[Esp.Index].Draws[tostring(Instance)]["Distance"].Visible = true
                                            SShubEsp.Extra[Esp.Index].Draws[tostring(Instance)]["Distance"].Text = "Distance: "..Distance.."m"
                                        else
                                            SShubEsp.Extra[Esp.Index].Draws[tostring(Instance)]["Distance"].Visible = false
                                        end

                                        local TotalPos = TextsPos
                                        for Index,v in pairs(SShubEsp.Extra[Esp.Index].Draws[tostring(Instance)]) do
                                            if SShubEsp.Extra[Esp.Index][Index][1] then
                                                v.Visible = true
                                                if v.Visible then
                                                    v.Text = SShubEsp.Extra[Esp.Index][Index][3]
                                                    v.Position = TotalPos + Vector2.new(0,SShubEsp.Extra[Esp.Index].Separation)
                                                    v.Color = SShubEsp.Extra[Esp.Index][Index][2]
                                                    TotalPos = v.Position
                                                end
                                            else
                                                v.Visible = false
                                            end
                                        end

                                        if SShubEsp.Extra[Esp.Index].Boxes.Enabled then
                                            BoxVis(true)
                                            BoxColor(SShubEsp.Players.Boxes[2])
                                            SShubEsp.Extra[Esp.Index].Draws[tostring(Instance)].Box[1].From = UpRight
                                            SShubEsp.Extra[Esp.Index].Draws[tostring(Instance)].Box[1].To = UpRight - DirectionH

                                            SShubEsp.Extra[Esp.Index].Draws[tostring(Instance)].Box[2].From = UpRight
                                            SShubEsp.Extra[Esp.Index].Draws[tostring(Instance)].Box[2].To = UpRight + DirectionV

                                            SShubEsp.Extra[Esp.Index].Draws[tostring(Instance)].Box[3].From = UpLeft
                                            SShubEsp.Extra[Esp.Index].Draws[tostring(Instance)].Box[3].To = UpLeft + DirectionH

                                            SShubEsp.Extra[Esp.Index].Draws[tostring(Instance)].Box[4].From = UpLeft
                                            SShubEsp.Extra[Esp.Index].Draws[tostring(Instance)].Box[4].To = UpLeft + DirectionV

                                            SShubEsp.Extra[Esp.Index].Draws[tostring(Instance)].Box[5].From = LowRight
                                            SShubEsp.Extra[Esp.Index].Draws[tostring(Instance)].Box[5].To = LowRight - DirectionH

                                            SShubEsp.Extra[Esp.Index].Draws[tostring(Instance)].Box[6].From = LowRight
                                            SShubEsp.Extra[Esp.Index].Draws[tostring(Instance)].Box[6].To = LowRight - DirectionV

                                            SShubEsp.Extra[Esp.Index].Draws[tostring(Instance)].Box[7].From = LowLeft
                                            SShubEsp.Extra[Esp.Index].Draws[tostring(Instance)].Box[7].To = LowLeft + DirectionH

                                            SShubEsp.Extra[Esp.Index].Draws[tostring(Instance)].Box[8].From = LowLeft
                                            SShubEsp.Extra[Esp.Index].Draws[tostring(Instance)].Box[8].To = LowLeft - DirectionV
                                        else
                                            BoxVis(false)
                                        end
                                    else
                                        TextsVis(false)
                                        BoxVis(false)
                                    end
                                else
                                    TextsVis(false)
                                    BoxVis(false)
                                end
                            else
                                TextsVis(false)
                                BoxVis(false)
                            end
                        else
                            TextsVis(false)
                            BoxVis(false)
                        end
                    else
                        Iu:Disconnect()
                        RemoveBox()
                        RemoveTexts()
                        RemoveEsp()
                    end
                end)
            end
            coroutine.wrap(InfoUpdate)()
        end
    end
    return Esp
end
return SShubEsp
