AC = {}
AC.Player = {}
AC.System = {}

CreateThread(function()
    while true do
        Wait(0)
        if NetworkIsSessionStarted() then
            Wait(500)
            TriggerServerEvent("ac:sv:playerJoined")
            break
        end
    end
end)
-- [//[ Events ]\\] --

RegisterNetEvent("ac:cl:playerJoined", function(reqPerms)
    local res = GetInvokingResource()
    if res ~= nil then return end

    if AC.Player.isLoaded then return end

    AC.Player.perms = reqPerms or {}
    AC.Player.isLoaded = true
end)

-- [//[ Functions ]\\] --
function AC.Player:hasPermission(perm)
    if AC.Player.perms["immune"] then
        return true
    end

    if AC.Player.perms[perm] then
        return true
    end

    return false
end

---@param banData table | string
function AC.Player:banPlayer(banData)
    if AC.Player:hasPermission("immune") then
        return 
    end

    TriggerServerEvent("ac:sv:banPlayer", banData)
end

function AC.Player:kickPlayer(reason)
    if AC.Player:hasPermission("immune") then
        return 
    end

    TriggerServerEvent("ac:sv:kickPlayer", banData)
end

function AC.System:AwaitForLoad()
    while not AC.Player.isLoaded do
        Wait(0)
    end
end

---@diagnostic disable-next-line: duplicate-set-field
function AC.System:ExportHandler(exportName, exportFunc)
    AddEventHandler(('__cfx_export_anticheat_%s'):format(exportName), function(setCB)
        setCB(exportFunc)
    end)
end