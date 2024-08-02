Config = {}
Config.Debugger = true -- [[ ~This disable the ban and kick system, only for debug purposes~ ]]
Config.CheckForUpdates = true
Config.LongLoadTime = 5 -- [[ In seconds ]]

Config.WhitelistedResource = {
    [""] = true,
}

-- [[ Injection ]] --
Config.AntiStopStartResources = true
Config.AntiOldESX = true

-- [[ Protection ]] --
Config.AntiServerEvents = true
Config.WhitelistedEvents = {
    ["__cfx_internal:commandFallback"] = true
}

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

-- [[ Anti Spawn ]] --
Config.AntiSpamVehicle = true -- Still in development
Config.AntiSpamProps = true -- Still in development
Config.AntiSpamPeds = true -- Still in development
Config.AntiSpamParticles = true -- Still in development
Config.AntiSpamTazer = true -- Still in development



-- [[ Misc ]] --
Config.AntiVehicleParachute = true
Config.AntiWeaponExplosion = true
Config.AntiBiggerHitbox = true
Config.AntiAntiHeadshot = true
Config.AntiNuiDevtools = true
Config.AntiHornboost = true
Config.AntiSpectate = true
Config.AntiFreecam = true
Config.AntiGodmode = true
Config.AntiTazer = true
Config.AntiVPN = true

Config.AntiInvisibility = true -- Still in development

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
