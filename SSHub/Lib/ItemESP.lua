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
local Class = {"MeshPart","UnionOperation","Part"}

local function ConvertText(Text)
    if Text ~= nil then
        if type(Text) == "table" then
            if #Text == 2 and Text[1] ~= nil and Text[2] ~= nil then
                if typeof(Text[1]) == "Instance" and type(Text[2]) == "string" then
                    if type(Text[1][Text[2]]) == "number" then
                        return tostring(math.ceil(Text[1][Text[2]]))
                    elseif type(Text[1][Text[2]]) == "string" then
                        return tostring(Text[1][Text[2]])
                    end
                end
            elseif #Text == 3 and Text[1] ~= nil and Text[2] ~= nil and Text[3] ~= nil then
                if type(Text[1]) == "string" and typeof(Text[2]) == "Instance" and type(Text[3]) == "string" then
                    if type(Text[2][Text[3]]) == "number" then
                        return Text[1]..tostring(math.ceil(Text[2][Text[3]]))
                    elseif type(Text[2][Text[3]]) == "string" then
                        return Text[1]..tostring(Text[2][Text[3]])
                    end
                end
            elseif #Text == 4 and Text[1] ~= nil and Text[2] ~= nil and Text[3] ~= nil and Text[4] ~= nil then
                if type(Text[1]) == "string" and typeof(Text[2]) == "Instance" and type(Text[3]) == "string" and type(Text[4]) == "string" then
                    if type(Text[2][Text[3]]) == "number" then
                        return Text[1]..tostring(math.ceil(Text[2][Text[3]]))..Text[4]
                    elseif type(Text[2][Text[3]]) == "string" then
                        return Text[1]..tostring(Text[2][Text[3]])..Text[4]
                    end
                end
            end
        elseif type(Text) == "string" then
            return Text
        end
    else
        error("Attempt to index nil in ConvertText")
    end
end

function SShubEsp:NewIndex(Index, Value)
    if Index ~= nil then
        if SShubEsp.Info[Index] == nil then
            SShubEsp.Info[Index] = {
                Enabled = Value or true,
                SubText = false,
                ExtraText = false,
                Highlight = false,
                Distance = false,
                ItemNameColor = Color3.new(255, 255, 255),
                SubTextColor = Color3.new(255, 255, 255),
                ExtraTextColor = Color3.new(255, 255, 255),
                HighlightColor = Color3.new(255, 255, 255),
                Draws = {}
            }
        else
            error("Theres are alredy a toggle called: "..Index.."!")
        end
    end
end

function SShubEsp:RemoveEsp(Index)
    if SShubEsp.Info[Index] ~= nil and SShubEsp.Info[Index].Draws ~= nil then
        for i,v in pairs(SShubEsp.Info[Index].Draws) do
            for i2,v2 in pairs(v) do
                if v2 ~= nil then
                    v2:Remove()
                end
            end
        end
    else
        error("Error Cant find a valid Esp: "..Index)
    end
end

function SShubEsp:NewEsp(Item, Extra)
    local Esp = {
        Folder = Extra.Folder or workspace,
        Index = Extra.Index or "Global",
        Name = Extra.Name or Item.Name,
        SubText = Extra.SubText or "nil",
        ExtraText = Extra.ExtraText or "nil",
        Highlight = Extra.Highlight or false,
        HighlightFolder = Extra.HighlightFolder or Item,
        Color = Extra.Color or Color3.new(255,255,255),
        Transparency = Extra.Transparency or false,
        Font = Extra.Font or 2,
        SubTextToggle = Extra.SubTextToggle or false,
        DistanceText = Extra.Distance or false,
        ExtraTextToggle = Extra.ExtraTextToggle or false,
        RemoveOnToggle = Extra.RemoveOnToggle or false
    }

    if Item ~= nil then
        if table.find(Class, Item.ClassName) then
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
            
            SShubEsp:NewIndex(Esp.Index)
            --Drawing
            local Highlight = Instance.new("Highlight", Esp.HighlightFolder)
            Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            Highlight.Enabled = false
            Highlight.FillColor = Esp.Color
            Highlight.FillTransparency = 0.3
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
            SubText.Text = ConvertText(Esp.SubText)
            
            local ExtraText = Drawing.new("Text")
            ExtraText.Visible = false
            ExtraText.Center = true
            ExtraText.Outline = true
            ExtraText.Font = Esp.Font
            ExtraText.Size = 13
            ExtraText.Color = Esp.Color
            ExtraText.Text = ConvertText(Esp.ExtraText)

            local DistanceText = Drawing.new("Text")
            DistanceText.Visible = false
            DistanceText.Center = true
            DistanceText.Outline = true
            DistanceText.Font = Esp.Font
            DistanceText.Size = 13
            DistanceText.Color = Esp.Color
            DistanceText.Text = "Distance"

            local function InfoUpdate()
                SShubEsp.Info[Esp.Index].Draws[Esp.Name] = {ItemName, SubText, ExtraText, DistanceText, Highlight}
                SShubEsp.Info[Esp.Index].SubTextColor = Esp.Color
                SShubEsp.Info[Esp.Index].ExtraTextColor = Esp.Color
                SShubEsp.Info[Esp.Index].ItemNameColor = Esp.Color
                SShubEsp.Info[Esp.Index].HighlightColor = Esp.Color
                SShubEsp.Info[Esp.Index].DistanceColor = Esp.Color

                local ItemDistance = 0

                local Iu
                local function RemoveEsp(Index)
                    if Iu ~= nil then
                        Iu:Disconnect()
                    end
                    for i,v in pairs(SShubEsp.Info[Esp.Index].Draws[Index]) do
                        v:Remove()
                    end
                end
                Iu = RunService.RenderStepped:Connect(function()
                    if not Esp.Folder:IsAncestorOf(Item) or Transparent(Item) then
                        RemoveEsp(Esp.Name)
                    else
                        if ItemName ~= nil and SubText ~= nil and ExtraText ~= nil and DistanceText ~= nil and Highlight ~= nil then
                            if SShubEsp.Info[Esp.Index] ~= nil then
                                if SShubEsp.Enabled then
                                    if SShubEsp.Info[Esp.Index].Enabled == true then
                                        local Vector, OnScreen = Cam:WorldToViewportPoint(Item.Position)
                                        if OnScreen then
                                            if Plr.Character and Plr.Character:FindFirstChild("HumanoidRootPart") then
                                                ItemDistance = math.ceil((Item.Position - Plr.Character:FindFirstChild("HumanoidRootPart").Position).magnitude)
                                            end
                                            if ItemDistance < SShubEsp.MaxDistance then
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
                                                
                                                ItemName.Text = Esp.Name
                                                ItemName.Visible = true

                                                if ItemName.Color ~= SShubEsp.Info[Esp.Index].ItemNameColor then
                                                    ItemName.Color = SShubEsp.Info[Esp.Index].ItemNameColor
                                                end
                                                if SubText.Color ~= SShubEsp.Info[Esp.Index].SubTextColor then
                                                    SubText.Color = SShubEsp.Info[Esp.Index].SubTextColor
                                                end
                                                if ExtraText.Color ~= SShubEsp.Info[Esp.Index].ExtraTextColor then
                                                    ExtraText.Color = SShubEsp.Info[Esp.Index].ExtraTextColor
                                                end
                                                if DistanceText.Color ~= SShubEsp.Info[Esp.Index].DistanceColor then
                                                    DistanceText.Color = SShubEsp.Info[Esp.Index].DistanceColor
                                                end
                                                if Highlight.FillColor ~= SShubEsp.Info[Esp.Index].HighlightColor then
                                                    Highlight.FillColor = SShubEsp.Info[Esp.Index].HighlightColor
                                                end

                                                if SShubEsp.Info[Esp.Index].Highlight then
                                                    Highlight.Enabled = true
                                                else
                                                    Highlight.Enabled = false
                                                end
                                                if SShubEsp.Info[Esp.Index].SubText and ConvertText(Esp.SubText) ~= nil then
                                                    SubText.Text = ConvertText(Esp.SubText)
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
                                                if SShubEsp.Info[Esp.Index].ExtraText and ConvertText(Esp.ExtraText) ~= nil then
                                                    ExtraText.Text = ConvertText(Esp.ExtraText)
                                                    ExtraText.Visible = true
                                                else
                                                    ExtraText.Visible = false
                                                end
                                                
                                            else
                                                for i,v in pairs(SShubEsp.Info[Esp.Index].Draws[Esp.Name]) do
                                                    v.Visible = false
                                                end
                                            end
                                        else
                                            for i,v in pairs(SShubEsp.Info[Esp.Index].Draws[Esp.Name]) do
                                                v.Visible = false
                                            end
                                        end
                                    else
                                        for i,v in pairs(SShubEsp.Info[Esp.Index].Draws[Esp.Name]) do
                                            v.Visible = false
                                        end
                                        if Esp.RemoveOnToggle then
                                            RemoveEsp(Esp.Name)
                                        end
                                    end
                                else
                                    for i,v in pairs(SShubEsp.Info[Esp.Index].Draws[Esp.Name]) do
                                        v.Visible = false
                                    end
                                    if Esp.RemoveOnToggle then
                                        RemoveEsp(Esp.Name)
                                    end
                                end
                            else
                                RemoveEsp(Esp.Name)
                            end
                        else
                            RemoveEsp(Esp.Name)
                        end
                    end
                end)
            end
            coroutine.wrap(InfoUpdate)()
        else
            error("Invalid instance: "..Item.ClassName)
        end
    else
        error("Attempt to index for a nil instance")
    end

    return Esp
end
return SShubEsp
