--- Copyright © 2026, YourLocalCappy, all rights deserved ---

_BASE_WEAPON = "weapon_hl2mpbase_scriptedweapon"

local table = table
local Warning = dbg.Warning

module("weapon")

local tWeapons = {}

function get(strClassname)
  local tWeapon = tWeapons[strClassname]
  if not tWeapon then
    return nil
  end

  tWeapon = table.copy(tWeapon)

  if tWeapon.__base ~= strClassname then
    local tBaseWeapon = get(tWeapon.__base)
    if not tBaseWeapon then
      Warning('WARNING: Attempted to initialize weapon "' .. strClassname .. '" with non-existing base class!\n')
    else
      tWeapon = table.inherit(tWeapon, tBaseWeapon)
    end
  end

  if tWeapon.__base == "weapon_hl2mpbase_scriptedweapon" then
    tWeapon.printname	= tWeapon.General.PrintName
    tWeapon.viewmodel	= tWeapon.General.ViewModel
    tWeapon.playermodel	= tWeapon.General.WorldModel
    tWeapon.anim_prefix	= tWeapon.General.AnimPrefix
    tWeapon.bucket	= tWeapon.General.Slot
    tWeapon.bucket_position   = tWeapon.General.SlotPos

    tWeapon.clip_size      = tWeapon.Primary and tWeapon.Primary.ClipSize
    tWeapon.default_clip   = tWeapon.Primary and tWeapon.Primary.DefaultClip
    tWeapon.primary_ammo   = tWeapon.Primary and tWeapon.Primary.Ammo

    tWeapon.clip2_size     = tWeapon.Secondary and tWeapon.Secondary.ClipSize
    tWeapon.default_clip2  = tWeapon.Secondary and tWeapon.Secondary.DefaultClip
    tWeapon.secondary_ammo = tWeapon.Secondary and tWeapon.Secondary.Ammo

  if tWeapon.Info then
      tWeapon.showusagehint   = tWeapon.Info.ShowHint
      tWeapon.autoswitchto    = tWeapon.Info.AutoSwitchTo
      tWeapon.autoswitchfrom  = tWeapon.Info.AutoSwitchFrom
      tWeapon.BuiltRightHanded = tWeapon.Info.RightHanded
      tWeapon.AllowFlipping   = tWeapon.Info.AllowFlipping
      tWeapon.MeleeWeapon     = tWeapon.Info.Melee
      tWeapon.weight          = tWeapon.Info.Weight
      tWeapon.damage         =  tWeapon.Info.Damage
    end

  else if tWeapon.__base == "weapon_tabledbase_scriptedweapon" then
    tWeapon.printname	= tWeapon.Table.PrintName
    tWeapon.viewmodel	= tWeapon.Table.ViewModel
    tWeapon.playermodel	= tWeapon.Table.WorldModel
    tWeapon.anim_prefix	= tWeapon.Table.AnimPrefix
    tWeapon.bucket	= tWeapon.Table.Slot
    tWeapon.bucket_position   = tWeapon.Table.SlotPos

    tWeapon.clip_size      = tWeapon.Table.ClipSize
    tWeapon.default_clip   = tWeapon.Table.DefaultClip
    tWeapon.primary_ammo   = tWeapon.Table.Ammo

    tWeapon.clip2_size     = tWeapon.Table.Clip2Size
    tWeapon.default_clip2  = tWeapon.Table.DefaultClip2
    tWeapon.secondary_ammo = tWeapon.Table.Ammo2

    tWeapon.showusagehint   = tWeapon.Table.ShowHint
    tWeapon.autoswitchto    = tWeapon.Table.AutoSwitchTo
    tWeapon.autoswitchfrom  = tWeapon.Table.AutoSwitchFrom
    tWeapon.BuiltRightHanded = tWeapon.Table.RightHanded
    tWeapon.AllowFlipping   = tWeapon.Table.AllowFlipping
    tWeapon.MeleeWeapon     = tWeapon.Table.Melee
    tWeapon.weight          = tWeapon.Table.Weight
    tWeapon.damage         =  tWeapon.Table.Damage
    end
  end

  return tWeapon
end

function getweapons()
  return tWeapons
end

function register(tWeapon, strClassname, bReload)
  if get(strClassname) ~= nil and bReload ~= true then
    return
  end
  tWeapons[strClassname] = tWeapon
end
