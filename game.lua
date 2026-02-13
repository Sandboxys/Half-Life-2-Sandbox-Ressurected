--- Copyright © 2026, YourLocalCappy, all rights deserved ---

GLOBAL = _G
IN_GAME = not _CLIENT
CLIENT = _CLIENT == true
SERVER = IN_GAME == true
CLIVER = CLIENT and SERVER
SHARED = CLIVER == true
NOSIDE = not CLIENT and not SERVER or not CLIVER
NULL = nil

concommand = require("concommand")
hook = require("hook")
timer = require("timer")
Timer = timer
entity = require("entity")
engine = require("engine")
cvar = require("cvar")
filesystem = require("filesystem")
gamemode = gamemode or require("gamemode")
util = require("util")
bit = require("bit")
material = IMaterial or _R.IMaterial
scriptpanel = CScriptedClientLuaPanel or _R.CScriptedClientLuaPanel
ppage = PropertyPage or _R.PropertyPage
pdialog = PropertyDialog or _R.PropertyDialog
frame = Frame or _R.Frame
panel = Panel or _R.Panel
checkbutton = CheckButton or _R.CheckButton
button = Button or _R.Button

if not bit then
bit = nil
end

cmd = concommand
GM = gamemode
ent = entity

Warning = dbg.Warning
DevMsg = dbg.DevMsg
DevWarning = dbg.DevWarning
Msg = dbg.Msg

function IsValid(a)
if a == nil then return false end
if a == NULL then return false end
return true
end

function ColorPrint(r, g, b, a, msg)
if cvar and cvar.ConsoleColorPrintf then
cvar.ConsoleColorPrintf(Color(r, g, b, a or 255), msg .. "\n")
elseif cvar and cvar.ConsolePrintf then
cvar.ConsolePrintf(msg .. "\n")
else
print(msg)
end
end

util = util

game = game or {}

function util.PrecacheModel(model)
_R.CBaseEntity.PrecacheModel(model)
end

function CurTime()
return gpGlobals.curtime()
end

function game.WeaponModel(wep, model)
  if engine and engine.ServerCommand then
  engine.ServerCommand("ent_fire " .. wep .. "setmodel " .. model .. "\n")
  end
end

function hook.Add(type, name, fn)
  hook.add(type, name, fn)
end

filesystem.HintResourceNeed("hl2sbr/lua/needed.lua", 1)