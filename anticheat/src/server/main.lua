AC = {}

AC.Players = {}
AC.System = {}

_print = print
function print(message)
    if not message or type(message) ~= "string" then
        return
    end
    _print("^7[^5ANTICHEAT^7] ^4- ^7" .. message .. "^7")
end

-- [[ Events ]] --
RegisterNetEvent("ac:sv:playerJoined", function()
    if AC.Players[source] then
        return
    end

    local playerPermissions = AC.Players:getPermissions(source)

    AC.Players[source] = {
        permissions = playerPermissions
    }
    print("^7PlayerJoined - Source: ^5" .. source .. " ^7- Name: ^5" .. GetPlayerName(source) .. "^7")
    TriggerClientEvent("ac:cl:playerJoined", source)
end)

RegisterNetEvent("playerDropped", function(reason)
    if AC.Players[source] then
        AC.Players[source] = nil -- Remove player from table ( Memory management )
    end
    print("^7PlayerDropped - Source: ^5" .. source .. " ^7- Name: ^5" .. GetPlayerName(source) .. " ^7- Reason: ^5" .. reason .. "^7")
end)

-- [[ Functions ]] --
function AC.Players:getPermissions(player)
    return {}
end

function AC.Players:checkPermission(source, permission)
    if AC.Players[source] then
        if AC.Players[source].permissions[permission] then
            return true
        end
    end
    return false
end

---@diagnostic disable-next-line: duplicate-set-field
function AC.System:ExportHandler(exportName, exportFunc)
    AddEventHandler(('__cfx_export_anticheat_%s'):format(exportName), function(setCB)
        setCB(exportFunc)
    end)
end