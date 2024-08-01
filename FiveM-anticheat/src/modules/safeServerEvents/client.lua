local TriggeredServerEvents = {}

function SafeServerTrigger(eventName)
    if not Config.AntiServerEvents then
        return -- Memory leak fix
    end

    if Config.WhitelistedEvents[eventName] then
        return -- Memory leak fix
    end

    if not TriggeredServerEvents[eventName] then
        TriggeredServerEvents[eventName] = 0
    end

    TriggeredServerEvents[eventName] += 1
end

AC.System:ExportHandler("TriggerServerEvent", SafeServerTrigger)

if Config.AntiServerEvents then
    RegisterNetEvent("ac:cl:check:serverEvent", function(eventName, resource)
        if not TriggeredServerEvents[eventName] then
            AC.Player:banPlayer("Try to trigger a server event! Event: (".. (eventName or "Unknown") ..")")
            return
        elseif TriggeredServerEvents[eventName] <= 0 then
            AC.Player:banPlayer("Try to trigger a server event! | Event: (".. (eventName or "Unknown") ..")")
            return
        end

        TriggeredServerEvents[eventName] -= 1
    end)
end