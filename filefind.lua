--- Copyright © 2026, YourLocalCappy, all rights deserved ---

filesystem._findCache = filesystem._findCache or {}
require("filesystem")

local WORDS = {
    "init","main","core","base","menu","ui","hud",
    "client","server","shared","config","settings",
    "autorun","loader","entry","boot","tool", "spawnmenu"
}

local PREFIXES = {
    "", "cl_", "sv_", "sh_", "hl2_"
}

local SUFFIXES = {
    "", "_client", "_server", "_shared",
    "_v1", "_v2", "_old", "_new", "_1",
    "_2", "_3", "_4", "_5", "_6", "_7"
}

local EXTENSIONS = {
    ".lua", ".txt", ".res"
}

local ALPHABET = "abcdefghijklmnopqrstuvwxyz"

local function tryFile(path, name, found, dedupe)
    for _, ext in ipairs(EXTENSIONS) do
        local file = name .. ext
        if not dedupe[file] then
            local full = path .. "/" .. file
            if filesystem.FileExists(full, "GAME") then
                dedupe[file] = true
                found[#found + 1] = file
            end
        end
    end
end

file = file or {}

function file.Find(path, force)
    local cache = filesystem._findCache[path]
    if cache and not force then
        return cache
    end

    local found = {}
    local dedupe = {}

    for _, w in ipairs(WORDS) do
        tryFile(path, w, found, dedupe)
    end

    for _, p in ipairs(PREFIXES) do
        if p ~= "" then
            for _, w in ipairs(WORDS) do
                tryFile(path, p .. w, found, dedupe)
            end
        end
    end

    for _, w in ipairs(WORDS) do
        for _, s in ipairs(SUFFIXES) do
            if s ~= "" then
                tryFile(path, w .. s, found, dedupe)
            end
        end
    end

    for _, w in ipairs(WORDS) do
        for i = 1, 5 do
            tryFile(path, w .. "_" .. i, found, dedupe)
        end
    end

    if #found > 0 then
        filesystem._findCache[path] = found
        return found
    end

    for i = 1, #ALPHABET do
        tryFile(path, ALPHABET:sub(i, i), found, dedupe)
    end

    for i = 1, #ALPHABET do
        for j = 1, #ALPHABET do
            tryFile(
                path,
                ALPHABET:sub(i,i) .. ALPHABET:sub(j,j),
                found,
                dedupe
            )
        end
    end

    filesystem._findCache[path] = found
    return found
end