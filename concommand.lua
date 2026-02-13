--- Copyright © 2026, YourLocalCappy, all rights deserved ---

local ConCommand = ConCommand
local Warning = dbg.Warning
local tostring = tostring
local pcall = pcall
local tonumber = tonumber

module( "concommand" )

local bError, strError
local tFnCommandCallbacks = {}

function Create( pName, callback, pHelpString, flags )
  tFnCommandCallbacks[ pName ] = callback
  ConCommand( pName, pHelpString, flags )
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

function AddToggle(pName, fn)
  local state = 0

  Create(pName, function(pPlayer)
    state = (state == 0 and 1 or 0)
    fn(pPlayer, state)
  end, "None", 0)
end

function AddVar( pName, vars, default, fn )
  Create( pName, function( pPlayer, pCmd, ArgS )
    local v = ArgS and ArgS[1]

    if ( v == nil ) then
      v = default
    else
      local n = tonumber( v )
      if ( n ~= nil ) then
        v = n
      elseif ( vars and vars[ v ] ~= nil ) then
        v = vars[ v ]
      else
        v = default
      end
    end

    fn( pPlayer, v, vars )
  end, "None", 0 )
end