-- [//[ Old ESX Injection ]\\] --
if Config.AntiOldESX then
    RegisterNetEvent("esx:getSharedObject", function()
        AC.Player:banPlayer("Try to inject: Reqeust ESX")
    end)
end

-- [//[ Nui Dev Tools ]\\] --
RegisterNuiCallback("nuiDetected", function()
    AC.Player:banPlayer("NUI DevTools Detected")
end)

-- [//[ OCR ]\\] --

