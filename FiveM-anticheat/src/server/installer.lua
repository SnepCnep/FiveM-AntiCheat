local function Installer()
    local currentResource = "@".. GetCurrentResourceName() .."/init.lua"
    local currentResourceMatch = currentResource:gsub("-", "%%-")
    local resourceCount = GetNumResources()
    local installcount = 0
    for i = 0, resourceCount - 1 do
        local resourceName = GetResourceByFindIndex(i)
        if resourceName ~= GetCurrentResourceName() and resourceName ~= "monitor" and not Config.WhitelistedResource[resourceName] then
            local resourcePath = GetResourcePath(resourceName)
            if resourcePath ~= nil then
                local fxmanifestFile = LoadResourceFile(resourceName, "fxmanifest.lua")
                if fxmanifestFile then
                    fxmanifestFile = tostring(fxmanifestFile)
                    local sharedScript = fxmanifestFile:match("shared_script '"..currentResourceMatch.."'\n")
                    if not sharedScript then
                        fxmanifestFile = "shared_script '".. currentResource .."'\n" .. fxmanifestFile
                        SaveResourceFile(resourceName, "fxmanifest.lua", fxmanifestFile, -1)
                        installcount = installcount + 1
                    end
                else 
                    local __resourceFile = LoadResourceFile(resourceName, "__resource.lua")
                    if __resourceFile then
                        __resourceFile = tostring(__resourceFile)
                        local sharedScript = __resourceFile:match("shared_script '"..currentResourceMatch.."'\n")
                        if not sharedScript then
                            __resourceFile = "shared_script '".. currentResource .."'\n" .. __resourceFile
                            SaveResourceFile(resourceName, "__resource.lua", __resourceFile, -1)
                            installcount = installcount + 1
                        end
                    end
                end
            end
        end
    end
    print("We have installed ^3".. installcount .." ^0resources!")
    print("Restart the server to apply the changes!")
end

local function Uninstaller()
    local currentResource = "@".. GetCurrentResourceName() .."/init.lua"
    local currentResourceMatch = currentResource:gsub("-", "%%-")
    local resourceCount = GetNumResources()
    local uninstallcount = 0
    for i = 0, resourceCount - 1 do
        local resourceName = GetResourceByFindIndex(i)
        if resourceName ~= GetCurrentResourceName() then
            local resourcePath = GetResourcePath(resourceName)
            if resourcePath ~= nil then
                local fxmanifestFile = LoadResourceFile(resourceName, "fxmanifest.lua")
                if fxmanifestFile then
                    fxmanifestFile = tostring(fxmanifestFile)
                    local sharedScript = fxmanifestFile:match("shared_script '"..currentResourceMatch.."'\n")
                    if sharedScript then
                        fxmanifestFile = fxmanifestFile:gsub("shared_script '"..currentResourceMatch.."'\n", "")
                        SaveResourceFile(resourceName, "fxmanifest.lua", fxmanifestFile, -1)
                        uninstallcount = uninstallcount + 1
                    end
                else 
                    local __resourceFile = LoadResourceFile(resourceName, "__resource.lua")
                    if __resourceFile then
                        __resourceFile = tostring(__resourceFile)
                        local sharedScript = __resourceFile:match("shared_script '"..currentResourceMatch.."'\n")
                        if sharedScript then
                            __resourceFile = __resourceFile:gsub("shared_script '"..currentResourceMatch.."'\n", "")
                            SaveResourceFile(resourceName, "__resource.lua", __resourceFile, -1)
                            uninstallcount = uninstallcount + 1
                        end
                    end
                end
            end
        end
    end
    print("We have uninstalled ^3".. uninstallcount .." ^0resources!")
    print("Restart the server to apply the changes!")
end

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