--- Copyright © 2026, YourLocalCappy, all rights deserved ---

local timers = {}
local cooldowns = {}
local pairs = pairs

local function now()
    return os.clock()
end

local function ProcessTimers()
    local t = now()

    for name, tm in pairs(timers) do
        if t >= tm.next then

            local ok, err = pcall(tm.fn)
            if not ok then
                print("Timer error [" .. name .. "]: " .. err)
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

    -- Clean expired cooldowns
    for name, timeEnd in pairs(cooldowns) do
        if t >= timeEnd then
            cooldowns[name] = nil
        end
    end
end

local TIMER = {}

function TIMER.Create(name, delay, reps, fn)
    ProcessTimers()

    timers[name] = {
        delay = delay or 0,
        reps  = reps or 1,
        fn    = fn,
        next  = now() + (delay or 0)
    }
end

function TIMER.CreateLoop(name, fn, delay)
    TIMER.Create(name, delay or 0, 0, fn)
end

function TIMER.Remove(name)
    ProcessTimers()
    timers[name] = nil
end

function TIMER.Exists(name)
    ProcessTimers()
    return timers[name] ~= nil
end

function TIMER.Stop(name)
    TIMER.Remove(name)
end

function TIMER.Cooldown(name, delay)
    ProcessTimers()
    cooldowns[name] = now() + delay
end

function TIMER.InCooldown(name)
    ProcessTimers()
    return cooldowns[name] ~= nil
end

function TIMER.CheckCooldown(name, delay)
    ProcessTimers()

    if cooldowns[name] then
        return false
    end

    cooldowns[name] = now() + delay
    return true
end

function TIMER.RemoveCooldown(name)
    cooldowns[name] = nil
end

setmetatable(TIMER, {
    __index = function(t, k)
        ProcessTimers()
        return rawget(t, k)
    end
})

module("timer")
for k,v in pairs(TIMER) do
    _M[k] = v
end