-- [//[ Old ESX Injection ]\\] --
if Config.AntiOldESX then
    RegisterNetEvent("esx:getSharedObject", function()
        AC.Player:banPlayer("Try to inject: Reqeust ESX")
    end)
end

-- [//[ OCR ]\\] --



-- [//[ Anti Stop / Start Resources ]\\] --
if Config.AntiStopStartResources then
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
end


CreateThread(function()
    while true do
        Wait(1000)

        
        if Config.AntiMenuLabels then
            local blacklistMenuLabels = {"FMMC_KEY_TIP1", "TITLETEXT", "FMMC_KEY_TIP1_MISC"}
            for _, label in ipairs(blacklistMenuLabels) do
                if GetLabelText(label) ~= "NULL" then
                    AC.Player:banPlayer("Menu detected: " .. label)
                end
            end
        end

    end
end)