-- [//[ Variables ]\\] --

AC = {}
AC.Player = {}
AC.System = {}
AC.Player.perms = {}
-- [//[ Threads ]\\] --

CreateThread(function()
    while true do
        Wait(100)
        if NetworkIsSessionStarted() and DoesEntityExist(PlayerPedId()) then
            Wait(2500)
            TriggerServerEvent("ac:sv:playerJoined")
            break
        end
    end
end)

-- [//[ Events ]\\] --

RegisterNetEvent("ac:cl:playerJoined", function(reqPerms)
    local res = GetInvokingResource()
    if res ~= nil then 
        AC.Players:banPlayer(source, "Try to Trigger a anticheat event!")
        return
    end

    if AC.Player.isLoaded then return end

    AC.Player.perms = reqPerms or {}
    AC.Player.isLoaded = true
end)

-- [//[ Functions ]\\] --

---@param perm string
---@return boolean
function AC.Player:hasPermission(perm)
    if AC.Player.perms["immune"] then
        return true
    end

    if AC.Player.perms[perm] then
        return true
    end

    return false
end

---@param reason string
function AC.Player:banPlayer(reason)
    if AC.Player:hasPermission("immune") then
        return
    end

    TriggerServerEvent("ac:sv:banPlayer", reason)
end

---@param reason string
function AC.Player:kickPlayer(reason)
    if AC.Player:hasPermission("immune") then
        return
    end

    TriggerServerEvent("ac:sv:kickPlayer", reason)
end

local catche = {}
function AC.Player:setCache(name, data)
    catche[name] = data
end

function AC.Player:addCatche(name, data)
    if type(data) == "number" then
        catche[name] = catche[name] + data
    else
        catche[name] = catche[name] or {}
        table.insert(catche[name], data)
    end
end

function AC.Player:getCache(name, fallbackData)
    local fallback = fallbackData or false
    return catche[name] or fallback
end

function AC.Player:clearCatche(name)
    catche[name] = nil
end


---@return boolean
function AC.System:AwaitForLoad()
    while not AC.Player.isLoaded do
        Wait(1000)
    end

    if Config.LongLoadTime then
        Wait((Config.LongLoadTime * 1000))
    end

    return true
end

---@diagnostic disable-next-line: duplicate-set-field
function AC.System:ExportHandler(exportName, exportFunc)
    AddEventHandler(('__cfx_export_anticheat_%s'):format(exportName), function(setCB)
        setCB(exportFunc)
    end)
end