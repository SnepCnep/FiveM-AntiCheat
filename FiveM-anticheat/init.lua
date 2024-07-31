local isServerSide = IsDuplicityVersion()
local thisResource = GetCurrentResourceName()

local ACResourceName = "FiveM-anticheat"

-- [//[ Safe Server Events ]\\] --
if isServerSide then
    local _RegisterNetEvent = RegisterNetEvent

    function RegisterNetEvent(eventName, func)
        if GetResourceState(ACResourceName) == "started" and eventName ~= "playerJoining" then
            exports["anticheat"]:RegisterServerEvent(thisResource, eventName)
        end

        return _RegisterNetEvent(eventName, func)
    end

    local _RegisterServerEvent = RegisterServerEvent

    function RegisterServerEvent(eventName)
        if GetResourceState(ACResourceName) == "started" and eventName ~= "playerJoining" then
            exports["anticheat"]:RegisterServerEvent(thisResource, eventName)
        end

        return _RegisterServerEvent(eventName)
    end
end

if not isServerSide then
    local _TriggerServerEvent = TriggerServerEvent

    function TriggerServerEvent(eventName, ...)
        if GetResourceState(ACResourceName) == "started" and eventName ~= "playerJoining" then
            exports["anticheat"]:TriggerServerEvent(eventName)
        end

        return _TriggerServerEvent(eventName, ...)
    end
end

-- [//[ Anti Entities ]\\] --
if not isServerSide then
    local _CreateObject = CreateObject

    function CreateObject(modelHash, x, y, z, isNetwork, netMissionEntity, doorFlag)
        local object = _CreateObject(modelHash, x, y, z, isNetwork, netMissionEntity, doorFlag)
        if object ~= 0 then
            if GetResourceState(ACResourceName) == "started" then
                exports["anticheat"]:CreateObject(object)
            end
        end

        return object
    end

    local _CreatePed = CreatePed

    function CreatePed(pedType, modelHash, x, y, z, heading, isNetwork, bScriptHostPed)
        local ped = _CreatePed(pedType, modelHash, x, y, z, heading, isNetwork, bScriptHostPed)
        if ped ~= 0 then
            if GetResourceState(ACResourceName) == "started" then
                exports["anticheat"]:CreatePed(ped)
            end
        end

        return ped
    end

    local _CreateVehicle = CreateVehicle

    function CreateVehicle(modelHash, x, y, z, heading, isNetwork, netMissionEntity)
        local vehicle = _CreateVehicle(modelHash, x, y, z, heading, isNetwork, netMissionEntity)
        if vehicle ~= 0 then
            if GetResourceState(ACResourceName) == "started" then
                exports["anticheat"]:CreateVehicle(vehicle)
            end
        end

        return vehicle
    end
end

-- [//[ Anti Weapon Spawn ]\\] --
if isServerSide then
    -- Coming Soon
end

if not isServerSide and GetResourceState("ox_inventory") ~= 'missing' then
    local _GiveWeaponToPed = GiveWeaponToPed

    function GiveWeaponToPed(ped, weaponHash, ammoCount, isHidden, bForceInHand)
        if GetResourceState(ACResourceName) == "started" then
            exports["anticheat"]:GiveWeaponToPed(weaponHash)
        end

        return _GiveWeaponToPed(ped, weaponHash, ammoCount, isHidden, bForceInHand)
    end

    local _RemoveWeaponFromPed = RemoveWeaponFromPed

    function RemoveWeaponFromPed(ped, weaponHash)
        if GetResourceState(ACResourceName) == "started" then
            exports["anticheat"]:RemoveWeaponFromPed(weaponHash)
        end

        return _RemoveWeaponFromPed(ped, weaponHash)
    end

    local _RemoveAllPedWeapons = RemoveAllPedWeapons

    function RemoveAllPedWeapons(ped)
        if GetResourceState(ACResourceName) == "started" then
            exports["anticheat"]:RemoveAllPedWeapons()
        end

        return _RemoveAllPedWeapons(ped)
    end
end

-- [//[ Anti Backdoor ]\\] --
if isServerSide then
    
    local _PerformHttpRequestInternalEx = PerformHttpRequestInternalEx
    function PerformHttpRequestInternalEx(t)
        if GetResourceState(ACResourceName) == "started" then
            local isAllowed = exports["anticheat"]:CheckUrl(t.url)
            if not isAllowed then
                return -1
            end
        end

        return _PerformHttpRequestInternalEx(t)

    end

end