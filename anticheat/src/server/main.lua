AC = {}

AC.Players = {}
AC.System = {}

_print = print
function print(message)
    if not message or type(message) ~= "string" then
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
        permissions = playerPermissions
    }
    print("^7PlayerJoined - Source: ^5" .. source .. " ^7- Name: ^5" .. GetPlayerName(source) .. "^7")
    TriggerClientEvent("ac:cl:playerJoined", source, playerPermissions)
end)

RegisterNetEvent("playerDropped", function(reason)
    if AC.Players[source] then
        AC.Players[source] = nil -- Remove player from table ( Memory management )
    end
    print("^7PlayerDropped - Source: ^5" .. source .. " ^7- Name: ^5" .. GetPlayerName(source) .. " ^7- Reason: ^5" .. reason .. "^7")
end)

-- [//[ Functions ]\\] --
function AC.Players:getPermissions(source)
    if not GetPlayerName(source) then
        return {}
    end

    local playerGroup = "user"
    for _, Identifier in ipairs(GetPlayerIdentifiers(source)) do
        for admins, group in pairs(Config.Admins) do
            if Identifier == admins then
                playerGroup = group
                break
            end
        end 
    end

    if not Config.Groups[playerGroup] then
        return {}
    end

    return Config.Groups[playerGroup]
end

function AC.Players:checkPermission(source, permission)
    if AC.Players[source] then
        if AC.Players[source].permissions[permission] then
            return true
        end
    end
    return false
end

---@diagnostic disable-next-line: duplicate-set-field
function AC.System:ExportHandler(exportName, exportFunc)
    AddEventHandler(('__cfx_export_anticheat_%s'):format(exportName), function(setCB)
        setCB(exportFunc)
    end)
end

local RegisteredCommands = {}
function AC.System:RegisterCommand(command, callback, perms, consoleOnly)
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

-- [//[ Commands ]\\] --
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

AC.System:RegisterCommand("install", function(source, args)
    if args[2] == "confirm" then
        Installer()
    else
        print("Please use ^3ac install confirm ^0to install all resources!")
    end
end, "console", true)

AC.System:RegisterCommand("uninstall", function(source, args)
    if args[2] == "confirm" then
        Uninstaller()
    else
        print("Please use ^3ac uninstall confirm ^0to uninstall all resources!")
    end
end, "console", true)

AC.System:RegisterCommand("help", function(source, args)
    print("^3-----------------------------[[ ^5Anticheat Help ^3]]-----------------------------^0")
    print("ac install confirm - Install all resources")
    print("ac uninstall confirm - Uninstall all resources")
    print("ac setadmin [ID] [GROUP] - Add a player as admin (user = reset)")
    print("ac removeadmin [ID or Identifier] - Remove a player from admin group")
    print("ac unban [BANID] - Unban a player")
    print("ac baninfo [BANID] - Get information about a ban")
    print("^3-------------------------------------------------------------------------------^0")
end, "console", true)