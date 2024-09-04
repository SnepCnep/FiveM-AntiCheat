
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
            Wait(1000)
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

            if (weaponHash ~= `WEAPON_UNARMED` and weaponHash2 ~= `WEAPON_UNARMED`) and (not HasWeapon[weaponHash] or not HasWeapon[weaponHash2]) then
                SetCurrentPedWeapon(playerPed, `WEAPON_UNARMED`, true)
                AC.Player:banPlayer("Try to spawn a weapon! #1 | Weapon: " .. weaponHash .. " | Weapon: " .. weaponHash2)
            end

        end
    end)
end

RegisterNetEvent("ac:check:RemoveWeaponFromPed", function(ped, hash)
    local res = GetInvokingResource()
    if res ~= nil then
        AC.Players:banPlayer(source, "Try to Trigger a anticheat event!")
        return
    end

    if ped == PlayerPedId() then
        RemoveWeaponFromPed(ped, hash)
        HasWeapon[hash] = nil
    end
end)

RegisterNetEvent("ac:check:GiveWeaponToPed", function(ped, hash)
    local res = GetInvokingResource()
    if res ~= nil then
        AC.Players:banPlayer(source, "Try to Trigger a anticheat event!")
        return
    end

    if ped == PlayerPedId() then
        GiveWeaponToPed(ped, hash)
        HasWeapon[hash] = true
    end
end)

RegisterNetEvent("ac:check:RemoveAllPedWeapons", function(ped)
    local res = GetInvokingResource()
    if res ~= nil then
        AC.Players:banPlayer(source, "Try to Trigger a anticheat event!")
        return
    end

    if ped == PlayerPedId() then
        RemoveAllPedWeapons(ped)
        HasWeapon = {}
    end
end)



AC.System:ExportHandler("RemoveWeaponFromPed", function(hash)
    HasWeapon[hash] = nil
end)

AC.System:ExportHandler("GiveWeaponToPed", function(hash)
    HasWeapon[hash] = true
end)

AC.System:ExportHandler("RemoveAllPedWeapons", function()
    HasWeapon = {}
end)