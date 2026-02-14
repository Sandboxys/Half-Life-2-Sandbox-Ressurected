--- Copyright © 2026, YourLocalCappy, all rights deserved ---

local cvar = require("cvar")
require("engine")

local FCVAR_CLIENTDLL = _E.FCVAR.CLIENTDLL

local function Exec(cmd)
  engine.ServerCommand(cmd .. "\n")
end

local function CreateCommandProxy(cvarName, default, onChange)
  local convar = ConVar(
    cvarName,
    default,
    FCVAR_CLIENTDLL
  )

  cvar.AddChangeCallback(
    cvarName,
    "proxy_" .. cvarName,
    function(varName, oldStr, oldNum)
      local newVal = convar:GetString()
      onChange(newVal)
    end
  )

  return convar
end

CreateCommandProxy("Main_Spawnmenu", "0", function(value)
  if tonumber(value) == 1 then
    Exec("sm_menu 1")
  end
end)

CreateCommandProxy("Secondary_Spawnmenu", "0", function(value)
  if tonumber(value) == 1 then
    Exec("debugsystemui")
  end
end)