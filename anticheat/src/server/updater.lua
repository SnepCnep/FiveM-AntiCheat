-- [//[ Update Checker ]\\] --
local getCurrentVersion = GetResourceMetadata(GetCurrentResourceName(), 'version', 0) or "1.0.0"
local githubUrl = "https://raw.githubusercontent.com/snepcnep/anticheat/main/version.json"

CreateThread(function()
    PerformHttpRequest(githubUrl, function(code, response, headers)
        if code == 200 and response then
            local req = json.decode(response)
            if getCurrentVersion ~= req.version then
                _print("^2[AntiCheat]^7 A new version is available! Please update your resource. Current version: " .. getCurrentVersion .. " New version: " .. req.version .. "^7")
            else
                _print("^2[AntiCheat]^7 You are using the latest version of the resource!^7")
            end
            -- Need to add a clean text here :)
        else
            print("^4 Failed to check for updates. Error code: " .. code .. "^7")
        end
    end, "GET", "", {["Content-Type"] = "application/json"})
end)