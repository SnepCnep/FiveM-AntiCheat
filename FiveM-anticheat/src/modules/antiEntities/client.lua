-- [//[ Anti Peds Spawn ]\\] --
local CreatedPeds = {}

function SafeCreatePed(ped)
    CreatedPeds[ped] = true
end

AC.System:ExportHandler("CreatePed", SafeCreatePed)

if Config.AntiPedsSpawn then
    RegisterNetEvent("ac:cl:check:ped", function(entID)
        local ped = NetToPed(entID)
        local resource = GetEntityScript(ped)

        if not CreatedPeds[ped] and resource ~= nil then
            DeleteEntity(ped)
            AC.Player:banPlayer("Try to spawn a ped using a executer! | Resource: " .. resource)
        elseif not CreatedPeds[ped] then
            if IsEntityAttachedToEntity(ped, GetPlayerPed(-1)) then
                DeleteEntity(ped)
            end
        elseif CreatedPeds[ped] then
            CreatedPeds[ped] = nil
        end
    end)
end

-- [//[ Anti Props Spawn ]\\] --
local CreatedObjects = {}

function SafeCreateObject(object)
    CreatedObjects[object] = true
end

AC.System:ExportHandler("CreateObject", SafeCreateObject)

if Config.AntiPropsSpawn then
    RegisterNetEvent("ac:cl:check:object", function(entID)
        local object = NetToObj(entID)
        local resource = GetEntityScript(object)
        local model = GetEntityModel(object)

        if model == 1760825203 then -- Bob74_ipl ( Idk why but this model is always spawned when you join the server if you use bob ipl )
            return
        end

        if not CreatedObjects[object] and resource ~= nil then
            DeleteEntity(object)
            AC.Player:banPlayer("Try to spawn a object using a executer! | Resource: " .. resource)
        elseif not CreatedObjects[object] then
            if IsEntityAttachedToEntity(object, GetPlayerPed(-1)) then
                DeleteEntity(object)
            end
        elseif CreatedObjects[object] then
            CreatedObjects[object] = nil
        end
    end)
end

-- [//[ Anti Vehicles Spawn ]\\] --
local CreatedVehicles = {}

function SafeCreateVehicle(vehicle)
    CreatedVehicles[vehicle] = true
end

AC.System:ExportHandler("CreateVehicle", SafeCreateVehicle)

if Config.AntiVehiclesSpawn then
    RegisterNetEvent("ac:cl:check:vehicle", function(entID)
        local vehicle = NetToVeh(entID)
        local resource = GetEntityScript(vehicle)

        if not CreatedVehicles[vehicle] and resource ~= nil then
            DeleteEntity(vehicle)
            AC.Player:banPlayer("Try to spawn a vehicle using a executer! | Resource: " .. resource)
        elseif not resource and not CreatedVehicles[vehicle] and IsVehiclePreviouslyOwnedByPlayer(vehicle) then
            DeleteEntity(vehicle)
            AC.Player:banPlayer("Try to spawn a vehicle using a executer! | Resource: " .. resource)
        elseif CreatedVehicles[vehicle] then
            CreatedVehicles[vehicle] = nil
        end
    end)
end