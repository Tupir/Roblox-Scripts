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
                SubText = false,
                Distance = false,
                ExtraText = false,
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
        Color = Extra.Color or Color3.new(1, 2.5, 2.5),
        SubText = "N/A",
        ExtraText = "N/A",
        Folder = Extra.Folder or workspace,
        Name = tostring(Extra.Name)or Item.Name,
        Font = Extra.Font or 2,
        Index = tostring(Extra.Index) or "Global",
        SubTextToggle = Extra.SubTextToggle or false,
        DistanceText = Extra.Distance or false,
        ExtraTextToggle = Extra.ExtraTextToggle or false,
        RemoveOnToggle = Extra.RemoveOnToggle or false
    }
    local RemoveBoolean = false

    function Esp:SetValue(ValueSet, Value)
        if Extra[ValueSet] ~= nil then
            local Type = type(Extra[ValueSet])
            if type(Value) == Type then
                Extra[ValueSet] = Value
            end
        else
            error("Invalid index SetValue: "..ValueSet)
        end
    end

    function Esp:GetValue(Value)
        if Esp[Value] ~= nil then
            return Esp[Value]
        else
            error("Invalid index GetValue: "..Value)
        end
    end

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
                    SubText = Esp.SubTextToggle,
                    Distance = Esp.DistanceText,
                    ExtraText = Esp.ExtraTextToggle,
                    Remove = false
                }
            elseif SShubEsp.Info[Esp.Index] ~= nil then
                SShubEsp.Info[Esp.Index].SubText = Esp.SubTextToggle
                SShubEsp.Info[Esp.Index].ExtraText = Esp.ExtraTextToggle
                SShubEsp.Info[Esp.Index].Distance = Esp.DistanceText
            end

            if Extra.SubText ~= nil then
                if type(Extra.SubText) == "table" and #Extra.SubText == 2 and Extra.SubText[1] ~= nil and Extra.SubText[2] ~= nil then
                    Esp.SubText = tostring(Extra.SubText[1][Extra.SubText[2]])
                elseif type(Extra.SubText) == "table" and #Extra.SubText == 3 and Extra.SubText[1] ~= nil and Extra.SubText[2] ~= nil and Extra.SubText[3] ~= nil then
                    Esp.SubText = Extra.SubText[1]..tostring(Extra.SubText[2][Extra.SubText[3]])
                elseif type(Extra.SubText) == "string" then
                    Esp.SubText = Extra.SubText
                else
                    error("Missing or Invalid value: Subtext")
                end
            end
            if Extra.ExtraText ~= nil then
                if type(Extra.ExtraText) == "table" and #Extra.ExtraText == 2 and Extra.ExtraText[1] ~= nil and Extra.ExtraText[2] ~= nil then
                    Esp.ExtraText = tostring(Extra.ExtraText[1][Extra.ExtraText[2]])
                elseif type(Extra.ExtraText) == "table" and #Extra.ExtraText == 3 and Extra.ExtraText[1] ~= nil and Extra.ExtraText[2] ~= nil and Extra.ExtraText[3] ~= nil then
                    Esp.ExtraText = Extra.ExtraText[1]..tostring(Extra.ExtraText[2][Extra.ExtraText[3]])    
                elseif type(Extra.ExtraText) == "string" then
                    Esp.ExtraText = Extra.ExtraText
                else
                    error("Missing or Invalid value: ExtraText")
                end
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
            SubText.Text = Esp.SubText
            
            local ExtraText = Drawing.new("Text")
            ExtraText.Visible = false
            ExtraText.Center = true
            ExtraText.Outline = true
            ExtraText.Font = Esp.Font
            ExtraText.Size = 13
            ExtraText.Color = Color3.new(1, 2.5, 2.5)
            ExtraText.Text = Esp.ExtraText

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
                        if Extra.SubText ~= nil then
                            if type(Extra.SubText) == "table" and #Extra.SubText == 2 and Extra.SubText[1] ~= nil and Extra.SubText[2] ~= nil then
                                Esp.SubText = tostring(Extra.SubText[1][Extra.SubText[2]])
                            elseif type(Extra.SubText) == "table" and #Extra.SubText == 3 and Extra.SubText[1] ~= nil and Extra.SubText[2] ~= nil and Extra.SubText[3] ~= nil then
                                Esp.SubText = Extra.SubText[1]..tostring(Extra.SubText[2][Extra.SubText[3]])
                            elseif type(Extra.SubText) == "string" then
                                Esp.SubText = Extra.SubText
                            end
                        end
                        if Extra.ExtraText ~= nil then
                            if type(Extra.ExtraText) == "table" and #Extra.ExtraText == 2 and Extra.ExtraText[1] ~= nil and Extra.ExtraText[2] ~= nil then
                                Esp.ExtraText = tostring(Extra.ExtraText[1][Extra.ExtraText[2]])
                            elseif type(Extra.ExtraText) == "table" and #Extra.ExtraText == 3 and Extra.ExtraText[1] ~= nil and Extra.ExtraText[2] ~= nil and Extra.ExtraText[3] ~= nil then
                                Esp.ExtraText = Extra.ExtraText[1]..tostring(Extra.ExtraText[2][Extra.ExtraText[3]])
                            elseif type(Extra.ExtraText) == "string" then
                                Esp.ExtraText = Extra.ExtraText
                            end
                        end

                        local Vector, OnScreen = Cam:WorldToViewportPoint(Item.Position)
                        if OnScreen then
                            ItemName.Position = Vector2.new(Vector.X, Vector.Y - 40)
                            if SShubEsp.Info[Esp.Index].SubText then
                                SubText.Position = Vector2.new(Vector.X, Vector.Y - 30)
                            end
                            if SShubEsp.Info[Esp.Index].ExtraText then
                                if not SShubEsp.Info[Esp.Index].SubText then
                                    ExtraText.Position = Vector2.new(Vector.X, Vector.Y - 30)
                                else
                                    ExtraText.Position = Vector2.new(Vector.X, Vector.Y - 20)
                                end
                            end
                            if SShubEsp.Info[Esp.Index].Distance then
                                if not SShubEsp.Info[Esp.Index].SubText and not SShubEsp.Info[Esp.Index].ExtraText then
                                    DistanceText.Position = Vector2.new(Vector.X, Vector.Y - 30)
                                elseif not SShubEsp.Info[Esp.Index].SubText and SShubEsp.Info[Esp.Index].ExtraText then
                                    DistanceText.Position = Vector2.new(Vector.X, Vector.Y - 20)
                                elseif SShubEsp.Info[Esp.Index].SubText and not SShubEsp.Info[Esp.Index].ExtraText then
                                    DistanceText.Position = Vector2.new(Vector.X, Vector.Y - 20)
                                elseif SShubEsp.Info[Esp.Index].SubText and SShubEsp.Info[Esp.Index].ExtraText then
                                    DistanceText.Position = Vector2.new(Vector.X, Vector.Y - 10)
                                end
                            end

                            local ItemDistance = math.ceil((Item.Position - game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).magnitude)
                            if SShubEsp.Enabled then
                                if ItemDistance < SShubEsp.MaxDistance then
                                    if Esp.Index ~= "Global" then
                                        if SShubEsp.Info[Esp.Index].Enabled == true then
                                            ItemName.Text = Esp.Name
                                            ItemName.Visible = true
                                            if ItemName.Color ~= Esp.Color then
                                                ExtraText.Color = Esp.Color
                                                DistanceText.Color = Esp.Color
                                                SubText.Color = Esp.Color
                                                ItemName.Color = Esp.Color
                                            end
                                            if SShubEsp.Info[Esp.Index].SubText and Esp.SubText ~= "N/A" then
                                                SubText.Text = Esp.SubText
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
                                                ExtraText.Text = Esp.ExtraText
                                                ExtraText.Visible = true
                                            else
                                                ExtraText.Visible = false
                                            end
                                        else
                                            ItemName.Visible = false
                                            SubText.Visible = false
                                            ExtraText.Visible = false
                                            DistanceText.Visible = false
                                            if Esp.RemoveOnToggle then
                                                Iu:Disconnect()
                                                ItemName:Remove()
                                                ExtraText:Remove()
                                                SubText:Remove()
                                                DistanceText:Remove()
                                            end
                                        end
                                    else
                                        ItemName.Text = Esp.Name
                                        ItemName.Visible = true
                                        if SShubEsp.Info[Esp.Index].SubText and Esp.SubText ~= "N/A" then
                                            SubText.Text = Esp.SubText
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
                                            ExtraText.Text = Esp.ExtraText
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
                                if Esp.RemoveOnToggle then
                                    Iu:Disconnect()
                                    ItemName:Remove()
                                    ExtraText:Remove()
                                    SubText:Remove()
                                    DistanceText:Remove()
                                end
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
