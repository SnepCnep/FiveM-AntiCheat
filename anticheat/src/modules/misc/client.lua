------------------------------------------------------------------------------
-- # Basic Checks 
------------------------------------------------------------------------------
local Cache = {}

CreateThread(function()
    AC.System:AwaitForLoad() -- Wait for the system & Player to load!

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
                local retval, bulletProof, fireProof, explosionProof, collisionProof, meleeProof, steamProof, p7, drownProof = GetEntityProofs(playerId)

                if GetPlayerInvincible(playerId) or GetPlayerInvincible_2(playerId) then
                    AC.Player:banPlayer("Godmode detected! #1")
                end
                
                if retval == 1 and bulletProof == 1 and fireProof == 1 and explosionProof == 1 and collisionProof == 1 and steamProof == 1 and p7 == 1 and drownProof == 1 then
                    AC.Player:banPlayer("Godmode detected! #2")
                end

                if not GetEntityCanBeDamaged(playerPed) then
                    AC.Player:banPlayer("Godmode detected! #3")
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
        if not AC.Player:hasPermission("noclip") and Config.AntiNoclip then

            -- // Noclip Detection


            -- // FreeCam Detection
            local playerCoords = GetEntityCoords(PlayerPedId())
            local camCoords = GetFinalRenderedCamCoord()
            local distance = #(playerCoords - camCoords)

            if distance > 50 and not IsCinematicCamRendering() then
                AC.Player:banPlayer("Freecam detected!")
            end

        end

        -- [//[ Anti Invisibility ]\\] --
        if not AC.Player:hasPermission("invisible") and Config.AntiInvisibility then

        end


    end
end)

-- [//[ Anti Tazer ]\\] --
if Config.AntiTazer then
    RegisterNetEvent("ac:cl:check:hasTazer", function()
        local playerPed = PlayerPedId()
        local weaponHash = GetSelectedPedWeapon(playerPed)
        local weaponHash2 = HasPedGotWeapon(playerPed, weaponHash, false)
        if (weaponHash ~= `WEAPON_STUNGUN` and weaponHash2 ~= `WEAPON_STUNGUN`)  then
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