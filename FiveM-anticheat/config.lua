Config = {}
Config.Debugger = true -- [[ ~This disable the ban and kick system, only for debug purposes~ ]]
Config.CheckForUpdates = true

-- [[ Injection ]] --
Config.AntiOldESX = true

-- [[ Protection ]] --
Config.AntiServerEvents = true
Config.AntiBackdoor = true -- Only blockt http backdoors
Config.HttpFilter = true
Config.AllowedUrls = {
    [""] = true
}
-- [[ Anti Spawn ]] --
Config.AntiWeaponSpawn = true
Config.AntiWeaponSpawnInstaBan = true -- Ban on try to spawn weapon (it takes a little bit more ms)

Config.AntiPedsSpawn = true
Config.AntiPropsSpawn = true
Config.AntiVehiclesSpawn = true

-- [[ Misc ]] --
Config.AntiGodmode = true
Config.AntiSpectate = true
Config.AntiInvisibility = true -- not implemented yet
Config.AntiNuiDevtools = true -- not implemented yet
Config.AntiTazer = true
Config.AntiFreecam = true
Config.AntiVPN = true
Config.AntiWeaponExplosion = true

-- [[ Permissions ]] --
--[[
    ## All permissions:

    immune
    godmode
    spectate
    noclip
    invisible
    freecam

]]
--[[
    ## ACE Permission Example:

    add_ace group.admin "anticheat.immune" allow

]]
