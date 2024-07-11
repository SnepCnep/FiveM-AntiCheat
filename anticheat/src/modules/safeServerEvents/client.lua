local TriggeredServerEvents = {}

function SafeServerTrigger(eventName)
    if not TriggeredServerEvents[eventName] then
        TriggeredServerEvents[eventName] = 0
    end

    TriggeredServerEvents[eventName] += 1
end

AC.System:ExportHandler("TriggerServerEvent", SafeServerTrigger)

if Config.AntiServerEvents then
    RegisterNetEvent("ac:cl:check:serverEvent", function(eventName, resource)
        if not TriggeredServerEvents[eventName] then
            AC.Player:banPlayer({
                reason = "Try to trigger a event!",
                event = eventName,
                resource = resource
            })
            return
        elseif TriggeredServerEvents[eventName] <= 0 then
            AC.Player:banPlayer({
                reason = "Try to trigger a event!",
                event = eventName,
                resource = resource
            })
            return
        end

        TriggeredServerEvents[eventName] -= 1
    end)
end