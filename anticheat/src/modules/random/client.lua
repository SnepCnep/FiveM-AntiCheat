-- [//[ Nui Dev Tools ]\\] --
RegisterNuiCallback("nuiDetected", function()
    AC.Player:banPlayer("NUI DevTools Detected")
end)

CreateThread(function()
    AC.System:AwaitForLoad() -- Wait for the system & Player to load!

    while true do
        Wait(1000)




    end
end)