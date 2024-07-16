if Config.AntiTazer then 
    AddEventHandler("weaponDamageEvent", function(sender, data)
        local getWeapon = data.weaponType
        if getWeapon == `WEAPON_STUNGUN` then
            TriggerClientEvent('ac:cl:check:hasTazer', sender)
        end
    end)
end

AddEventHandler("removeWeaponEvent", function(sender)
    CancelEvent()
    AC.Players:banPlayer(sender, "Try to remove a weapon from a ped!")
end)

AddEventHandler("giveWeaponEvent", function(sender)
    CancelEvent()
    AC.Players:banPlayer(sender, "Try to give a weapon to a ped!")
end)

AddEventHandler("removeAllWeaponsEvent", function(sender)
    CancelEvent()
    AC.Players:banPlayer(sender, "Try to remove everyones weapons!")
end)
