local isEventProtected = {}

function RegisterSafeServer(resource, eventName)
    if isEventProtected[eventName] then
        return
    end

    isEventProtected[eventName] = true


    RegisterNetEvent(eventName, function()
        if not source or source == 0 then
            return
        end

        TriggerClientEvent("ac:cl:checkServerEvent", source, eventName, (resource or "unkown"))
    end)
end

AC.System:ExportHandler("RegisterServerEvent", RegisterSafeServer)