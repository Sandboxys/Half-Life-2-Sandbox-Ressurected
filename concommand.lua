--- Copyright © 2026, YourLocalCappy, all rights deserved ---

local ConCommand = ConCommand
local Warning = dbg.Warning
local tostring = tostring
local pcall = pcall
local tonumber = tonumber
local cvar = require("cvar")

module( "concommand" )

local bError, strError
local tFnCommandCallbacks = {}

function Create( pName, callback, pHelpString, flags )
  tFnCommandCallbacks[ pName ] = callback
  ConCommand( pName, pHelpString, flags )
end

function Add( pName, callback )
  Create( pName, callback, nil, 0 )
end

function Dispatch( pPlayer, pCmd, ArgS )
  local fnCommandCallback = tFnCommandCallbacks[ pCmd ]
  if ( not fnCommandCallback ) then
    return false
  else
    bError, strError = pcall( fnCommandCallback, pPlayer, pCmd, ArgS )
    if ( bError == false ) then
      Warning( "ConCommand '" .. tostring( pCmd ) .. "' Failed: " .. tostring( strError ) .. "\n" )
    end
    return true
  end
end

function Remove( pName )
  if ( tFnCommandCallbacks[ pName ] ) then
    tFnCommandCallbacks[ pName ] = nil
  end
end

local FCVAR_CLIENTDLL = _E.FCVAR.CLIENTDLL

local function ToBool(n)
  return tonumber(n) == 1 and 1 or 0
end

function AddToggle(pName, default, fn, flags)
  flags = flags or FCVAR_CLIENTDLL
  default = default or "0"

  local convar = ConVar(
    pName,
    default,
    flags
  )

  local function OnChange(varName, oldValueStr, oldValueNum)
    local newValue = ToBool(convar:GetString())
    fn(nil, newValue)
  end

  cvar.AddChangeCallback(
    pName,
    "toggle_" .. pName,
    OnChange
  )

  return convar
end

function AddVar(pName, vars, default, fn, flags)
  flags = flags or FCVAR_CLIENTDLL
  default = tostring(default or 0)

  local convar = ConVar(
    pName,
    default,
    flags
  )

  local function OnChange(varName, oldValueStr, oldValueNum)
    local v = convar:GetString()
    local n = tonumber(v)

    if n ~= nil then
      v = n
    elseif vars and vars[v] ~= nil then
      v = vars[v]
    else
      v = default
    end

    fn(nil, v, vars)
  end

  cvar.AddChangeCallback(
    pName,
    "var_" .. pName,
    OnChange
  )

  return convar
end