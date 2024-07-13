-- EveryThing behind the banPlayer Function :)
RegisterNetEvent("ac:sv:banPlayer", function(banData)
    if not AC.Players[source] then
        return
    end
    if not banData then
        banData = { reason = "No reason provided", sideAction = "client" }
    elseif type(banData) ~= "table" then
        banData = { reason = banData, sideAction = "client" }
    elseif not banData.sideAction and type(type) == "table" then
        banData.sideAction = "client"
    end

    AC.Players:banPlayer(source, banData)
end)

function AC.Players:banPlayer(source, banData)
    print("^1BanPlayer^7 - Source: ^5" .. source .. " ^7- Name: ^5" .. GetPlayerName(source) .. " ^7- Reason: ^5" .. json.encode(banData))
end