-- #region Services
local RunService = game:GetService("RunService")
local Cam = workspace.CurrentCamera;
local Plr = game:GetService("Players").LocalPlayer
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
        if SShubEsp.Info[Toggle] == nil and Toggle ~= nil or Toggle ~= "nil" then
            SShubEsp.Info[Toggle] = {
                Enabled = Value or true,
                SubText = false,
                Distance = false,
                ExtraText = false,
                Highlight = false,
                Color = Color3.new(1, 2.5, 2.5),
                Remove = false
            }
        else
            error("Theres are alredy a toggle called: "..Toggle.."!")
        end
    end
end


function SShubEsp:RemoveEsp(Esp)
    if SShubEsp.Info[Esp] ~= nil then
        SShubEsp.Info[Esp].Remove = true
        task.wait(2)
        SShubEsp.Info[Esp].Remove = false
    else
        error("Error Cant find a valid Esp: ".. tostring(Esp))
    end
end

function SShubEsp:SetValue(Esp, ValueSet, Value)
    if SShubEsp.Info[Esp] ~= nil then
        local Type = type(SShubEsp.Info[Esp][ValueSet])
        if type(Value) == Type then
            SShubEsp.Info[Esp][ValueSet] = Value
        else
            error("Invalid index SetValue: ".. ValueSet)
        end
    else
        error("Attempt to call a nil value in SetValue"..Esp)
    end
end

function SShubEsp:GetValue(Index, Value)
    if SShubEsp.Info[Index] ~= nil then
        if SShubEsp.Info[Index][Value] ~= nil then
            return SShubEsp.Info[Index][Value]
        else
            error("Attempt to index nil value in GetValue"..Value)
        end
    else
        error("Attempt to index nil in GetValue"..Index)
    end
end

function SShubEsp:NewEsp(Item, Extra)
    local Esp = {
        Transparency = Extra.Transparency or false,
        Highlight = Extra.Highlight or false,
        HighlightFolder = Extra.HighlightFolder or Item,
        Color = Extra.Color or Color3.new(1, 2.5, 2.5),
        SubText = "N/A",
        ExtraText = "N/A",
        Folder = Extra.Folder or workspace,
        Name = tostring(Extra.Name) or Item.Name,
        Font = Extra.Font or 2,
        Index = Extra.Index or "Global",
        SubTextToggle = Extra.SubTextToggle or false,
        DistanceText = Extra.Distance or false,
        ExtraTextToggle = Extra.ExtraTextToggle or false,
        RemoveOnToggle = Extra.RemoveOnToggle or false
    }

    if Item ~= nil then
        if table.find(Class, Item.ClassName) then
            --Functions
            local function Transparent(v)
                if Esp.Transparency then
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
            if SShubEsp.Info[Esp.Index] == nil and Esp.Index ~= nil or Esp.Index ~= "nil" then
                SShubEsp.Info[Esp.Index] = {
                    Enabled = true,
                    Color = Esp.Color or Color3.new(1, 2.5, 2.5),
                    SubText = Esp.SubTextToggle,
                    Distance = Esp.DistanceText,
                    ExtraText = Esp.ExtraTextToggle,
                    Highlight = Esp.Highlight,
                    Remove = false
                }
            elseif SShubEsp.Info[Esp.Index] ~= nil and Esp.Index ~= nil or Esp.Index ~= "nil" then
                SShubEsp.Info[Esp.Index].SubText = Esp.SubTextToggle
                SShubEsp.Info[Esp.Index].ExtraText = Esp.ExtraTextToggle
                SShubEsp.Info[Esp.Index].Distance = Esp.DistanceText
                SShubEsp.Info[Esp.Index].Highlight = Esp.Highlight
                SShubEsp.Info[Esp.Index].Color = Esp.Color
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
            local Highlight = Instance.new("Highlight", Esp.HighlightFolder)
            Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            Highlight.Enabled = false
            Highlight.FillColor = Esp.Color
            Highlight.FillTransparency = 0.5
            Highlight.Name = "Highlight"
            Highlight.OutlineColor = Color3.new(255,255,255)
            Highlight.OutlineTransparency = 0

            local ItemName = Drawing.new("Text")
            ItemName.Visible = false
            ItemName.Center = true
            ItemName.Outline = true
            ItemName.Font = Esp.Font
            ItemName.Size = 13
            ItemName.Color = Esp.Color
            ItemName.Text = Esp.Name

            local SubText = Drawing.new("Text")
            SubText.Visible = false
            SubText.Center = true
            SubText.Outline = true
            SubText.Font = Esp.Font
            SubText.Size = 13
            SubText.Color = Esp.Color
            SubText.Text = Esp.SubText
            
            local ExtraText = Drawing.new("Text")
            ExtraText.Visible = false
            ExtraText.Center = true
            ExtraText.Outline = true
            ExtraText.Font = Esp.Font
            ExtraText.Size = 13
            ExtraText.Color = Esp.Color
            ExtraText.Text = Esp.ExtraText

            local DistanceText = Drawing.new("Text")
            DistanceText.Visible = false
            DistanceText.Center = true
            DistanceText.Outline = true
            DistanceText.Font = Esp.Font
            DistanceText.Size = 13
            DistanceText.Color = Esp.Color
            DistanceText.Text = "Distance"

            local ItemDistance = 0

            local function InfoUpdate()
                local Iu
                Iu = RunService.RenderStepped:Connect(function()
                    if not Esp.Folder:IsAncestorOf(Item) or Transparent(Item) or SShubEsp.Info[Esp.Index].Remove then
                        Iu:Disconnect()
                        ItemName:Remove() 
                        ExtraText:Remove()
                        SubText:Remove()
                        DistanceText:Remove()
                        Highlight:Remove()
                    else
                        if SShubEsp.Info[Esp.Index] ~= nil then
                            Esp.Color = SShubEsp.Info[Esp.Index].Color
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
                                ItemName.Position = Vector2.new(Vector.X, Vector.Y + 20)
                                if SShubEsp.Info[Esp.Index].SubText then
                                    SubText.Position = Vector2.new(Vector.X, Vector.Y + 30)
                                end
                                if SShubEsp.Info[Esp.Index].ExtraText then
                                    if not SShubEsp.Info[Esp.Index].SubText then
                                        ExtraText.Position = Vector2.new(Vector.X, Vector.Y + 30)
                                    else
                                        ExtraText.Position = Vector2.new(Vector.X, Vector.Y + 40)
                                    end
                                end
                                if SShubEsp.Info[Esp.Index].Distance then
                                    if not SShubEsp.Info[Esp.Index].SubText and not SShubEsp.Info[Esp.Index].ExtraText then
                                        DistanceText.Position = Vector2.new(Vector.X, Vector.Y + 30)
                                    elseif SShubEsp.Info[Esp.Index].SubText and SShubEsp.Info[Esp.Index].ExtraText then
                                        DistanceText.Position = Vector2.new(Vector.X, Vector.Y + 50)
                                    elseif SShubEsp.Info[Esp.Index].SubText or SShubEsp.Info[Esp.Index].ExtraText then
                                        DistanceText.Position = Vector2.new(Vector.X, Vector.Y + 40)
                                    end
                                end
                                if SShubEsp.Enabled then
                                    if SShubEsp.Info[Esp.Index].Enabled == true then
                                        if Plr.Character and Plr.Character:FindFirstChild("HumanoidRootPart") then
                                            ItemDistance = math.ceil((Item.Position - Plr.Character:FindFirstChild("HumanoidRootPart").Position).magnitude)
                                        end
                                        if ItemDistance < SShubEsp.MaxDistance then
                                            ItemName.Text = Esp.Name
                                            ItemName.Visible = true

                                            if ItemName.Color ~= Esp.Color then
                                                ExtraText.Color = Esp.Color
                                                DistanceText.Color = Esp.Color
                                                SubText.Color = Esp.Color
                                                Highlight.FillColor = Esp.Color
                                                ItemName.Color = Esp.Color
                                            end
                                            if SShubEsp.Info[Esp.Index].Highlight then
                                                Highlight.Enabled = true
                                            else
                                                Highlight.Enabled = false
                                            end
                                            if SShubEsp.Info[Esp.Index].SubText and Esp.SubText ~= "N/A" then
                                                SubText.Text = Esp.SubText
                                                SubText.Visible = true
                                            else
                                                SubText.Visible = false
                                            end
                                            if SShubEsp.Info[Esp.Index].Distance then
                                                DistanceText.Visible = true
                                                DistanceText.Text = "["..tostring(ItemDistance).."m]"
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
                                            Highlight.Enabled = false
                                        end
                                    else
                                        ItemName.Visible = false
                                        SubText.Visible = false
                                        ExtraText.Visible = false
                                        DistanceText.Visible = false
                                        Highlight.Enabled = false
                                        if Esp.RemoveOnToggle then
                                            Iu:Disconnect()
                                            ItemName:Remove()
                                            ExtraText:Remove()
                                            SubText:Remove()
                                            Highlight:Remove()
                                            DistanceText:Remove()
                                        end
                                    end
                                else
                                    ItemName.Visible = false
                                    SubText.Visible = false
                                    ExtraText.Visible = false
                                    Highlight.Enabled = false
                                    DistanceText.Visible = false
                                    if Esp.RemoveOnToggle then
                                        Iu:Disconnect()
                                        ItemName:Remove()
                                        ExtraText:Remove()
                                        SubText:Remove()
                                        Highlight:Remove()
                                        DistanceText:Remove()
                                    end
                                end
                            else
                                ItemName.Visible = false
                                SubText.Visible = false
                                ExtraText.Visible = false
                                Highlight.Enabled = false
                                DistanceText.Visible = false
                            end
                        else
                            ItemName.Visible = false
                            SubText.Visible = false
                            ExtraText.Visible = false
                            Highlight.Enabled = false
                            DistanceText.Visible = false
                            Iu:Disconnect()
                            ItemName:Remove()
                            ExtraText:Remove()
                            SubText:Remove()
                            Highlight:Remove()
                            DistanceText:Remove()
                        end
                    end
                end)
            end
            coroutine.wrap(InfoUpdate)()
        else
            error("Invalid Instace: "..Item.Name.."/"..Esp.Name.." - "..Item.ClassName.."\nValid Instances for ESP: "..table.concat(Class, ", "))
        end
    else
        error("nil Instance")
    end
    return Esp
end
return SShubEsp
