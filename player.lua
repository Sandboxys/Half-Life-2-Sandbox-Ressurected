--- Copyright © 2026, YourLocalCappy, all rights deserved ---

require("engine")

BasePlayer = _R.CBasePlayer

function LocalPlayer()
  return BasePlayer
end

pPlayer = BasePlayer
ply = BasePlayer
player = BasePlayer
sbrplay = BasePlayer

local cmd = engine.ServerCommand

function pPlayer.NoTarget()
  cmd("notarget\n")
end

function pPlayer.SBWeapons()
  cmd("give weapon_physgun\n")
  cmd("give weapon_crowbar")
  cmd("give weapon_rpg\n")
  cmd("give weapon_stunstick\n")
  cmd("give weapon_pistol\n")
  cmd("give weapon_357\n")
  cmd("give weapon_tool\n")
  cmd("give weapon_shotgun\n")
  cmd("give weapon_crossbow\n")
  cmd("give weapon_grenade\n")
end

function pPlayer.DrawHud(var)
  if var == 1 then
  cmd("cl_drawhud 1\n")
  else
  cmd("cl_drawhud 0\n")
  end
end