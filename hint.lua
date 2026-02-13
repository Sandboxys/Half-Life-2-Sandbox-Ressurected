--- Copyright © 2026, YourLocalCappy, all rights deserved ---

hint = {}

require("engine")

local cmd = engine.ServerCommand
local gsub = string.gsub

function hint.Add(ht)
    if CLIENT then return end
    if not ht then return end

    ht = gsub(ht, '"', '\\"')

    cmd(
        'ent_create env_hudhint message "' .. ht .. '" targetname __lua_hint;' ..
        'ent_fire __lua_hint showhudhint;' ..
        'ent_fire __lua_hint Kill 0 3\n'
    )
end
