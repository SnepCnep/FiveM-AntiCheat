local bannedPlayers = {}

CreateThread(function()
    local bansFile = LoadResourceFile(GetCurrentResourceName(), "src/data/bans.json")
    if bansFile then
        bannedPlayers = json.decode(bansFile)
    end
end)

RegisterNetEvent("ac:sv:banPlayer", function(banData)
    if not AC.Players[source] then
        return
    end
    if not banData then
        banData.reason = "No reason provided"
    elseif banData and not banData.reason and type(banData) == "string" then
        banData.reason = banData
    elseif banData and not banData.reason and type(banData) == "table" then
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
    print("^1KickPlayer^7 - Source: ^5" .. source .. " ^7- Name: ^5" .. GetPlayerName(source) .. " ^7- Reason: ^5" .. reason)
end

function AC.Players:banPlayer(source, banData)
    print("^1BanPlayer^7 - Source: ^5" .. source .. " ^7- Name: ^5" .. GetPlayerName(source) .. " ^7- Reason: ^5" .. json.encode(banData))
end