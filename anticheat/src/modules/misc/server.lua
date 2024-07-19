if Config.AntiTazer then 
    AddEventHandler("weaponDamageEvent", function(sender, data)
        local getWeapon = data.weaponType
        if getWeapon == `WEAPON_STUNGUN` then
            TriggerClientEvent('ac:cl:check:hasTazer', sender)
        end
    end)
end