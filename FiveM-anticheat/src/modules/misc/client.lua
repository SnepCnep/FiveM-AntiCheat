------------------------------------------------------------------------------
-- # Basic Checks
------------------------------------------------------------------------------
local Cache = {}

CreateThread(function()
    AC.System:AwaitForLoad() -- Wait for the system & Player to load!

    Wait(500)

    while true do
        Wait(1000)
        local playerPed = PlayerPedId()
        local playerId = PlayerId()

        -- [//[ Anti Vision ]\\] --
        if (not IsPedInAnyHeli(playerPed) and GetUsingseethrough()) then
            AC.Player:banPlayer("Thermal vision detected!")
        end
        if (not IsPedInAnyHeli(playerPed) and GetUsingnightvision()) then
            AC.Player:banPlayer("Night vision detected!")
        end

        -- [//[ Anti Godmode ]\\] --
        if not AC.Player:hasPermission("godmode") and Config.AntiGodmode then
            if NetworkIsPlayerActive(PlayerId()) and not IsNuiFocused() and IsScreenFadedIn() then
                local retval, bulletProof, fireProof, explosionProof, collisionProof, meleeProof, steamProof, p7, drownProof =
                GetEntityProofs(playerId)

                if GetPlayerInvincible(playerId) or GetPlayerInvincible_2(playerId) then
                    AC.Player:banPlayer("Godmode detected! | Type: #1")
                end

                if retval == 1 and bulletProof == 1 and fireProof == 1 and explosionProof == 1 and collisionProof == 1 and steamProof == 1 and p7 == 1 and drownProof == 1 then
                    AC.Player:banPlayer("Godmode detected! | Type: #2")
                end

                if not GetEntityCanBeDamaged(playerPed) then
                    AC.Player:banPlayer("Godmode detected! | Type: #3")
                end
            end
        end

        -- [//[ Anti Spectate ]\\] --
        if not AC.Player:hasPermission("spectate") and Config.AntiSpectate then
            if NetworkIsInSpectatorMode() then
                AC.Player:banPlayer("spectate detected!")
            end
        end

        -- [//[ Anti Noclip / Freecam ]\\] --
        -- // Noclip Detection
        if not AC.Player:hasPermission("noclip") and Config.AntiNoclip then

        end
        
        
        if not AC.Player:hasPermission("freecam") and Config.AntiFreecam then
            -- // FreeCam Detection
            local playerCoords = GetEntityCoords(playerPed)
            local camCoords = GetFinalRenderedCamCoord()
            local distance = #(playerCoords - camCoords)

            if distance > 50 and not IsCinematicCamRendering() then
                AC.Player:banPlayer("Freecam detected! | #1")
            end
        end

        -- [//[ Anti Invisibility ]\\] --
        if not AC.Player:hasPermission("invisible") and Config.AntiInvisibility then

        end

        if not AC.Player:hasPermission("explosion") and Config.AntiWeaponExplosion then
            local weaponHash = GetSelectedPedWeapon(playerPed)
            local wgroup = GetWeapontypeGroup(weaponHash)
            local dmgt = GetWeaponDamageType(weaponHash)
            if wgroup == -1609580060 or wgroup == -728555052 or weaponHash == -1569615261 then
                if dmgt ~= 2 then
                    AC.Player:banPlayer("Tried to use explosive melee")
                end
            elseif wgroup == 416676503 or wgroup == -957766203 or wgroup == 860033945 or wgroup == 970310034 or wgroup == -1212426201 then
                if dmgt ~= 3 then
                    AC.Player:banPlayer("Tried to use explosive weapon")
                end
            end
        end



    end
end)

-- [//[ Anti Tazer ]\\] --
if Config.AntiTazer then
    RegisterNetEvent("ac:cl:check:hasTazer", function()
        local playerPed = PlayerPedId()
        local weaponHash = GetSelectedPedWeapon(playerPed)
        local weaponHash2 = HasPedGotWeapon(playerPed, weaponHash, false)
        
        if (weaponHash ~= `WEAPON_STUNGUN` and weaponHash2 ~= `WEAPON_STUNGUN`) then
            AC.Player:banPlayer("Try to tazer people!")
        end
    end)
end

-- [//[ Nui Dev Tools ]\\] --
if Config.AntiNuiDevtools then
    RegisterNuiCallback("nuiDetected", function()
        AC.Player:banPlayer("Nui Devtools detected!")
    end)
end
