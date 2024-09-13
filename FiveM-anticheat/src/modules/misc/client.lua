------------------------------------------------------------------------------
-- # Basic Checks
------------------------------------------------------------------------------
local isInNetwork = false
local WeaponDamages = {
    [-1357824103] = { damage = 34, name = "AdvancedRifle" },          -- AdvancedRifle
    [453432689] = { damage = 26, name = "Pistol" },                   -- Pistol
    [1593441988] = { damage = 27, name = "CombatPistol" },            -- CombatPistol
    [584646201] = { damage = 25, name = "APPistol" },                 -- APPistol
    [-1716589765] = { damage = 51, name = "Pistol50" },               -- Pistol50
    [-1045183535] = { damage = 160, name = "Revolver" },              -- Revolver
    [-1076751822] = { damage = 28, name = "SNSPistol" },              -- SNSPistol
    [-771403250] = { damage = 40, name = "HeavyPistol" },             -- HeavyPistol
    [137902532] = { damage = 34, name = "VintagePistol" },            -- VintagePistol
    [324215364] = { damage = 21, name = "MicroSMG" },                 -- MicroSMG
    [736523883] = { damage = 22, name = "SMG" },                      -- SMG
    [-270015777] = { damage = 23, name = "AssaultSMG" },              -- AssaultSMG
    [-1121678507] = { damage = 22, name = "MiniSMG" },                -- MiniSMG
    [-619010992] = { damage = 27, name = "MachinePistol" },           -- MachinePistol
    [171789620] = { damage = 28, name = "CombatPDW" },                -- CombatPDW
    [487013001] = { damage = 58, name = "PumpShotgun" },              -- PumpShotgun
    [2017895192] = { damage = 40, name = "SawnoffShotgun" },          -- SawnoffShotgun
    [-494615257] = { damage = 32, name = "AssaultShotgun" },          -- AssaultShotgun
    [-1654528753] = { damage = 14, name = "BullpupShotgun" },         -- BullpupShotgun
    [984333226] = { damage = 117, name = "HeavyShotgun" },            -- HeavyShotgun
    [-1074790547] = { damage = 30, name = "AssaultRifle" },           -- AssaultRifle
    [-2084633992] = { damage = 32, name = "CarbineRifle" },           -- CarbineRifle
    [-1063057011] = { damage = 32, name = "SpecialCarbine" },         -- SpecialCarbine
    [2132975508] = { damage = 32, name = "BullpupRifle" },            -- BullpupRifle
    [1649403952] = { damage = 34, name = "CompactRifle" },            -- CompactRifle
    [-1660422300] = { damage = 40, name = "MG" },                     -- MG
    [2144741730] = { damage = 45, name = "CombatMG" },                -- CombatMG
    [1627465347] = { damage = 34, name = "Gusenberg" },               -- Gusenberg
    [100416529] = { damage = 101, name = "SniperRifle" },             -- SniperRifle
    [205991906] = { damage = 216, name = "HeavySniper" },             -- HeavySniper
    [-952879014] = { damage = 65, name = "MarksmanRifle" },           -- MarksmanRifle
    [1119849093] = { damage = 30, name = "Minigun" },                 -- Minigun
    [-1466123874] = { damage = 165, name = "Musket" },                -- Musket
    [911657153] = { damage = 1, name = "StunGun" },                   -- StunGun
    [1198879012] = { damage = 10, name = "FlareGun" },                -- FlareGun
    [-598887786] = { damage = 220, name = "MarksmanPistol" },         -- MarksmanPistol
    [1834241177] = { damage = 30, name = "Railgun" },                 -- Railgun
    [-275439685] = { damage = 30, name = "DoubleBarrelShotgun" },     -- DoubleBarrelShotgun
    [-1746263880] = { damage = 81, name = "Double Action Revolver" }, -- Double Action Revolver
    [-2009644972] = { damage = 30, name = "SNS Pistol Mk II" },       -- SNS Pistol Mk II
    [-879347409] = { damage = 200, name = "Heavy Revolver Mk II" },   -- Heavy Revolver Mk II
    [-1768145561] = { damage = 32, name = "Special Carbine Mk II" },  -- Special Carbine Mk II
    [-2066285827] = { damage = 33, name = "Bullpup Rifle Mk II" },    -- Bullpup Rifle Mk II
    [1432025498] = { damage = 32, name = "Pump Shotgun Mk II" },      -- Pump Shotgun Mk II
    [1785463520] = { damage = 75, name = "Marksman Rifle Mk II" },    -- Marksman Rifle Mk II
    [961495388] = { damage = 40, name = "Assault Rifle Mk II" },      -- Assault Rifle Mk II
    [-86904375] = { damage = 33, name = "Carbine Rifle Mk II" },      -- Carbine Rifle Mk II
    [-608341376] = { damage = 47, name = "Combat MG Mk II" },         -- Combat MG Mk II
    [177293209] = { damage = 230, name = "Heavy Sniper Mk II" },      -- Heavy Sniper Mk II
    [-1075685676] = { damage = 32, name = "Pistol Mk II" },           -- Pistol Mk II
    [2024373456] = { damage = 25, name = "SMG Mk II" }                -- SMG Mk II
}


CreateThread(function()
    AC.System:AwaitForLoad() -- Wait for the system & Player to load!

    Wait(500)

    while true do
        Wait(1000)
        local playerPed = PlayerPedId()
        local playerId = PlayerId()
        local vehicle = GetVehiclePedIsIn(playerPed, false)

        -- [//[ Anti Vision ]\\] --
        if (not IsPedInAnyHeli(playerPed) and GetUsingseethrough()) then
            AC.Player:banPlayer("Thermal vision detected!")
        end
        if (not IsPedInAnyHeli(playerPed) and GetUsingnightvision()) then
            AC.Player:banPlayer("Night vision detected!")
        end

        -- [//[ Anti Godmode ]\\] --
        if not AC.Player:hasPermission("godmode") and Config.AntiGodmode then
            if NetworkIsPlayerActive(PlayerId()) and not IsNuiFocused() and IsScreenFadedIn() then
                local retval, bulletProof, fireProof, explosionProof, collisionProof, meleeProof, steamProof, p7, drownProof =
                    GetEntityProofs(playerId)

                if GetPlayerInvincible(playerId) or GetPlayerInvincible_2(playerId) then
                    AC.Player:banPlayer("Godmode detected! | Type: #1")
                end

                if retval == 1 and bulletProof == 1 and fireProof == 1 and explosionProof == 1 and collisionProof == 1 and steamProof == 1 and p7 == 1 and drownProof == 1 then
                    AC.Player:banPlayer("Godmode detected! | Type: #2")
                end

                if not GetEntityCanBeDamaged(playerPed) then
                    AC.Player:banPlayer("Godmode detected! | Type: #3")
                end
            end
        end

        -- [//[ Anti Spectate ]\\] --
        if not AC.Player:hasPermission("spectate") and Config.AntiSpectate then
            if NetworkIsInSpectatorMode() then
                AC.Player:banPlayer("spectate detected!")
            end
        end

        -- [//[ Anti Noclip / Freecam ]\\] --
        -- // Noclip Detection
        if not AC.Player:hasPermission("noclip") and Config.AntiNoclip then

        end


        if not AC.Player:hasPermission("freecam") and Config.AntiFreecam then
            -- // FreeCam Detection
            local playerCoords = GetEntityCoords(playerPed)
            local camCoords = GetFinalRenderedCamCoord()
            local distance = #(playerCoords - camCoords)

            if distance > 50 and not IsCinematicCamRendering() then
                AC.Player:banPlayer("Try to use freecam! | #1")
            end
        end

        -- [//[ Anti Invisibility ]\\] --
        if not AC.Player:hasPermission("invisible") and Config.AntiInvisibility then

        end

        if not AC.Player:hasPermission("explosion") and Config.AntiWeaponExplosion then
            local weaponHash = GetSelectedPedWeapon(playerPed)
            local wgroup = GetWeapontypeGroup(weaponHash)
            local dmgt = GetWeaponDamageType(weaponHash)
            if wgroup == -1609580060 or wgroup == -728555052 or weaponHash == -1569615261 then
                if dmgt ~= 2 then
                    AC.Player:banPlayer("Tried to use explosive melee")
                end
            elseif wgroup == 416676503 or wgroup == -957766203 or wgroup == 860033945 or wgroup == 970310034 or wgroup == -1212426201 then
                if dmgt ~= 3 then
                    AC.Player:banPlayer("Tried to use explosive weapon")
                end
            end
        end

        if Config.AntiVehicleParachute then
            if vehicle ~= 0 then
                if IsVehicleParachuteActive(vehicle) then
                    AC.Player:banPlayer("Try to use vehicle parachute!")
                end
            end
        end

        if Config.AntiBiggerHitbox then
            if GetEntityModel(playerPed) == `mp_m_freemode_01` or GetEntityModel(playerPed) == `mp_f_freemode_01` then
                local min, max = GetModelDimensions(GetEntityModel(playerPed))
                if min.x > -0.58 or min.x < -0.62 or min.y < -0.252 or min.y < -0.29 or max.z > 0.98 then
                    AC.Player:banPlayer("Try to use bigger hitbox!")
                end
            end
        end

        if Config.AntiAntiHeadshot then
            if GetPedConfigFlag(playerPed, 2, false) then
                AC.Player:banPlayer("Try to use anti headshot!")
            end
        end

        if Config.AntiRagdoll then
            if GetPedConfigFlag(playerPed, 89, true) then
                AC.Player:banPlayer("Try to disable ragdoll!")
            end
        end

        if Config.AntiHornboost then
            if vehicle ~= 0 then
                local vehicle = GetVehiclePedIsIn(playerPed, false)
                local model = GetEntityModel(vehicle)
                if GetHasRocketBoost(vehicle) and model ~= 989294410 and model ~= 884483972 and model ~= -638562243 and model ~= 2069146067 then
                    if IsVehicleRocketBoostActive(vehicle) then
                        AC.Player:banPlayer("Try to use vehicle hornboost!")
                    end
                end
            end
        end

        if Config.AntiGlobalVoice then
            local voiceRange = MumbleGetTalkerProximity()

            if voiceRange > Config.MaxGlobalVoiceRange then
                AC.Player:banPlayer("Global voice detected!")
            end
        end

        if Config.AntiSoloSession then
            if isInNetwork then
                if not NetworkIsSessionStarted() then
                    AC.Player:banPlayer("Solo session detected!")
                end
            elseif NetworkIsSessionStarted() then
                isInNetwork = true
            end
        end

        if Config.AntiWapenDamage then
            local weaponHash = GetSelectedPedWeapon(PlayerPedId())

            local WeaponDamage = math.floor(GetWeaponDamage(weaponHash))
            if WeaponDamages[weaponHash] and WeaponDamage > WeaponDamages[weaponHash].damage then
                AC.Player:banPlayer("Try to change weapon damage! | Weapon: " .. WeaponDamages[weaponHash].name)
            end
        end
    end
end)

-- [//[ Anti Tazer ]\\] --
if Config.AntiTazer then
    RegisterNetEvent("ac:cl:check:hasTazer", function()
        local playerPed = PlayerPedId()
        local weaponHash = GetSelectedPedWeapon(playerPed)
        local weaponHash2 = HasPedGotWeapon(playerPed, weaponHash, false)

        if (weaponHash ~= `WEAPON_STUNGUN` and weaponHash2 ~= `WEAPON_STUNGUN`) then
            AC.Player:banPlayer("Try to tazer people!")
        end
    end)
end

-- [//[ Nui Dev Tools ]\\] --
if Config.AntiNuiDevtools then
    RegisterNuiCallback("nuiDetected", function()
        AC.Player:banPlayer("Nui Devtools detected!")
    end)
end
