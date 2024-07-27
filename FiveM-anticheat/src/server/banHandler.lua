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
    local checkIPURL = ""
    PerformHttpRequest(checkIPURL .. playerIP, function(code, response, headers)
        if code == 200 then
            local data = json.decode(response)
            if data and data.vpn then
                hasVPN = true
            end
        else
            print("^1Failed to check for VPN. Error code: " .. code .. "^7")
        end
    end, "GET", "", { ["Content-Type"] = "application/json" })

    Wait(100)
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
    if AC.Players:checkBan(src) then
        AC.Players:blockBan(deferrals, playerName)
        return
    end
    Wait(100)
    if Config.AntiVPN then
        deferrals.update("Checking for VPN...")
        if AC.Players:checkVPN(src) then
            AC.Players:blockVPN(deferrals, playerName)
            return
        end
    end

    deferrals.done()
end)


function AC.Players:blockVPN(deferrals, playerName)
    
end

function AC.Players:blockBan(deferrals, playerName)

end
