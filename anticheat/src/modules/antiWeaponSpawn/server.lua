-- reqeure server for ESX Default the use server side version

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