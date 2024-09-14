local isServerSide = IsDuplicityVersion()

if isServerSide then
    local core = export["anticheat"]

    if type(core:init()) == "function" then
        local AC = core:init()
    else
        print("Failed to initialize the AntiCheat.")
        AC = {}
    end
else
    local core = export["anticheat"]

    if type(core:init()) == "function" then
        local AC = core:init()
    else
        print("Failed to initialize the AntiCheat.")
        AC = {}
    end
end

-- [//[ Trigger Protection ]\\] --

if isServerSide then
    
end