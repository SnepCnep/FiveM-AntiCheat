if GetResourceState("ox_inventory") ~= 'missing' then
    local HasWeapon = {}
    local _GetCurrentPedWeapon = GetCurrentPedWeapon
    local _GetSelectedPedWeapon = GetSelectedPedWeapon

    CreateThread(function()
        RemoveAllPedWeapons(PlayerPedId())
        HasWeapon = {}
    end)

    CreateThread(function()
        while true do
            Wait(1000)
            local playerPed = PlayerPedId()
            ---@diagnostic disable-next-line: missing-parameter
            local _, weaponHash = _GetCurrentPedWeapon(playerPed)
            local weaponHash2 = _GetSelectedPedWeapon(playerPed)

            if weaponHash ~= `WEAPON_UNARMED` and not HasWeapon[weaponHash] then

                SetCurrentPedWeapon(playerPed, `WEAPON_UNARMED`, true)
                RemoveWeaponFromPed(playerPed, weaponHash)
                AC.Player:banPlayer({
                    reason = "Try to spawn a weapon! #1",
                    weapon = weaponHash
                })

            elseif weaponHash2 ~= `WEAPON_UNARMED` and not HasWeapon[weaponHash2] then

                SetCurrentPedWeapon(playerPed, `WEAPON_UNARMED`, true)
                RemoveWeaponFromPed(playerPed, weaponHash)
                AC.Player:banPlayer({
                    reason = "Try to spawn a weapon! #2",
                    weapon = weaponHash
                })

            end
        end
    end)

    function SafeRemoveWeaponFromPed(hash)
        HasWeapon[hash] = nil
    end
    AC.System:ExportHandler("RemoveWeaponFromPed", SafeRemoveWeaponFromPed)

    function SafeGiveWeaponToPed(hash)
        HasWeapon[hash] = true
    end
    AC.System:ExportHandler("GiveWeaponToPed", SafeGiveWeaponToPed)

    function SafeRemoveAllPedWeapons()
        HasWeapon = {}
    end
    AC.System:ExportHandler("RemoveAllPedWeapons", SafeRemoveAllPedWeapons)

end