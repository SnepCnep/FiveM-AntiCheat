if GetResourceState("ox_inventory") ~= 'missing' then
    local HasWeapon = {}
    local _GetCurrentPedWeapon = GetCurrentPedWeapon
    local _GetSelectedPedWeapon = GetSelectedPedWeapon

    if Config.AntiWeaponSpawn then
        CreateThread(function()
            RemoveAllPedWeapons(PlayerPedId())
            HasWeapon = {}
        end)

        CreateThread(function()
            AC.System:AwaitForLoad()

            while true do
                if Config.AntiWeaponSpawnInstaBan then
                    Wait(1)
                else
                    Wait(1000)
                end
                local playerPed = PlayerPedId()
                ---@diagnostic disable-next-line: missing-parameter
                local _, weaponHash = _GetCurrentPedWeapon(playerPed)
                local weaponHash2 = _GetSelectedPedWeapon(playerPed)

                if weaponHash == 0 then
                    ---@diagnostic disable-next-line: cast-local-type
                    weaponHash = `WEAPON_UNARMED`
                end
                if weaponHash2 == 0 then
                    ---@diagnostic disable-next-line: cast-local-type
                    weaponHash2 = `WEAPON_UNARMED`
                end

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
    end
    
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