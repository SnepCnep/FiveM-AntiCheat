AC = {}

AC.Players = {}
AC.System = {}

_print = print
function print(message)
    if not message or type(message) ~= "string" then
        return
    end
    _print("^7[^5ANTICHEAT^7] ^4- ^5" .. message .. "^0")
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
    print("PlayerJoined - Source: " .. source .. " - Name: " .. GetPlayerName(source))
    TriggerClientEvent("ac:cl:playerJoined", source)
end)

RegisterNetEvent("playerDropped", function()
    if AC.Players[source] then
        AC.Players[source] = nil -- Remove player from table ( Memory management )
    end
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