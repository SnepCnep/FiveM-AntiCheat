local bannedPlayers = {}

CreateThread(function()
    local bansFile = LoadResourceFile(GetCurrentResourceName(), "src/data/bans.json")
    if bansFile then
        bannedPlayers = json.decode(bansFile)
        if not bannedPlayers or type(bannedPlayers) ~= "table" then
            bannedPlayers = {}
        end
    end
end)

RegisterNetEvent("ac:sv:banPlayer", function(reason)
    if not AC.Players[source] then
        return
    end
    if not reason or type(reason) ~= "string" then
        reason = "No reason provided."
    end

    AC.Players:banPlayer(source, reason)
end)

RegisterNetEvent("ac:sv:kickPlayer", function(reason)
    if not AC.Players[source] then
        return
    end
    if not reason or type(reason) ~= "string" then
        reason = "No reason provided."
    end

    AC.Players:kickPlayer(source, reason)
end)




-- [//[ Functions]\\] --
local gBanId = 0
local function generateBanId()
    if gBanId == 0 then
        for k, v in pairs(bannedPlayers) do
            if v["banId"] > gBanId then
                gBanId = v["banId"]
            end
        end
    end
    gBanId = gBanId + 1
    return gBanId
end



function AC.Players:kickPlayer(source, reason)
    if (Config.Debugger or false) then
        print("^1KickPlayer(DEBUG)^7 - Source: ^5" .. source .. " ^7- Name: ^5" .. GetPlayerName(source) .. " ^7- Reason: ^5" .. reason)
        return
    end
    DropPlayer(source, reason)
    print("^1KickPlayer^7 - Source: ^5" .. source .. " ^7- Name: ^5" .. GetPlayerName(source) .. " ^7- Reason: ^5" .. reason)
end

local isAlreadyBanned = {}
function AC.Players:banPlayer(source, reason)
    if (Config.Debugger or false) then
        print("^1BanPlayer(DEBUG)^7 - Source: ^5" .. source .. " ^7- Name: ^5" .. GetPlayerName(source) .. " ^7- Reason: ^5" .. reason)
        return
    end
    if isAlreadyBanned[source] then
        return
    end
    isAlreadyBanned[source] = true

    local banID = generateBanId()
    local banData = {}

    banData["banId"] = tostring(banID)
    banData["name"] = (GetPlayerName(source) or "Unknown")
    banData["datum"] = os.date("%Y-%m-%d %H:%M:%S")
    banData["reason"] = (reason or "No reason provided.")
    banData["identifiers"] = GetPlayerIdentifiers(source)
    banData["userTokens"] = {}
    local numUserTokens = GetNumPlayerTokens(source)
    if numUserTokens ~= 0 then
        for i = 0, numUserTokens - 1 do
            table.insert(banData["userTokens"], GetPlayerToken(source, i))
        end
    end

    bannedPlayers[tostring(banID)] = banData

    SaveResourceFile(GetCurrentResourceName(), "src/data/bans.json", json.encode(bannedPlayers, { indent = true }), -1)
    DropPlayer(source, reason)
    -- AC.System:Logs({
    --     type = "ban",
    --     source = source,
    --     reason = reason,
    --     banId = banID
    -- })
    print("^1BanPlayer^7 - Source: ^5" ..source .. " ^7- Name: ^5" .. banData["name"] .. " ^7- Reason: ^5" .. reason)
end

function AC.Players:checkVPN(source)
    if not Config.AntiVPN then
        return false
    end

    local playerIP = GetPlayerEndpoint(source)
    local hasVPN = false
    PerformHttpRequest("http://ip-api.com/json/".. playerIP .."?fields=66846719", function(code, response, _)
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

    Wait(200)

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

RegisterNetEvent("playerConnecting", function(playerName, _, deferrals)
    local src = source
    
    deferrals.defer()

    deferrals.update("Checking for bans...")

    Wait(100)

    local banID = AC.Players:checkBan(src)
    if banID then
        AC.Players:blockBan(deferrals, banID, playerName)
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
    return deferrals.presentCard(VPNblockMessage)
end

function AC.Players:blockBan(deferrals, banID, playerName)
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
                ["text"] = "You are banned from the server.",
                ["wrap"] = true
            },
            {
                ["type"] = "TextBlock",
                ["text"] = "Ban ID: " .. banID,
                ["wrap"] = true
            }
        },
    }
    return deferrals.presentCard(BanblockMessage)
end

AC.System:RegisterCommand("unban", function(source, args)
    if source == 0 then
        local banId = args[2]
        if not banId then
            print("Please provide a ban id!")
            return
        end

        if bannedPlayers[tostring(banId)] then
            bannedPlayers[tostring(banId)] = nil
            print("Player has been unbanned!")

        else
            print("This player is not banned!")
        end
    else
        local banId = args[2]
        if not banId then
            print("Please provide a ban id!")
            return
        end

        if bannedPlayers[tostring(banId)] then
            bannedPlayers[tostring(banId)] = nil
            SaveResourceFile(GetCurrentResourceName(), "src/data/bans.json", json.encode(bannedPlayers, { indent = true }), -1)
            print("Player has been unbanned!")
        else
            print("This player is not banned!")
        end
    end
end, "unban", false)

AC.System:RegisterCommand("baninfo", function(source, args)
    local banId = args[2]
    if not banId then
        print("Please provide a ban id!")
        return
    end

    if not bannedPlayers[tostring(banId)] then
        print("This player is not banned!")
        return
    end
    
    local banInfo = bannedPlayers[tostring(banId)]
    print("^3-----------------------------[[ ^5Ban Info ^3]]-----------------------------^0")
    print("Ban ID: " .. banId)
    print("Name: " .. (banInfo["name"] or "Unknown"))
    print("Reason: " .. (banInfo["reason"] or "No reason provided."))
    print("Date: " .. (banInfo["datum"] or "Unknown"))
    print("^3-------------------------------------------------------------------------------^0")
end, "console", true)