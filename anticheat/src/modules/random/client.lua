------------------------------------------------------------------------------
-- # Basic Checks 
------------------------------------------------------------------------------

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
            -- fes
        end

        -- [//[ Anti Spectate ]\\] --
        if not AC.Player:hasPermission("spectate") and Config.AntiSpectate then
            if NetworkIsInSpectatorMode() then
                AC.Player:banPlayer("spectate detected!")
            end
        end



    end
end)