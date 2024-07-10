-- [//[ Update Checker ]\\] --
local getCurrentVersion = GetResourceMetadata(GetCurrentResourceName(), 'version', 0) or "1.0.0"
local githubUrl = "https://raw.githubusercontent.com/snepcnep/anticheat/main/version.txt"

CreateThread(function()
    PerformHttpRequest(githubUrl, function()
    
    
    end, "GET", "", {["Content-Type"] = "application/json"})
end)