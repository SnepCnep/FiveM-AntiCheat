local KownBackdoorUrls = {

}

AC.System:ExportHandler("CheckURL", function(url)
    if not url then
        return false
    end

    local resource = GetInvokingResource()
    
    if Config.HttpFilter then
        local Allowedurls = Config.AllowedUrls
        if Allowedurls[url] then
            return true
        end

        print("Block a not allowed http request! | Resource: (".. resource ..") | URL: (".. url ..")")

        return false
    end

    local url = url:lower()
    
    if Config.AntiBackdoor then
        for i = 1, #KownBackdoorUrls do
            local knownBackdoorUrl = KownBackdoorUrls[i]:lower()
            if url:find(knownBackdoorUrl) then
                print("Blocked a backdoor http request! | Resource: (".. resource ..") | URL: (".. url ..")")
                return false
            end
        end
    end

    return true
end)