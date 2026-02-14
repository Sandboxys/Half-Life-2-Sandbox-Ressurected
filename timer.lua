-- Copyright © 2026, YourLocalCappy, all rights deserved ---

local timers     = {}
local cooldowns  = {}
local threads    = {}

local pairs       = pairs
local tostring    = tostring
local tableInsert = table.insert
local tableRemove = table.remove

local error = dbg.Warning

local function now()
    return os.clock() -- change to CurTime()
end

local function StartThread(fn)
    local co = coroutine.create(fn)
    tableInsert(threads, co)
    return co
end

module("timer")

function Thread(fn)
    return StartThread(fn)
end

function Wait(seconds)
    local start = now()
    while now() - start < seconds do
        coroutine.yield()
    end
end

function Add(name, delay, reps, fn)
    if not name or not fn then return end

    timers[name] = {
        delay = delay or 0,
        reps  = reps or 1,
        fn    = fn,
        next  = now() + (delay or 0)
    }
end

Create = Add

function Simple(delay, fn)
    local name = "simple_" .. tostring(fn) .. "_" .. now()
    Add(name, delay, 1, fn)
end

function Loop(name, delay, fn)
    Add(name, delay or 0, 0, fn)
end

function Remove(name)
    timers[name] = nil
end

function Exists(name)
    return timers[name] ~= nil
end

function Cooldown(name, delay)
    cooldowns[name] = now() + delay
end

function InCooldown(name)
    return cooldowns[name] and now() < cooldowns[name]
end

function CheckCooldown(name, delay)
    if InCooldown(name) then
        return false
    end

    Cooldown(name, delay)
    return true
end

function RemoveCooldown(name)
    cooldowns[name] = nil
end

local function ProcessTimers()

    local t = now()

    -- Timers
    for name, tm in pairs(timers) do

        if t >= tm.next then

            local ok, err = pcall(tm.fn)

            if not ok then
                error("Timer error [" .. name .. "]: " .. err)
                timers[name] = nil
            else
                if tm.reps > 0 then
                    tm.reps = tm.reps - 1

                    if tm.reps <= 0 then
                        timers[name] = nil
                    else
                        tm.next = t + tm.delay
                    end
                else
                    tm.next = t + tm.delay
                end
            end
        end
    end

    -- Threads (coroutines)
    for i = #threads, 1, -1 do
        local co = threads[i]

        if coroutine.status(co) == "dead" then
            tableRemove(threads, i)
        else
            local ok, err = coroutine.resume(co)
            if not ok then
                error("Thread error: " .. err)
                tableRemove(threads, i)
            end
        end
    end

    for name, timeEnd in pairs(cooldowns) do
        if t >= timeEnd then
            cooldowns[name] = nil
        end
    end
end

function Think()
    ProcessTimers()
end