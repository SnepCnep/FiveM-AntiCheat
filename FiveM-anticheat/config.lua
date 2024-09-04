Config = {}
Config.Debugger = true -- [[ ~This disable the ban and kick system, only for debug purposes~ ]] --
Config.CheckForUpdates = true
Config.LongLoadTime = 5 -- [[ In seconds ]] --

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

Config.AntiBackdoor = true -- Only blockt http & https backdoors
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
Config.AntiSpamVehicle = true
Config.AntiSpamVehicleLimit = 10
Config.AntiSpamProps = true
Config.AntiSpamPropsLimit = 10
Config.AntiSpamPeds = true
Config.AntiSpamPedsLimit = 10
Config.AntiSpamTazer = true
Config.AntiSpamTazerLimit = 10
Config.AntiSpamExplosions = true
Config.AntiSpamExplosionsLimit = 10

-- Soon
Config.AntiSpamParticles = true
Config.AntiSpamTazer = true



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
Config.AntiRagdoll = true
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
    unban
    baninfo

]]
--[[
    ## ACE Permission Example:

    add_ace group.admin "anticheat.immune" allow

]]
