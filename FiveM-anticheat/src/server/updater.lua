-- [//[ Update Checker ]\\] --
local thisResource = GetCurrentResourceName()
local getCurrentVersion = GetResourceMetadata(thisResource, 'version', 0) or "1.0.0"
local githubUrl = "https://raw.githubusercontent.com/SnepCnep/fivem-anticheat/main/FiveM-anticheat/src/data/version.json"

local function CheckForUpdates()
    PerformHttpRequest(githubUrl, function(code, response, headers)
        if code == 200 and response then
            local req = json.decode(response)
            if getCurrentVersion ~= req.version then
                print("\27[1;33m--------------------------------------------------------------------------")
                print("\27[1;34mSC-AntiCheat: \27[1;36mThere is a new version available!")
                print("\27[1;36mPlease update to version: \27[1;37m" .. (req.version or "Unknown"))
                print("\27[1;33m--------------------------------------------------------------------------")
                print("\27[1;32m-> Author  : \27[1;37m SnepCnep")
                print("\27[1;32m-> Version : \27[1;37m " .. getCurrentVersion)
                print("\27[1;32m-> Status  : \27[1;37m ".. (req.status or "Unknown"))
                print("\27[1;33m--------------------------------------------------------------------------")
            end
            if thisResource == "anticheat" or thisResource == "FiveM-anticheat" then
                print("\27[1;31m-> Please change the resource name instead of using the default name!^7")
            end
        else
            print("^4 Failed to check for updates. Error code: " .. code .. "^7")
        end
    end, "GET", "", {["Content-Type"] = "application/json"})
end

CreateThread(function()
    PerformHttpRequest(githubUrl, function(code, response, headers)
        if code == 200 and response then
            local req = json.decode(response)
            print("\27[1;33m--------------------------------------------------------------------------")
            if getCurrentVersion ~= req.version then
                print("\27[1;34mSC-AntiCheat: \27[1;36mThere is a new version available!")
                print("\27[1;36mPlease update to version: \27[1;37m" .. (req.version or "Unknown"))
            else
                print("\27[1;34mSC-AntiCheat: \27[1;36mYou are running the latest version!")
            end
            print("\27[1;33m--------------------------------------------------------------------------")
            print("\27[1;32m-> Author  : \27[1;37m SnepCnep")
            print("\27[1;32m-> Version : \27[1;37m " .. getCurrentVersion)
            print("\27[1;32m-> Status  : \27[1;37m ".. (req.status or "Unknown"))
            if req.changelogs then
                print("\27[1;32m-> Changelogs  : \27[1;37m ".. (req.changelogs or ""))
            end
            print("\27[1;33m--------------------------------------------------------------------------")
            if thisResource == "anticheat" or thisResource == "FiveM-anticheat" then
                print("\27[1;31m-> Please change the resource name instead of using the default name!^7")
            end
        else
            print("^4 Failed to check for updates. Error code: " .. code .. "^7")
        end
    end, "GET", "", {["Content-Type"] = "application/json"})

    print("\27[1;35mTry /ac help for more information.")

    local CheckForUpdatesTime = 30

    while (Config.CheckForUpdates or true) do
        Wait(1000 * 60 * CheckForUpdatesTime)
        CheckForUpdates()
    end
end)