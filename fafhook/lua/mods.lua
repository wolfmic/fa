do
    --- Provides the locally-loaded mod version, as provided by the friendly
    --  neighbourhood FAF client
    -- @param uid The UID of the mod in question
    --
    GetLocalModVersion = function(uid)
        local mod = AllMods()[uid]
        if mod then
            local env = {
                repo = nil,
                ref = nil,
                hash = nil,
                tag = nil
            }
            local ok, result = pcall(doscript, '/mod_versions/'..uid..'.lua', env) do
                if ok then
                    return env
                end
            end
        else
            return nil
        end
    end

    local oldLoadModInfo = LoadModInfo
    --- Hooked to provide a default value for the frontend key
    -- @param filename mod_info.lua file placement
    --
    LoadModInfo = function(filename)
        local mod_info = oldLoadModInfo(filename)
        if mod_info ~= nil and mod_info.frontend == nil then
            mod_info.frontend = false
        end
        return mod_info
    end
end
