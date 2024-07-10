AddEventHandler('entityCreated', function(entity)
    if not DoesEntityExist(entity) then
        return
    end
    
    local id = NetworkGetEntityOwner(entity)
    local entID = NetworkGetNetworkIdFromEntity(entity)
    local entitytype = GetEntityType(entity)

    if entitytype == 1 then
        ---@diagnostic disable-next-line: cast-local-type
        entitytype = "ped"
    elseif entitytype == 2 then
        ---@diagnostic disable-next-line: cast-local-type
        entitytype = "vehicle"
    elseif entitytype == 3 then
        ---@diagnostic disable-next-line: cast-local-type
        entitytype = "object"
    end
    
    TriggerClientEvent("ac:cl:check:".. entitytype, id, entID)
end)