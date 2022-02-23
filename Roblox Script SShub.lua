--SoulShatters--

if game.PlaceId == 3198259055 then
local library = loadstring(game:HttpGet("http://void-scripts.com/UI/VenyxUi2.lua"))()
local SShub = library.new("SShub SoulShatters", 5013109572)
local Things = SShub:addPage("Things", 5012544693)
local Thingsz = Things:addSection("Scripts")

Thingsz:addButton(
    "CMD-X Fe Commands",
    function()
        loadstring(
            game:HttpGet("https://raw.githubusercontent.com/CMD-X/CMD-X/master/Source", true)
        )()
    end
)
Thingsz:addToggle(
    "GodMode",
    false,
    function()
        repeat
            wait(1)
            loadstring(
                game:HttpGet(
                    "https://raw.githubusercontent.com/miguel831/Topi/main/SoulShattersScripts/Carpet/GodMode",
                    true
                )
            )()
        until false
    end
)
Thingsz:addButton(
    "Hard Reset",
    function()
        local A_1 = {
            [1] = getrenv()._G.Pass,
            [2] = "Reset"
        }
        local Event = game:GetService("ReplicatedStorage").Remotes.Functions
        Event:InvokeServer(A_1)
        wait(1)
        local args = {
            [1] = {
                [1] = getrenv()._G.Pass,
                [2] = "Damage",
                [3] = math.huge,
                [4] = game.Players.LocalPlayer.Character
            }
        }

        game:GetService("ReplicatedStorage").Remotes.Events:FireServer(unpack(args))
    end
)


local page = SShub:addPage("Ct Characters", 5012544693)
local CC = page:addSection("Execute on menu")


CC:addButton(
    "FriskLevel20",
    function()
        loadstring(
            game:HttpGet("https://raw.githubusercontent.com/miguel831/Topi/main/SoulShattersScripts/Frisk%20Level%2020", true)
        )()
    end
)
CC:addButton(
    "Unknow by void",
    function()
        loadstring(
            game:HttpGet("https://raw.githubusercontent.com/miguel831/Topi/main/SoulShattersScripts/Unknow%20by%20void", true)
        )()
    end
)
CC:addButton(
    "Shadow Dio",
    function()
        loadstring(
            game:HttpGet("https://raw.githubusercontent.com/miguel831/Topi/main/SoulShattersScripts/Shadow%20Dio", true)
        )()
    end
)
CC:addButton(
    "DustRust",
    function()
        loadstring(
            game:HttpGet("https://raw.githubusercontent.com/miguel831/Topi/main/SoulShattersScripts/DustRust", true)
        )()
    end
)
CC:addButton(
    "Kris",
    function()
        loadstring(
            game:HttpGet("https://raw.githubusercontent.com/miguel831/Topi/main/SoulShattersScripts/Kris", true)
        )()
    end
)
CC:addButton(
    "Ink Sans",
    function()
        loadstring(
            game:HttpGet("https://raw.githubusercontent.com/miguel831/Topi/main/SoulShattersScripts/ink%20sans", true)
        )()
    end
)
CC:addButton(
    "Omori",
    function()
        loadstring(
            game:HttpGet("https://raw.githubusercontent.com/miguel831/Topi/main/SoulShattersScripts/omori", true)
        )()
    end
)
CC:addButton(
    "W.B Gaster",
    function()
        loadstring(
            game:HttpGet("https://raw.githubusercontent.com/miguel831/Topi/main/SoulShattersScripts/%20Ganster", true)
        )()
    end
)
CC:addButton(
    "Faceless",
    function()
        loadstring(
            game:HttpGet("https://raw.githubusercontent.com/miguel831/Topi/main/SoulShattersScripts/Faceless", true)
        )()
    end
)
CC:addButton(
    "GTFRISK Modded",
    function()
        loadstring(
            game:HttpGet("https://raw.githubusercontent.com/miguel831/Topi/main/SoulShattersScripts/GTFRISK", true)
        )()
    end
)
CC:addButton(
    "Star Glitcher",
    function()
        loadstring(
            game:HttpGet("https://raw.githubusercontent.com/miguel831/Topi/main/SoulShattersScripts/Star%20Glitcher", true)
        )()
    end
)
CC:addButton(
    "Mayhem",
    function()
        loadstring(
            game:HttpGet("https://raw.githubusercontent.com/miguel831/Topi/main/SoulShattersScripts/Mayhem%20Fire%20God", true)
        )()
    end
)

local op = page:addSection("Op Character (execute on menu)")


op:addButton(
    "Chara unnamed",
    function()
        loadstring(
            game:HttpGet("https://raw.githubusercontent.com/miguel831/Topi/main/SoulShattersScripts/Chara%20modded", true)
        )()
    end
)
op:addButton(
    "Unnamed Character by h01y",
    function()
        loadstring(
            game:HttpGet("https://raw.githubusercontent.com/miguel831/Topi/main/SoulShattersScripts/%20unnamed", true)
        )()
    end
)
op:addButton(
    "P.A.I.N",
    function()
        loadstring(
            game:HttpGet("https://raw.githubusercontent.com/miguel831/Topi/main/SoulShattersScripts/P.A.I.N", true)
        )()
    end
)
local paidCrPage = SShub:addPage("Paid Characters", 5012544693)
local paidCr = paidCrPage:addSection("Execute on menu")


paidCr:addButton(
    "Fatal error sans",
    function()
        loadstring(
            game:HttpGet("https://raw.githubusercontent.com/miguel831/Topi/main/SoulShattersScripts/Fatal", true)
        )()
    end
)
paidCr:addButton(
    "LastBreath",
    function()
        loadstring(
            game:HttpGet("https://raw.githubusercontent.com/miguel831/Topi/main/SoulShattersScripts/LastBreath", true)
        )()
    end
)

local paidCrs = paidCrPage:addSection("Idk if this is paid")


paidCrs:addButton(
    "DemiGod",
    function()
        loadstring(
            game:HttpGet("https://raw.githubusercontent.com/miguel831/Topi/main/SoulShattersScripts/Demi%20god", true)
        )()
    end
)

local themes = {
    Background = Color3.fromRGB(24, 24, 24),
    Glow = Color3.fromRGB(0, 0, 0),
    Accent = Color3.fromRGB(10, 10, 10),
    LightContrast = Color3.fromRGB(20, 20, 20),
    DarkContrast = Color3.fromRGB(14, 14, 14),  
    TextColor = Color3.fromRGB(255, 255, 255)
    }
    
    local theme = SShub:addPage("Ui", 5012544693)
    local colors = theme:addSection("Colors")
    local UiToggle = theme:addSection("Ui Toggle")
    
    UiToggle:addKeybind("Toggle Keybind", Enum.KeyCode.RightControl, function()
        SShub:toggle()
        end, function()
    end)
    
    
    for theme, color in pairs(themes) do 
    colors:addColorPicker(theme, color, function(color3)
    SShub:setTheme(theme, color3)
           end
        )
    end
    
    local Credits = SShub:addPage("Credits", 5012544693)
    local Credit = Credits:addSection("Credits: Tupi#2739")
    
    SShub:SelectPage(SShub.pages[1], true)
end

--CRITICAL STRIKE--

if game.PlaceId == 111311599 then
local library = loadstring(game:HttpGet("http://void-scripts.com/UI/VenyxUi2.lua"))()
local SShub = library.new("Critical Strike", 5013109572)
local Cssect1 = SShub:addPage("Main Scripts", 5012544693)
local Cs = Cssect1:addSection("Critical Strike Scripts")
local Cssect2 = SShub:addPage("Other Scripts", 5012544693)
local Cs1 = Cssect2:addSection("Scripts")

Cs:addButton(
    "Give GP Classes",
    function()
        loadstring(
            game:HttpGet("https://raw.githubusercontent.com/miguel831/Topi/main/CriticalStrike/Give%20GP%20Classes", true)
        )()
    end
)
Cs:addButton(
    "Give Admin Cmds",
    function()
        loadstring(
            game:HttpGet("https://raw.githubusercontent.com/miguel831/Topi/main/CriticalStrike/Give%20Admin%20Cmds", true)
        )()
    end
)
Cs:addButton(
    "Give Tokens Cmds",
    function()
        loadstring(
            game:HttpGet("https://raw.githubusercontent.com/miguel831/Topi/main/CriticalStrike/Give%20Tokens%20Cmds", true)
        )()
    end
)
Cs1:addButton(
    "CMD-X Fe Commands",
    function()
        loadstring(
            game:HttpGet("https://raw.githubusercontent.com/CMD-X/CMD-X/master/Source", true)
        )()
    end
)

local themes = {
    Background = Color3.fromRGB(24, 24, 24),
    Glow = Color3.fromRGB(0, 0, 0),
    Accent = Color3.fromRGB(10, 10, 10),
    LightContrast = Color3.fromRGB(20, 20, 20),
    DarkContrast = Color3.fromRGB(14, 14, 14),  
    TextColor = Color3.fromRGB(255, 255, 255)
    }
    
    local theme = SShub:addPage("Ui", 5012544693)
    local colors = theme:addSection("Colors")
    local UiToggle = theme:addSection("Ui Toggle")
    
    UiToggle:addKeybind("Toggle Keybind", Enum.KeyCode.RightControl, function()
        SShub:toggle()
        end, function()
    end)
    
    
    for theme, color in pairs(themes) do 
    colors:addColorPicker(theme, color, function(color3)
    SShub:setTheme(theme, color3)
           end
        )
    end
    
    local Credits = SShub:addPage("Credits", 5012544693)
    local Credit = Credits:addSection("Credits: Tupi#2739")
    
    SShub:SelectPage(SShub.pages[1], true)
end
