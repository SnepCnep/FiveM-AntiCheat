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

        local playerId = NetworkGetEntityOwner(entity)
        local entitytype = GetEntityType(entity)

        if entitytype == 1 and Config.AntiSpamPeds then
            -- Anti Spam Peds
            AC.Players:addCatche("peds", playerId, 1)
            local totalCreations = AC.Players:getCache("peds", playerId, 0)
            
            if totalCreations > (Config.AntiSpamPedsLimit or 0) then
                AC.Players:banPlayer("AntiSpam: peds Spawn | Created " .. (totalCreations or "Error") .. " peds.")
            end

        elseif entitytype == 2 and Config.AntiSpamVehicle then
            -- Anti Spam Vehicle
            AC.Players:addCatche("vehicle", playerId, 1)
            local totalCreations = AC.Players:getCache("vehicle", playerId, 0)
            
            if totalCreations > (Config.AntiSpamPedsLimit or 0) then
                AC.Players:banPlayer("AntiSpam: vehicle Spawn | Created " .. (totalCreations or "Error") .. " vehicle.")
            end

        elseif entitytype == 3 and Config.AntiSpamProps then
            -- Anti Spam Props
            AC.Players:addCatche("props", playerId, 1)
            local totalCreations = AC.Players:getCache("props", playerId, 0)
            
            if totalCreations > (Config.AntiSpamPedsLimit or 0) then
                AC.Players:banPlayer("AntiSpam: props Spawn | Created " .. (totalCreations or "Error") .. " props.")
            end
            
        end
    end)
end

RegisterNetEvent("", function()


end)