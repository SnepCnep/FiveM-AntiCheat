-- [//[ Old ESX Injection ]\\] --
if Config.AntiOldESX then
    RegisterNetEvent("esx:getSharedObject", function()
        AC.Player:banPlayer("Try to inject: Reqeust ESX")
    end)
end

-- [//[ OCR ]\\] --

