-- #region Services
local RunService = game:GetService("RunService")
local Cam = workspace.CurrentCamera;
local Player = game:GetService("Players").LocalPlayer
--#endregion
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
                SubText = nil,
                Distance = nil,
                Remove = false
            }
        else
            error("Theres are alredy a toggle called: "..Toggle.."!")
        end
    end
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
        Rarity = Extra.Rarity or "N/A",
        Color = Extra.Color or Color3.new(1, 2.5, 2.5),
        Folder = Extra.Folder or workspace,
        Name = Extra.Name or tostring(Item),
        Font = Extra.Font or 2,
        Index = Extra.Index or nil,
        SubText = Extra.SubText or false,
        DistanceText = Extra.Distance or false,
    }
    local RemoveBoolean = false
    function Esp:Remove()
        RemoveBoolean = true
    end

    if table.find(Class, Item.ClassName) then
        if Esp.Folder ~= nil then
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

            if Esp.Index ~= nil then
                if SShubEsp.Info[Esp.Index] == nil then
                    SShubEsp.Info[Esp.Index] = {
                        Enabled = true,
                        SubText = nil,
                        Distance = nil,
                        Remove = false
                    }
                    if Extra.SubText ~= nil then
                        SShubEsp.Info[Esp.Index].SubText = Extra.SubText
                    end
                    if Extra.Distance ~= nil then
                        SShubEsp.Info[Esp.Index].Distance = Extra.Distance
                    end
                elseif SShubEsp.Info[Esp.Index] ~= nil then
                    if Extra.SubText ~= nil then
                        SShubEsp.Info[Esp.Index].SubText = Extra.SubText
                    end
                    if Extra.Distance ~= nil then
                        SShubEsp.Info[Esp.Index].Distance = Extra.Distance
                    end
                end
            end

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
            SubText.Text = Esp.Rarity
            
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
                        SubText:Remove()
                        DistanceText:Remove()
                    else
                        print(Esp.SubText)
                        if SShubEsp.Info[Esp.Index].SubText ~= nil and SShubEsp.Info[Esp.Index].SubText == true then
                            Esp.SubText = true
                        elseif SShubEsp.Info[Esp.Index].SubText ~= nil and SShubEsp.Info[Esp.Index].SubText == false then
                            Esp.SubText = false
                        end
                        if SShubEsp.Info[Esp.Index].Distance ~= nil and SShubEsp.Info[Esp.Index].Distance == true then
                            Esp.DistanceText = true
                        elseif SShubEsp.Info[Esp.Index].Distance ~= nil and SShubEsp.Info[Esp.Index].Distance == false then
                            Esp.DistanceText = false
                        end

                        local Vector, OnScreen = Cam:WorldToViewportPoint(Item.Position)
                        if OnScreen then

                            ItemName.Position = Vector2.new(Vector.X, Vector.Y - 40)
                            if Esp.SubText then
                                SubText.Position = Vector2.new(Vector.X, Vector.Y - 30)
                            end
                            if Esp.DistanceText then
                                DistanceText.Position = Vector2.new(Vector.X, Vector.Y - 20)
                            end

                            local ItemDistance = math.ceil((Item.Position - game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).magnitude)
                            if SShubEsp.Enabled then
                                if ItemDistance < SShubEsp.MaxDistance then
                                    if Esp.Rarity ~= "N/A" and Esp.SubText then
                                        SubText.Text = Esp.Rarity
                                        SubText.Color = Esp.Color
                                        ItemName.Color = Esp.Color
                                    end
                                    if Esp.Index ~= nil then
                                        if SShubEsp.Info[Esp.Index].Enabled == true then
                                            ItemName.Visible = true
                                            if Esp.SubText then
                                                SubText.Visible = true
                                            end
                                            if Esp.Distance then
                                                DistanceText.Visible = true
                                            end
                                        else
                                            ItemName.Visible = false
                                            SubText.Visible = false
                                            DistanceText.Visible = false
                                        end
                                    else
                                        ItemName.Visible = true
                                        if Esp.SubText then
                                            SubText.Visible = true
                                        end
                                        if Esp.Distance then
                                            DistanceText.Visible = true
                                        end
                                    end
                                    DistanceText.Text = "["..tostring(ItemDistance).."]"
                                else
                                    ItemName.Visible = false
                                    SubText.Visible = false
                                    DistanceText.Visible = false
                                end
                            else
                                ItemName.Visible = false
                                SubText.Visible = false
                                DistanceText.Visible = false
                            end
                        else
                            ItemName.Visible = false
                            SubText.Visible = false
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
