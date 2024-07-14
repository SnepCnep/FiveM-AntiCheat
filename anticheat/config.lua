Config = {}

-- [[ Injection ]] --
Config.AntiOldESX = true


-- [[ Protection ]] --
Config.AntiServerEvents = true

-- [[ Anti Spawn ]] --
Config.AntiWeaponSpawn = true
Config.AntiWeaponSpawnInstaBan = true -- Ban on try to spawn weapon (it takes a little bit more ms)

Config.AntiPedsSpawn = true
Config.AntiPropsSpawn = true
Config.AntiVehiclesSpawn = true


-- [[ Misc ]] --
Config.AntiGodmode = true
Config.AntiSpectate = true
Config.AntiInvisibility = true
Config.AntiNuiDevtools = true
Config.AntiTazer = true


-- [[ Permissions ]] --
Config.Groups = {
    ["management"] = {
        ["immune"] = true
    },
    ["admin"] = {
        ["godmode"] = true,
        ["spectate"] = true
    },
    ["mod"] = {
        ["godmode"] = true,
        ["spectate"] = true
    },
    ["testGroup"] = {
        ["immune"] = true,
        ["godmode"] = true,
        ["spectate"] = true,
        ["noclip"] = true
    }
}

Config.Admins = {
    -- Example: ["discord:630029784302485524"] = "admin"
}
