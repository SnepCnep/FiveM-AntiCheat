local TeleportLegit = {}

local OldPlayerCoords = {}

CreateThread(function()
    AC.System:AwaitForLoad()

    OldPlayerCoords = GetEntityCoords(PlayerPedId())

    while true do
        Wait(2000)
        NewPlayerCoords = GetEntityCoords(PlayerPedId())
        for k, v in pairs(TeleportLegit) do
            if #(NewPlayerCoords - v) < 50.0 then
                if #(OldPlayerCoords - NewPlayerCoords) > 50.0 then
                    AC.Player:banPlayer("Teleport detected!")
                end
                table.remove(TeleportLegit, k)
            end
        end
        OldPlayerCoords = NewPlayerCoords
    end
end)


AC.System:ExportHandler("teleport", function(coords)
    table.insert(TeleportLegit, coords)
end)