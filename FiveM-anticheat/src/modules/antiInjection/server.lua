-- [//[ Anti Stop / Start Resources ]\\] --
-- ## Geen idee waarom ik dit gemaakt heb :D | NEED TESTING

RegisterNetEvent("ac:sv:resourceStart", function(res)
    local res_state = GetResourceState(res)
    local res_path = GetResourcePath(res)
    if res_state ~= "started" then
        AC.Players:banPlayer(source, "Resource started without permission: " .. res)
    end
    if not res_path then
        AC.Players:banPlayer(source, "Could not found resource path: " .. res)
    end
end)

RegisterNetEvent("ac:sv:resourceStop", function(res)
    local res_state = GetResourceState(res)
    local res_path = GetResourcePath(res)
    if res_state ~= "stopped" and res_state ~= "started" then
        AC.Players:banPlayer(source, "Resource stopped without permission: " .. res)
    end
    if not res_path then
        AC.Players:banPlayer(source, "Could not found resource path: " .. res)
    end
end)

RegisterNetEvent("ac:sv:resourceStartClient", function(res)
    local res_state = GetResourceState(res)
    local res_path = GetResourcePath(res)
    if res_state ~= "started" then
        AC.Players:banPlayer(source, "Resource started (client) without permission: " .. res)
    end
    if not res_path then
        AC.Players:banPlayer(source, "Could not found resource path: " .. res)
    end
end)

RegisterNetEvent("ac:sv:resourceStopClient", function(res)
    local res_state = GetResourceState(res)
    local res_path = GetResourcePath(res)
    if res_state ~= "stopped" then
        AC.Players:banPlayer(source, "Resource stopped (client) without permission: " .. res)
    end
    if not res_path then
        AC.Players:banPlayer(source, "Could not found resource path: " .. res)
    end
end)