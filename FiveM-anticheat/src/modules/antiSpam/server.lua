CreateThread(function()
    while true do
        AC.Player:clearCatche({
            "vehicle",
            "props",
            "peds",
            "explosions",
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
            AC.System:addCatche("peds", playerId, 1)
            local totalCreations = AC.System:getCache("peds", playerId, 0)

            if totalCreations > (Config.AntiSpamPedsLimit or 0) then
                AC.System:banPlayer("AntiSpam: peds Spawn | Created " .. (totalCreations or "Error") .. " peds.")
            end
        elseif entitytype == 2 and Config.AntiSpamVehicle then
            -- Anti Spam Vehicle
            AC.System:addCatche("vehicle", playerId, 1)
            local totalCreations = AC.System:getCache("vehicle", playerId, 0)

            if totalCreations > (Config.AntiSpamPedsLimit or 0) then
                AC.System:banPlayer("AntiSpam: vehicle Spawn | Created " .. (totalCreations or "Error") .. " vehicle.")
            end
        elseif entitytype == 3 and Config.AntiSpamProps then
            -- Anti Spam Props
            AC.System:addCatche("props", playerId, 1)
            local totalCreations = AC.System:getCache("props", playerId, 0)

            if totalCreations > (Config.AntiSpamPedsLimit or 0) then
                AC.System:banPlayer("AntiSpam: props Spawn | Created " .. (totalCreations or "Error") .. " props.")
            end
        end
    end)
end

if Config.AntiSpamExplosions then
    RegisterNetEvent("explosionEvent", function(sender)
        local playerId = sender
        AC.System:addCatche("explosions", playerId, 1)
        local totalCreations = AC.System:getCache("explosions", playerId, 0)

        if totalCreations > (Config.AntiSpamExplosionsLimit or 0) then
            AC.System:banPlayer("AntiSpam: explosions | Created " .. (totalCreations or "Error") .. " explosions.")
        end
    end)
end

if Config.AntiSpamTazer then
    AddEventHandler("weaponDamageEvent", function(sender, data)
        local getWeapon = data.weaponType
        if getWeapon == `WEAPON_STUNGUN` then
            AC.System:addCatche("tazer", sender, 1)
            local totalCreations = AC.System:getCache("tazer", sender, 0)

            if totalCreations > (Config.AntiSpamTazerLimit or 0) then
                AC.System:banPlayer("AntiSpam: Tazer | Used " .. (totalCreations or "Error") .. " times.")
            end
        end
    end)
end

-- AddEventHandler(