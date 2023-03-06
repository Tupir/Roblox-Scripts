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
        if SShubEsp.Info[Toggle] == nil then
            SShubEsp.Info[Toggle] = {
                Texts = {},
                Enabled = Value or true,
                Distance = false,
                Highlight = false,
                Color = Color3.new(1, 2.5, 2.5),
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
        SShubEsp.Info[Esp] = nil
    else
        error("Error Cant find a valid Toggle: ".. tostring(Esp))
    end

    return Remove
end

function SShubEsp:RemoveEsp(Esp)
local Remove = {}

if SShubEsp.Info[Esp] ~= nil then
    SShubEsp.Info[Esp].Remove = true
    SShubEsp.Info[Esp].Remove = false
else
    error("Error Cant find a valid Esp: ".. tostring(Esp))
end

return Remove
end

function SShubEsp:NewEsp(Item, Extra)
    local Esp = {
        Transparency = Extra.Transparency or false,
        Highlight = Extra.Highlight or false,
        HighlightFolder = Extra.HighlightFolder or Item,
        Color = Extra.Color or Color3.new(1, 2.5, 2.5),
        Folder = Extra.Folder or workspace,
        Name = tostring(Extra.Name)or Item.Name,
        Font = Extra.Font or 2,
        Index = tostring(Extra.Index) or "Global",
        DistanceText = Extra.Distance or false, 
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


    function Esp:AddText(String, Index, Color)
        local Text = Drawing.new("Text")
        Text.Visible = false
        Text.Center = true
        Text.Outline = true
        Text.Font = Esp.Font
        Text.Size = 13
        Text.Color = Color
        Text.Text = String
        SShubEsp.Info[Esp.Index].Texts[Index] = {
            Enabled = false,
            Color = Color,
            String = String,
            Text = Text
        }
    end

    function Esp:Remove()
        RemoveBoolean = true
    end

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
            if SShubEsp.Info[Esp.Index] == nil then
                SShubEsp.Info[Esp.Index] = {
                    Texts = {},
                    Enabled = true,
                    Color = Color3.new(1, 2.5, 2.5),
                    Distance = Esp.DistanceText,
                    Highlight = Esp.Highlight,
                    Remove = false
                }
            elseif SShubEsp.Info[Esp.Index] ~= nil then
                SShubEsp.Info[Esp.Index].Distance = Esp.DistanceText
                SShubEsp.Info[Esp.Index].Highlight = Esp.Highlight
                SShubEsp.Info[Esp.Index].Color = Esp.Color
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
                    if not Esp.Folder:IsAncestorOf(Item) or Transparent(Item) or RemoveBoolean or SShubEsp.Info[Esp.Index].Remove then
                        Iu:Disconnect()
                        ItemName:Remove()
                        Highlight:Remove()
                        DistanceText:Remove()
                        for Index, Table in pairs(SShubEsp.Info[Esp.Index].Texts) do
                            Table.Text:Remove()
                            SShubEsp.Info[Esp.Index].Texts[Index] = nil
                        end
                        if SShubEsp.Info[Esp.Index].Remove then
                            SShubEsp.Info[Esp.Index].Remove = false
                        end
                    else

                        local Vector, OnScreen = Cam:WorldToViewportPoint(Item.Position)

                        if OnScreen then
                            if SShubEsp.Enabled then
                                if Plr.Character and Plr.Character:FindFirstChild("HumanoidRootPart") then
                                    ItemDistance = math.ceil((Item.Position - Plr.Character:FindFirstChild("HumanoidRootPart").Position).magnitude)
                                end
                                if ItemDistance < SShubEsp.MaxDistance then
                                    if SShubEsp.Info[Esp.Index].Enabled then
                                        ItemName.Position = Vector2.new(Vector.X, Vector.Y + 10)
                                        local TextCounts = 1
                                        for Index, v in pairs(SShubEsp.Info[Esp.Index].Texts) do
                                            if type(v) == "table" then
                                                if v.Text.Enabled then
                                                    TextCounts=TextCounts+1
                                                    v.Text.Position = Vector2.new(Vector.X, Vector.Y + (tonumber(TextCounts..0)))
                                                end
                                            end
                                        end
                                        if SShubEsp.Info[Esp.Index].Distance then
                                            DistanceText.Position = Vector2.new(Vector.X, Vector.Y + tonumber((TextCounts+1)..0))
                                        end

                                        ItemName.Text = Esp.Name
                                        ItemName.Visible = true

                                        for Index, v in pairs(SShubEsp.Info[Esp.Index].Texts) do
                                            if type(v) == "table" then
                                                if v.Text.Enabled then
                                                    v.Text.Text = v.String
                                                    if v.Text.Color ~= v.Color then
                                                        v.Text.Color = v.Color
                                                    end
                                                    v.Text.Visible = true
                                                else
                                                    v.Text.Visible = false
                                                end
                                            end
                                        end
                                        if ItemName.Color ~= Esp.Color then
                                            Esp.Color = SShubEsp.Info[Esp.Index].Color
                                            DistanceText.Color = Esp.Color
                                            Highlight.FillColor = Esp.Color
                                            ItemName.Color = Esp.Color
                                        end
                                        if SShubEsp.Info[Esp.Index].Highlight then
                                            Highlight.Enabled = true
                                        else
                                            Highlight.Enabled = false
                                        end
                                        if SShubEsp.Info[Esp.Index].Distance then
                                            DistanceText.Visible = true
                                            DistanceText.Text = "["..tostring(ItemDistance).."m]"
                                        else
                                            DistanceText.Visible = false
                                        end
                                    else
                                        ItemName.Visible = false
                                        DistanceText.Visible = false
                                        Highlight.Enabled = false
                                        for Index, v in pairs(SShubEsp.Info[Esp.Index].Texts) do
                                            if type(v) == "table" then
                                                v.Text.Visible = false
                                            end
                                        end
                                        if Esp.RemoveOnToggle then
                                            Iu:Disconnect()
                                            ItemName:Remove()
                                            for Index, Table in pairs(SShubEsp.Info[Esp.Index].Texts) do
                                                Table.Text:Remove()
                                                SShubEsp.Info[Esp.Index].Texts[Index] = nil
                                            end
                                            Highlight:Remove()
                                            DistanceText:Remove()
                                        end
                                    end
                                else
                                    ItemName.Visible = false
                                    Highlight.Enabled = false
                                    DistanceText.Visible = false
                                    for Index, v in pairs(SShubEsp.Info[Esp.Index].Texts) do
                                        if type(v) == "table" then
                                            v.Text.Visible = false
                                        end
                                    end
                                end
                            else
                                ItemName.Visible = false
                                DistanceText.Visible = false
                                Highlight.Enabled = false
                                for Index, v in pairs(SShubEsp.Info[Esp.Index].Texts) do
                                    if type(v) == "table" then
                                        v.Text.Visible = false
                                    end
                                end
                                if Esp.RemoveOnToggle then
                                    Iu:Disconnect()
                                    ItemName:Remove()
                                    for Index, Table in pairs(SShubEsp.Info[Esp.Index].Texts) do
                                        Table.Text:Remove()
                                        SShubEsp.Info[Esp.Index].Texts[Index] = nil
                                    end
                                    Highlight:Remove()
                                    DistanceText:Remove()
                                end
                            end
                        else
                            ItemName.Visible = false
                            Highlight.Enabled = false
                            DistanceText.Visible = false
                            for Index, v in pairs(SShubEsp.Info[Esp.Index].Texts) do
                                if type(v) == "table" then
                                    v.Text.Visible = false
                                end
                            end
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
