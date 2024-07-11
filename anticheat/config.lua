Config = {}

-- [[ Injection ]] --
Config.AntiOldESX = true


-- [[ Protection ]] --
Config.AntiServerEvents = true

-- [[ Anti Spawn ]] --
Config.AntiWeaponSpawn = true
Config.AntiPedsSpawn = true
Config.AntiPropsSpawn = true
Config.AntiVehiclesSpawn = true

-- [[ Misc ]] --
Config.AntiGodmode = true
Config.AntiSpactate = true

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
    }
}

