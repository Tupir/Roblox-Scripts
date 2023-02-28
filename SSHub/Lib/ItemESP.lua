-- #region Services
local RunService = game:GetService("RunService")
local Cam = workspace.CurrentCamera;
local Player = game:GetService("Players").LocalPlayer
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

local SShubEsp = {
    Enabled = true,
    MaxDistance = 9e9,
    Info = {}
}
local Class = {
    "MeshPart",
    "UnionOperation",
    "Part"
}
function SShubEsp:NewToggle(Toggle, Value)
    if Toggle ~= nil then
        if SShubEsp.Info[Toggle] == nil then
            SShubEsp.Info[Toggle] = {
                Enabled = Value or true,
                SubText = true,
                Distance = false,
                ExtraText = true,
                Remove = false
            }
        else
            error("Theres are alredy a toggle called: "..Toggle.."!")
        end
    end
end
function SShubEsp:RemoveToggle(Esp)
    local Remove = {}
    
    if SShubEsp.Info[Esp] ~= nil then
        SShubEsp.Info[Esp].Remove = true
        TableRemove(SShubEsp.Info, Esp)
    else
        error("Error Cant find a valid Toggle: ".. tostring(Esp))
    end

    return Remove
end

function SShubEsp:RemoveEsp(Esp)
local Remove = {}

if SShubEsp.Info[Esp] ~= nil then
    SShubEsp.Info[Esp].Remove = true
else
    error("Error Cant find a valid Esp: ".. tostring(Esp))
end

return Remove
end

function SShubEsp:NewEsp(Item, Extra)
    local Esp = {
        Transparency = Extra.Transparency or false,
        SubText = tostring(Extra.SubText[1][Extra.SubText[2]]) or "N/A",
        ExtraText = tostring(Extra.ExtraText[1][Extra.ExtraText[2]]) or "N/A",
        Color = Extra.Color or Color3.new(1, 2.5, 2.5),
        Folder = Extra.Folder or workspace,
        Name = tostring(Extra.Name)or Item.Name,
        Font = Extra.Font or 2,
        Index = tostring(Extra.Index) or "Global",
        SubTextToggle = Extra.SubTextToggle or false,
        DistanceText = Extra.Distance or false,
        ExtraTextToggle = Extra.ExtraTextToggle or false
    }
    local RemoveBoolean = false
    function Esp:Remove()
        RemoveBoolean = true
    end

    if table.find(Class, Item.ClassName) then
        if Esp.Folder ~= nil then
            --Functions
            local function Transparent(v)
                if not Esp.Transparency then
                    if v.Transparency == 1 then
                        return false
                    end
                elseif Esp.Transparency then
                    if v.Transparency == 1 then
                        return true
                    else
                        return false
                    end
                else
                    return false
                end
            end

            --Index Creation
            if SShubEsp.Info[Esp.Index] == nil then
                SShubEsp.Info[Esp.Index] = {
                    Enabled = true,
                    SubText = Esp.SubTextToggle or true,
                    Distance = Esp.DistanceText,
                    ExtraText = Esp.ExtraTextToggle or true,
                    Remove = false
                }
            elseif SShubEsp.Info[Esp.Index] ~= nil then
                SShubEsp.Info[Esp.Index].SubText = Esp.SubTextToggle
                SShubEsp.Info[Esp.Index].ExtraText = Esp.ExtraTextToggle
                SShubEsp.Info[Esp.Index].Distance = Esp.DistanceText
            end

            --Drawing
            local ItemName = Drawing.new("Text")
            ItemName.Visible = false
            ItemName.Center = true
            ItemName.Outline = true
            ItemName.Font = Esp.Font
            ItemName.Size = 13
            ItemName.Color = Color3.new(1, 2.5, 2.5)
            ItemName.Text = Esp.Name

            local SubText = Drawing.new("Text")
            SubText.Visible = false
            SubText.Center = true
            SubText.Outline = true
            SubText.Font = Esp.Font
            SubText.Size = 13
            SubText.Color = Color3.new(1, 2.5, 2.5)
            SubText.Text = tostring(Extra.SubText[1][Extra.SubText[2]])
            
            local ExtraText = Drawing.new("Text")
            ExtraText.Visible = false
            ExtraText.Center = true
            ExtraText.Outline = true
            ExtraText.Font = Esp.Font
            ExtraText.Size = 13
            ExtraText.Color = Color3.new(1, 2.5, 2.5)
            ExtraText.Text = tostring(Extra.ExtraText[1][Extra.ExtraText[2]])

            local DistanceText = Drawing.new("Text")
            DistanceText.Visible = false
            DistanceText.Center = true
            DistanceText.Outline = true
            DistanceText.Font = Esp.Font
            DistanceText.Size = 13
            DistanceText.Color = Color3.new(1, 2.5, 2.5)
            DistanceText.Text = "Distance"

            local function InfoUpdate()
                local Iu
                Iu = RunService.RenderStepped:Connect(function()
                    if not Esp.Folder:IsAncestorOf(Item) or Transparent(Item) or RemoveBoolean or SShubEsp.Info[Esp.Index].Remove then
                        Iu:Disconnect()
                        ItemName:Remove()
                        ExtraText:Remove()
                        SubText:Remove()
                        DistanceText:Remove()
                    else
                        local Vector, OnScreen = Cam:WorldToViewportPoint(Item.Position)
                        if OnScreen then
                            ItemName.Position = Vector2.new(Vector.X, Vector.Y - 50)
                            if SShubEsp.Info[Esp.Index].SubText then
                                SubText.Position = Vector2.new(Vector.X, Vector.Y - 40)
                            end
                            if SShubEsp.Info[Esp.Index].ExtraText then
                                ExtraText.Position = Vector2.new(Vector.X, Vector.Y - 30)
                            end
                            if SShubEsp.Info[Esp.Index].Distance then
                                DistanceText.Position = Vector2.new(Vector.X, Vector.Y - 20)
                            end

                            local ItemDistance = math.ceil((Item.Position - game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).magnitude)
                            if SShubEsp.Enabled then
                                if ItemDistance < SShubEsp.MaxDistance then
                                    if Esp.Index ~= "Global" then
                                        if SShubEsp.Info[Esp.Index].Enabled == true then
                                            ItemName.Text = Esp.Name
                                            ItemName.Visible = true
                                            if SShubEsp.Info[Esp.Index].SubText and Esp.SubText ~= "N/A" then
                                                SubText.Text = tostring(Extra.SubText[1][Extra.SubText[2]])
                                                SubText.Color = Esp.Color
                                                ItemName.Color = Esp.Color
                                                SubText.Visible = true
                                            else
                                                SubText.Visible = false
                                            end
                                            if SShubEsp.Info[Esp.Index].Distance then
                                                DistanceText.Visible = true
                                                DistanceText.Text = "["..tostring(ItemDistance).."]"
                                            else
                                                DistanceText.Visible = false
                                            end
                                            if SShubEsp.Info[Esp.Index].ExtraText and Esp.ExtraText ~= "N/A" then
                                                ExtraText.Text = tostring(Extra.ExtraText[1][Extra.ExtraText[2]])
                                                ExtraText.Visible = true
                                            else
                                                ExtraText.Visible = false
                                            end
                                        else
                                            ItemName.Visible = false
                                            SubText.Visible = false
                                            ExtraText.Visible = false
                                            DistanceText.Visible = false
                                        end
                                    else
                                        ItemName.Text = Esp.Name
                                        ItemName.Visible = true
                                        if SShubEsp.Info[Esp.Index].SubText and Esp.SubText ~= "N/A" then
                                            SubText.Text = tostring(Extra.SubText[1][Extra.SubText[2]])
                                            SubText.Color = Esp.Color
                                            ItemName.Color = Esp.Color
                                            SubText.Visible = true
                                        else
                                            SubText.Visible = false
                                        end
                                        if SShubEsp.Info[Esp.Index].Distance then
                                            DistanceText.Visible = true
                                            DistanceText.Text = "["..tostring(ItemDistance).."]"
                                        else
                                            DistanceText.Visible = false
                                        end
                                        if SShubEsp.Info[Esp.Index].ExtraText and Esp.ExtraText ~= "N/A" then
                                            ExtraText.Text = tostring(Extra.ExtraText[1][Extra.ExtraText[2]])
                                            ExtraText.Visible = true
                                        else
                                            ExtraText.Visible = false
                                        end
                                    end
                                else
                                    ItemName.Visible = false
                                    SubText.Visible = false
                                    ExtraText.Visible = false
                                    DistanceText.Visible = false
                                end
                            else
                                ItemName.Visible = false
                                SubText.Visible = false
                                ExtraText.Visible = false
                                DistanceText.Visible = false
                            end
                        else
                            ItemName.Visible = false
                            SubText.Visible = false
                            ExtraText.Visible = false
                            DistanceText.Visible = false
                        end
                    end
                end)
            end
            coroutine.wrap(InfoUpdate)()
        else
            error("Please enter the folder/instance were the items are located")
        end
    else
        error("Invalid Instace: "..Item.Name.."/"..Esp.Name.." - "..Item.ClassName.."\nValid Instances for ESP: "..table.concat(Class, ", "))
    end
    return Esp
end
return SShubEsp
