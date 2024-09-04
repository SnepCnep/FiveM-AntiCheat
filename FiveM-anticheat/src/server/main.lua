AC = {}

AC.Players = {}
AC.System = {}

---@diagnostic disable-next-line: lowercase-global
_print = print
function print(message)
    if not message or type(message) ~= "string" then
        _print("^7[^5ANTICHEAT^7] ^4- ^7Invalid message^7")
        return
    end
    _print("^7[^5ANTICHEAT^7] ^4- ^7" .. message .. "^7")
end

-- [//[ Events ]\\] --
RegisterNetEvent("ac:sv:playerJoined", function()
    if AC.Players[source] then
        return
    end

    local playerPermissions = AC.Players:getPermissions(source)

    AC.Players[source] = {
        permissions = playerPermissions,
        name = (GetPlayerName(source) or "Unknown")
    }
    print("^2PlayerJoined^7 - Source: ^5" .. source .. " ^7- Name: ^5" .. GetPlayerName(source) .. "^7")
    TriggerClientEvent("ac:cl:playerJoined", source, playerPermissions)
end)

RegisterNetEvent("playerDropped", function(reason)
    if AC.Players[source] then
        AC.Players[source] = nil -- Remove player from table ( Memory management )
        AC.System:ClearPlayerCatche(source) -- Clear player catches ( Memory management )
    end
    print("^2PlayerDropped^7 - Source: ^5" .. source .. " ^7- Name: ^5" .. GetPlayerName(source) .. " ^7- Reason: ^5" .. reason .. "^7")
end)

-- [//[ Functions ]\\] --
local permissions = {
    "immune",
    "godmode",
    "spectate",
    "noclip",
    "invisible",
    "freecam",
}

function AC.Players:getPermissions(source)
    while not GetPlayerName(source) do
        Wait(100)
    end

    if IsPlayerAceAllowed(source, "anticheat.immune") then
        return { immune = true }
    end

    local playerPermissions = {}
    for i = 1, #permissions do
        if IsPlayerAceAllowed(source, "anticheat." .. permissions[i]) then
            playerPermissions[permissions[i]] = true
        end
    end

    return playerPermissions
end

function AC.Players:checkPermission(source, permission)

    if AC.Players[source] then
        if AC.Players[source].permissions[permission] then
            return true
        end
    elseif IsPlayerAceAllowed(source, "anticheat." .. permission) then
        return true
    end

    return false
end

local catche = {}
function AC.System:setCache(name, source, data)
    if not catche[name] then
        catche[name] = {}
    end

    if source == false then
        catche[name] = data
        return
    end

    catche[name][source] = data
end

function AC.System:getCache(name, source, fallbackData)
    local fallback = fallbackData or false
    if not catche[name] then
        return fallback
    end

    if source == false then
        return catche[name] or fallback
    end

    return catche[name][source] or fallback
end

function AC.System:addCatche(name, source, data)
    if not catche[name] then
        catche[name] = {}
    end

    if type(data) == "number" then
        if not catche[name][source] or type(catche[name][source]) ~= "number" then
            catche[name][source] = 0
        end
        catche[name][source] = catche[name][source] + data
    else
        catche[name][source] = catche[name][source] or {}
        table.insert(catche[name][source], data)
    end
end

function AC.System:clearCatche(name, source)
    if type(name) == "table" then
        for i = 1, #name do
            catche[name[i]] = nil
        end
        return
    end

    if not catche[name] then
        return
    end

    if source == false then
        catche[name] = nil
        return
    end

    catche[name][source] = nil
end

function AC.System:ClearPlayerCatche(source)
    for k, v in pairs(catche) do
        if v[source] then
            catche[k][source] = nil
        end
    end
end

---@diagnostic disable-next-line: duplicate-set-field
function AC.System:ExportHandler(exportName, exportFunc)
    AddEventHandler(('__cfx_export_anticheat_%s'):format(exportName), function(setCB)
        setCB(exportFunc)
    end)
end

local RegisteredCommands = {}
function AC.System:RegisterCommand(command, callback, perms, consoleOnly)

    if perms then
        perms = "command.".. perms
    end
    if not command or not callback then
        return
    end
    if RegisteredCommands[command] then
        return
    end
    
    RegisteredCommands[command] = {
        perms = (perms or "console"), -- console means only console can use this command
        consoleOnly = (consoleOnly or true),
        callback = callback,
    }
end

RegisterCommand("ac", function(source, args)
    local command = RegisteredCommands[args[1]]
    if command then
        if source == 0 and (not command.consoleOnly or command.consoleOnly == true) then
            command.callback(source, args)
        elseif source ~= 0 and command.perms ~= "console" then
            if AC.Players:checkPermission(source, command.perms) then
                command.callback(source, args)
            else
                print("You don't have permission to use this command!")
            end
        else
            print("This command is only available for console!")
        end
    else
        print("This command doesn't exist!")
    end
end, false)

-- [//[ Commands ]\\] --

AC.System:RegisterCommand("help", function(source, args)
    print("^3-----------------------------[[ ^5Anticheat Help ^3]]-----------------------------^0")
    print("ac install confirm - Install all resources")
    print("ac uninstall confirm - Uninstall all resources")
    print("ac unban [BANID] - Unban a player")
    print("ac baninfo [BANID] - Get information about a ban")
    print("^3-------------------------------------------------------------------------------^0")
end, "console", true)