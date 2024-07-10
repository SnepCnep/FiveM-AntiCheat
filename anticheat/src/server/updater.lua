-- [//[ Update Checker ]\\] --
local getCurrentVersion = GetResourceMetadata(GetCurrentResourceName(), 'version', 0) or "1.0.0"
local githubUrl = "https://raw.githubusercontent.com/snepcnep/anticheat/main/version.json"

CreateThread(function()
    PerformHttpRequest(githubUrl, function(code, response, headers)
        if code == 200 then
            -- Need to add a clean text here :)
        else
            print("^4 Failed to check for updates. Error code: " .. code .. "^7")
        end
    end, "GET", "", {["Content-Type"] = "application/json"})
end)