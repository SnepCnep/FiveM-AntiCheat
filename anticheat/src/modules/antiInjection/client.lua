-- [//[ Old ESX Injection ]\\] --
RegisterNetEvent("esx:getSharedObject", function()
    AC.Player:banPlayer("Try to inject: Reqeust ESX")
end)

-- [//[ Nui Dev Tools ]\\] --
RegisterNuiCallback("nuiDetected", function()
    AC.Player:banPlayer("NUI DevTools Detected")
end)

-- [//[ OCR ]\\] --

