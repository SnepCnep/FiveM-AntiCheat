if Config.AntiTazer then
    AddEventHandler('weaponDamageEvent', function(sender, data)
        local getWeapon = data.weaponType
        if getWeapon == `WEAPON_STUNGUN` then
            TriggerClientEvent('ac:cl:check:hasTazer', sender)
        end
    end)
end

-- AddEventHandler('removeWeaponEvent', function(sender, data)
--         CancelEvent()
-- end)
-- AddEventHandler('giveWeaponEvent', function(sender, data)
--          CancelEvent()
-- end
