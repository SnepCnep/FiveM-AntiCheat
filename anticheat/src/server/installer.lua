-- [[ Commands ]] --
-- RegisterCommand("ac", function(source, args)
--     if source == 0 then
--         if args[1] == "install" then
--             if args[2] == "confirm" then
--                 Installer()
--             else
--                 print("Please use ^0ac install confirm ^5to install all resources!")
--             end
--         elseif args[1] == "uninstall" then
--             if args[2] == "confirm" then
--                 Uninstaller()
--             else
--                 print("Please use ^0ac uninstall confirm ^5to uninstall all resources!")
--             end
--         else
--             print("This command doesn't exist! ( ac install / ac uninstall )")
--         end
--     end
-- end, false)

-- [[ Installer & Uninstaller ]] --

function Installer()
    local currentResource = "@".. GetCurrentResourceName() .."/init.lua"
    local currentResourceMatch = currentResource:gsub("-", "%%-")
    local resourceCount = GetNumResources()
    local installcount = 0
    for i = 0, resourceCount - 1 do
        local resourceName = GetResourceByFindIndex(i)
        if resourceName ~= GetCurrentResourceName() and resourceName ~= "monitor" then
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

function Uninstaller()
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
    print("We have uninstalled ^3".. installcount .." ^0resources!")
    print("Restart the server to apply the changes!")
end