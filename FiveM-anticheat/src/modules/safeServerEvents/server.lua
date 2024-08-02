local isEventProtected = {}

function RegisterSafeServer(resource, eventName)
    if not Config.AntiServerEvents then
        return
    end

    if Config.WhitelistedEvents[eventName] then
        return
    end

    if isEventProtected[eventName] then
        return
    end
    isEventProtected[eventName] = true


    RegisterNetEvent(eventName, function()
        local src = GetInvokingResource()

        if src ~= nil then
            return
        end

        if not source or source == 0 then
            return
        end

        TriggerClientEvent("ac:cl:check:serverEvent", source, eventName, (resource or "unkown"))
    end)
end

AC.System:ExportHandler("RegisterServerEvent", RegisterSafeServer)