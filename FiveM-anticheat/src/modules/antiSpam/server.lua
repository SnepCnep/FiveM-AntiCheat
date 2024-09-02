CreateThread(function()
    while true do
        AC.Player:clearCatche({
            "vehicle",
            "props",
            "peds",
            "particles",
            "tazer"
        })
        Wait(1200)
    end
end)

if not Config.AntiSpamVehicle and not Config.AntiSpamProps and not Config.AntiSpamPeds then
    RegisterNetEvent("entityCreated", function(entity)
        if not DoesEntityExist(entity) then
            return
        end

        local id = NetworkGetEntityOwner(entity)
        local entitytype = GetEntityType(entity)

        if entitytype == 1 and Config.AntiSpamPeds then
            -- Anti Spam Peds
            AC.Player:addCatche("peds", 1)
            local totalCreations = AC.Player:getCache("peds")
            
            if totalCreations > (Config.AntiSpamPedsLimit or 0) then
                AC.Player:banPlayer("AntiSpam: Peds Spawn | Created " .. (totalCreations or "Error") .. " Peds.")
            end
        elseif entitytype == 2 and Config.AntiSpamVehicle then
            -- Anti Spam Vehicle
            AC.Player:addCatche("vehicle", 1)
            local totalCreations = AC.Player:getCache("vehicle")
            
            if totalCreations > (Config.AntiSpamVehicleLimit or 0) then
                AC.Player:banPlayer("AntiSpam: Vehicles Spawn | Created " .. (totalCreations or "Error") .. " vehicles.")
            end
        elseif entitytype == 3 and Config.AntiSpamProps then
            -- Anti Spam Props
            AC.Player:addCatche("props", 1)
            local totalCreations = AC.Player:getCache("props")

            if totalCreations > (Config.AntiSpamPropsLimit or 0) then
                AC.Player:banPlayer("AntiSpam: Props Spawn | Created " .. (totalCreations or "Error") .. " Props.")
            end
        end
    end)
end

RegisterNetEvent("", function()


end)