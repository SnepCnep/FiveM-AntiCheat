local bannedPlayers = {}

CreateThread(function()
    local bansFile = LoadResourceFile(GetCurrentResourceName(), "src/data/bans.json")
    if bansFile then
        bannedPlayers = json.decode(bansFile)
    end
end)

RegisterNetEvent("ac:sv:banPlayer", function(Reason)
    if not AC.Players[source] then
        return
    end
    local banData = {}

    if Reason and type(Reason) == "string" then
        banData.reason = Reason
    elseif Reason and type(Reason) == "table" then
        banData = Reason
    else
        banData.reason = "No reason provided"
    end

    AC.Players:banPlayer(source, banData)
end)

RegisterNetEvent("ac:sv:kickPlayer", function(reason)
    if not AC.Players[source] then
        return
    end
    if not reason then
        reason = "No reason provided"
    end

    AC.Players:kickPlayer(source, reason)
end)

function AC.Players:kickPlayer(source, reason)
    print("^1KickPlayer^7 - Source: ^5" ..
        source .. " ^7- Name: ^5" .. GetPlayerName(source) .. " ^7- Reason: ^5" .. reason)
end

function AC.Players:banPlayer(source, banData)
    print("^1BanPlayer^7 - Source: ^5" ..
        source .. " ^7- Name: ^5" .. GetPlayerName(source) .. " ^7- Reason: ^5" .. json.encode(banData))
end

function AC.Players:checkVPN(source)
    if not Config.AntiVPN then
        return false
    end

    local playerIP = GetPlayerEndpoint(source)
    local hasVPN = false
    PerformHttpRequest("http://ip-api.com/json/" .. playerIP .. "?fields=66846719", function(code, response, headers)
        if code ~= 200 then
            hasVPN = false
            print("Error to check for VPN!")
            return
        end

        local data = json.decode(response)
        if data and data.status == "success" then
            if data.proxy then
                hasVPN = true
            end
        else
            hasVPN = false
            print("A unkown error has been called on checking for VPN!")
        end
    end, "GET", "", { ["Content-Type"] = "application/json" })

    return hasVPN
end

function AC.Players:checkBan(source)
    local identifiers = GetPlayerIdentifiers(source)
    local numUserTokens = GetNumPlayerTokens(source)

    for _, player in pairs(bannedPlayers) do
        for _, identifier in pairs(player.identifiers) do
            for _, playerIdentifier in pairs(identifiers) do
                if identifier == playerIdentifier then
                    return (player["banId"] or "unkown")
                end
            end
        end

        for _, userToken in pairs(player.userTokens) do
            for i = 0, numUserTokens - 1 do
                if userToken == GetPlayerToken(source, i) then
                    return (player["banId"] or "unkown")
                end
            end
        end
    end

    return false
end

-- [//[ Join Check (Ban/VPN) ]\\] --

RegisterNetEvent("playerConnecting", function(playerName, setKickReason, deferrals)
    local src = source
    
    deferrals.defer()

    Wait(100)

    deferrals.update("Checking for bans...")

    Wait(100)

    local banID = AC.Players:checkBan(src)
    if banID then
        AC.Players:blockBan(deferrals, playerName, banID)
        return
    end
    if Config.AntiVPN then
        if AC.Players:checkVPN(src) then
            AC.Players:blockVPN(deferrals, playerName)
            return
        end
    end

    deferrals.done()
end)


function AC.Players:blockVPN(deferrals, playerName)
    local VPNblockMessage  = {
        ["$schema"] = "http://adaptivecards.io/schemas/adaptive-card.json",
        ["type"] = "AdaptiveCard",
        ["version"] = "1.6",
        ["body"] = {
            {
                ["type"] = "TextBlock",
                ["text"] = "VPN Detected",
                ["size"] = "Large",
                ["weight"] = "Bolder"
            },
            {
                ["type"] = "TextBlock",
                ["text"] = "You are using a VPN to connect to the server. Please disable it and try again.",
                ["wrap"] = true
            }
        },
    }
    deferrals.presentCard(VPNblockMessage)
end

function AC.Players:blockBan(deferrals, playerName, banID)
    local BanblockMessage  = {
        ["$schema"] = "http://adaptivecards.io/schemas/adaptive-card.json",
        ["type"] = "AdaptiveCard",
        ["version"] = "1.6",
        ["body"] = {
            {
                ["type"] = "TextBlock",
                ["text"] = "Banned",
                ["size"] = "Large",
                ["weight"] = "Bolder"
            },
            {
                ["type"] = "TextBlock",
                ["text"] = "You are banned from the server. BanID: " .. AC.Players:checkBan(source),
                ["wrap"] = true
            }
        },
    }
    deferrals.presentCard(BanblockMessage)
end
