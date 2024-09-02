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
    if res ~= nil then return end

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
function AC.Player:setCache(string, data)
    catche[string] = data
end

function AC.Player:addCatche(string, data)
    if type(data) == "number" then
        catche[string] = catche[string] + data
    else
        catche[string] = catche[string] or {}
        table.insert(catche[string], data)
    end
end

function AC.Player:getCache(string, fallbackData)
    local fallback = fallbackData or false
    return catche[string] or fallback
end

function AC.Player:clearCatche(string)
    if type(catche[string]) == "table" then
        for k, _ in pairs(catche[string]) do
            catche[string][k] = nil
        end
    elseif type(catche[string]) == "number" then
        catche[string] = 0
    else
        catche[string] = nil
    end
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