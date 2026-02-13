--- Copyright © 2026, YourLocalCappy, all rights deserved ---

--[[

 Spawnmenu Library (Fixed Structure)
 Works ONLY with:

 DebugMenu
 {
     SUB-MENU
     {
         "BUTTON"
         {
             "command" "..."
         }
     }
 }

]]
local path = "hl2sbr/scripts/debugoptions.txt"

local function readFile(p)
    local f = io.open(p, "r")
    if not f then return "" end
    local d = f:read("*all")
    f:close()
    return d
end

local function writeFile(p, d)
    local f = io.open(p, "w")
    if not f then return end
    f:write(d)
    f:close()
end

local function escape(s)
    return s:gsub('"', '\\"')
end

module("mnlib")

local function ensureBase(data)
    if data == "" or not data:find("DebugMenu%s*{", 1, false) then
        return [[
DebugMenu
{
}
]]
    end
    return data
end

local function findSubMenuEnd(data)
    local start = data:find("SUB%-MENU%s*{")
    if not start then return nil end

    local i = start
    local level = 0
    local started = false

    while i <= #data do
        local c = data:sub(i, i)

        if c == "{" then
            level = level + 1
            started = true
        elseif c == "}" then
            level = level - 1
            if started and level == 0 then
                return i
            end
        end

        i = i + 1
    end

    return nil
end

function CreateButton(name, command)
    name = escape(name)
    command = escape(command)

    local data = readFile(path)
    data = ensureBase(data)

    if data:find('"' .. name .. '"', 1, true) then
        return
    end

    local finish = findSubMenuEnd(data)
    if not finish then
        print("[mnlib] SUB-MENU not found")
        return
    end

    local button =
        '\n        "' .. name .. '"\n' ..
        '        {\n' ..
        '            "command" "' .. command .. '"\n' ..
        '        }\n'

    data =
    data:sub(1, finish - 1)
    .. button
    .. "\n"
    .. data:sub(finish)
    writeFile(path, data)
end

function CreateTab(tab)
    tab = escape(tab)

    local data = readFile(path)
    data = ensureBase(data)

    -- aba já existe
    if data:find(tab .. "%s*{", 1, false) then
        writeFile(path, data)
        return
    end

    local start = data:find("DebugMenu%s*{")
    local i = start
    local level = 0
    local started = false
    local finish

    while i <= #data do
        local c = data:sub(i, i)

        if c == "{" then
            level = level + 1
            started = true
        elseif c == "}" then
            level = level - 1
            if started and level == 0 then
                finish = i
                break
            end
        end

        i = i + 1
    end

    if not finish then
        print("[mnlib] DebugMenu not closed")
        return
    end

    local tabBlock =
        '\n    ' .. tab .. '\n' ..
        '    {\n' ..
        '    }\n'

    data =
        data:sub(1, finish - 1)
        .. tabBlock
        .. "\n"
        .. data:sub(finish)

    writeFile(path, data)
end

function CreateButtonInTab(tab, name, command)
    tab = escape(tab)
    name = escape(name)
    command = escape(command)

    local data = readFile(path)
    data = ensureBase(data)

    if not data:find(tab .. "%s*{", 1, false) then
        CreateTab(tab)
        data = readFile(path)
    end

    if data:find('"' .. name .. '"', 1, true) then
        return
    end

    local start = data:find(tab .. "%s*{", 1, false)
    if not start then
        print("[mnlib] Tab not found: " .. tab)
        return
    end

    local i = start
    local level = 0
    local started = false
    local finish

    while i <= #data do
        local c = data:sub(i, i)

        if c == "{" then
            level = level + 1
            started = true
        elseif c == "}" then
            level = level - 1
            if started and level == 0 then
                finish = i
                break
            end
        end

        i = i + 1
    end

    if not finish then
        print("[mnlib] Error closing tab: " .. tab)
        return
    end

    local button =
        '\n        "' .. name .. '"\n' ..
        '        {\n' ..
        '            "command" "' .. command .. '"\n' ..
        '        }\n'

    data =
        data:sub(1, finish - 1)
        .. button
        .. "\n"
        .. data:sub(finish)

    writeFile(path, data)
end