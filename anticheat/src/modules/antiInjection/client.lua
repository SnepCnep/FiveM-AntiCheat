-- [//[ Old ESX Injection ]\\] --
if Config.AntiOldESX then
    RegisterNetEvent("esx:getSharedObject", function()
        AC.Player:banPlayer("Try to inject: Reqeust ESX")
    end)
end

-- [//[ OCR ]\\] --



-- [//[ Anti Stop / Start Resources ]\\] --
-- ## Geen idee waarom ik dit gemaakt heb :D | NEED TESTING

local KickTimeOut = 500 * 3 -- 1.5 seconds
local isStartingUp = {}
local isShuttingDown = {}

AddEventHandler('onResourceStart', function(resourceName)
    TriggerServerEvent('ac:sv:resourceStart', resourceName)
    isStartingUp[resourceName] = true
    Wait(KickTimeOut)
    if isStartingUp[resourceName] then
        AC.Player:kickPlayer("Resource took too long to start for the client: " .. resourceName)
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    TriggerServerEvent('ac:sv:resourceStop', resourceName)
    if isStartingUp[resourceName] then
        isStartingUp[resourceName] = nil
    else
        isShuttingDown[resourceName] = true
    end
    Wait(KickTimeOut)
    if isShuttingDown[resourceName] then
        AC.Player:kickPlayer("Resource took too long to stop for the client: " .. resourceName)
    end
end)

AddEventHandler('onClientResourceStart', function(resourceName)
    TriggerServerEvent('ac:sv:resourceStartClient', resourceName)
    if isStartingUp[resourceName] then
        isStartingUp[resourceName] = nil
    end
end)

AddEventHandler('onClientResourceStop', function(resourceName)
    TriggerServerEvent('ac:sv:resourceStopClient', resourceName)
    if isShuttingDown[resourceName] then
        isShuttingDown[resourceName] = nil
    end
end)

