--- Copyright © 2026, YourLocalCappy, all rights deserved ---

--[[

Here are some needed stuff

]]

engine = require("engine")

engine.ServerCommand = engine.ServerCommand

entity = require("entity")

ent = entity

function GetPlayer()
  result = pPlayer.GetLocalPlayer()
  print(result)
end

function GetGPlayer()
  return pPlayer.GetLocalPlayer()
end

GPLAYER = GetGPlayer()

CONTENTS_EMPTY = 0
CONTENTS_SOLID = 0x1
CONTENTS_WINDOW = 0x2
CONTENTS_AUX = 0x4
CONTENTS_GRATE = 0x8
CONTENTS_SLIME = 0x10
CONTENTS_WATER = 0x20
CONTENTS_BLOCKLOS = 0x40
CONTENTS_OPAQUE = 0x80
LAST_VISIBLE_CONTENTS = 0x80

ALL_VISIBLE_CONTENTS = bit and bit.bor(
LAST_VISIBLE_CONTENTS,
LAST_VISIBLE_CONTENTS - 1
) or LAST_VISIBLE_CONTENTS

CONTENTS_TESTFOGVOLUME = 0x100
CONTENTS_UNUSED = 0x200
CONTENTS_UNUSED6 = 0x400
CONTENTS_TEAM1 = 0x800
CONTENTS_TEAM2 = 0x1000
CONTENTS_IGNORE_NODRAW_OPAQUE = 0x2000
CONTENTS_MOVEABLE = 0x4000
CONTENTS_AREAPORTAL = 0x8000
CONTENTS_PLAYERCLIP = 0x10000
CONTENTS_MONSTERCLIP = 0x20000
CONTENTS_CURRENT_0 = 0x40000
CONTENTS_CURRENT_90 = 0x80000
CONTENTS_CURRENT_180 = 0x100000
CONTENTS_CURRENT_270 = 0x200000
CONTENTS_CURRENT_UP = 0x400000
CONTENTS_CURRENT_DOWN = 0x800000
CONTENTS_ORIGIN = 0x1000000
CONTENTS_MONSTER = 0x2000000
CONTENTS_DEBRIS = 0x4000000
CONTENTS_DETAIL = 0x8000000
CONTENTS_TRANSLUCENT = 0x10000000
CONTENTS_LADDER = 0x20000000
CONTENTS_HITBOX = 0x40000000

COLLISION_GROUP_NONE = 0
COLLISION_GROUP_DEBRIS = 1
COLLISION_GROUP_DEBRIS_TRIGGER = 2
COLLISION_GROUP_INTERACTIVE_DEBRIS = 3
COLLISION_GROUP_INTERACTIVE = 4
COLLISION_GROUP_PLAYER = 5
COLLISION_GROUP_BREAKABLE_GLASS = 6
COLLISION_GROUP_VEHICLE = 7
COLLISION_GROUP_PLAYER_MOVEMENT = 8
COLLISION_GROUP_NPC = 9
COLLISION_GROUP_IN_VEHICLE = 10
COLLISION_GROUP_WEAPON = 11
COLLISION_GROUP_VEHICLE_CLIP = 12
COLLISION_GROUP_PROJECTILE = 13
COLLISION_GROUP_DOOR_BLOCKER = 14
COLLISION_GROUP_PASSABLE_DOOR = 15
COLLISION_GROUP_DISSOLVING = 16
COLLISION_GROUP_PUSHAWAY = 17
COLLISION_GROUP_NPC_ACTOR = 18
COLLISION_GROUP_NPC_SCRIPTED = 19
LAST_SHARED_COLLISION_GROUP = 20

DMG_GENERIC = 0
DMG_CRUSH = bit.lshift(1, 0)
DMG_BULLET = bit.lshift(1, 1)
DMG_SLASH = bit.lshift(1, 2)
DMG_BURN = bit.lshift(1, 3)
DMG_VEHICLE = bit.lshift(1, 4)
DMG_FALL = bit.lshift(1, 5)
DMG_BLAST = bit.lshift(1, 6)
DMG_CLUB = bit.lshift(1, 7)
DMG_SHOCK = bit.lshift(1, 8)
DMG_SONIC = bit.lshift(1, 9)
DMG_ENERGYBEAM = bit.lshift(1, 10)
DMG_PREVENT_PHYSICS_FORCE = bit.lshift(1, 11)
DMG_NEVERGIB = bit.lshift(1, 12)
DMG_ALWAYSGIB = bit.lshift(1, 13)
DMG_DROWN = bit.lshift(1, 14)
DMG_PARALYZE = bit.lshift(1, 15)
DMG_NERVEGAS = bit.lshift(1, 16)
DMG_POISON = bit.lshift(1, 17)
DMG_RADIATION = bit.lshift(1, 18)
DMG_DROWNRECOVER = bit.lshift(1, 19)
DMG_ACID = bit.lshift(1, 20)
DMG_SLOWBURN = bit.lshift(1, 21)
DMG_REMOVENORAGDOLL = bit.lshift(1, 22)
DMG_PHYSGUN = bit.lshift(1, 23)
DMG_PLASMA = bit.lshift(1, 24)
DMG_AIRBOAT = bit.lshift(1, 25)
DMG_DISSOLVE = bit.lshift(1, 26)
DMG_BLAST_SURFACE = bit.lshift(1, 27)
DMG_DIRECT = bit.lshift(1, 28)
DMG_BUCKSHOT = bit.lshift(1, 29)

AUTOAIM_2DEGREES = 0.0348994967
AUTOAIM_5DEGREES = 0.0871557427
AUTOAIM_8DEGREES = 0.1391731010
AUTOAIM_10DEGREES = 0.1736481777
AUTOAIM_20DEGREES = 0.3490658504

MoveType = {
NONE = 0,
ISOMETRIC = 1,
WALK = 2,
STEP = 3,
FLY = 4,
FLYGRAVITY = 5,
VPHYSICS = 6,
PUSH = 7,
NOCLIP = 8,
LADDER = 9,
OBSERVER = 10,
CUSTOM = 11,
LAST = 11,
MAX_BITS = 4
}

MoveCollide = {
DEFAULT = 0,
FLY_BOUNCE = 1,
FLY_CUSTOM = 2,
FLY_SLIDE = 3,
COUNT = 4,
MAX_BITS = 3
}

SolidType = {
NONE = 0,
BSP = 1,
BBOX = 2,
OBB = 3,
OBB_YAW = 4,
CUSTOM = 5,
VPHYSICS = 6,
LAST = 7
}

SolidFlags = {
CUSTOMRAYTEST = 0x0001,
CUSTOMBOXTEST = 0x0002,
NOT_SOLID = 0x0004,
TRIGGER = 0x0008,
NOT_STANDABLE = 0x0010,
VOLUME_CONTENTS = 0x0020,
FORCE_WORLD_ALIGNED = 0x0040,
USE_TRIGGER_BOUNDS = 0x0080,
ROOT_PARENT_ALIGNED = 0x0100,
TRIGGER_TOUCH_DEBRIS = 0x0200,
MAX_BITS = 10
}

if bit then
function bit.has(v, f) return bit.band(v, f) ~= 0 end
function bit.add(v, f) return bit.bor(v, f) end
function bit.remove(v, f) return bit.band(v, bit.bnot(f)) end
function bit.toggle(v, f)
if bit.has(v, f) then return bit.remove(v, f) end
return bit.add(v, f)
end
end

function DEFINE_BASECLASS(name)
if ENT then
ENT.__base = name
elseif SWEP then
SWEP.__base = name
else
Warning("Not a SWEP or a entity!")
end
end

function DEFINE_FACTORY(name)
if ENT then
ENT.__factory = name
elseif SWEP then
SWEP.__factory = name
else
Warning("Not a SWEP or a entity!")
end
end

fl = {}

function fl.Write(name, content)
local f = filesystem.Open(name, "w", "DATA")
if not f then return false end
local ok = filesystem.Write(content, f) == #content
filesystem.Close(f)
return ok
end

function fl.Append(name, content)
local f = filesystem.Open(name, "a", "DATA")
if not f then return false end
local ok = filesystem.Write(content, f) == #content
filesystem.Close(f)
return ok
end

function fl.Read(name)
local f = filesystem.Open(name, "r", "DATA")
if not f then return nil end
local size = filesystem.Size(f)
if size <= 0 then filesystem.Close(f) return nil end
local _, content = filesystem.Read(size, f)
filesystem.Close(f)
return content
end

function fl.Exists(name, path)
return filesystem.FileExists(name, path or "DATA")
end

function fl.IsDir(name, path)
return filesystem.IsDirectory(name, path or "DATA")
end

function fl.CreateDir(name)
filesystem.CreateDirHierarchy(name, "DATA")
end

function fl.Delete(name)
return filesystem.RemoveFile(name, "DATA")
end

function fl.Rename(old, new)
return filesystem.RenameFile(old, new, "DATA")
end

function fl.Size(name)
local f = filesystem.Open(name, "r", "DATA")
if not f then return 0 end
local size = filesystem.Size(f)
filesystem.Close(f)
return size
end

function ent.Remove(e)
UTIL.Remove(e)
end

concommand.Add("GetLocalPlayer", GetPlayer)

concommand.Add("main_spawnmenu", function()
  engine.ServerCommand("debugsystemui\n")
end)

concommand.AddVar(
  "secondary_spawnmenu",
  nil,
  0,
  function(pPlayer, v)
    if v == 1 then
      engine.ServerCommand("sm_menu 1\n")
    else
      engine.ServerCommand("sm_menu 0\n")
    end
  end
)

-- c_hands stuff

local HANDS_MODEL = "models/weapons/c_arms_citizen.mdl"

local __hands = nil
local __lastVM = nil

hook.add("PreDrawViewModel", "c_hands_simple", function()
    local pPlayer = pPlayer or _R.CBasePlayer
   
    -- Get the damn vm
    local vm = pPlayer.GetViewModel()
    if not vm then return end

    if __lastVM ~= vm then

        if __hands then
            UTIL.Remove(__hands)
            __hands = nil
        end

        __lastVM = vm
    end

    if not __hands then

        __hands = CreateEntityByName(HANDS_MODEL)
        if not __hands then return end

        __hands:SetParent(vm)
        __hands:AddEffects(EF_BONEMERGE)
        __hands:AddEffects(EF_BONEMERGE_FASTCULL)
        __hands:SetNoDraw(false)
    end

    -- Update bones
    vm:SetupBones()
    __hands:SetupBones()
    __hands:DrawModel()

end)

-- colorable physgun stuff

local ORIGINAL_VMT = "hl2sbr/materials/models/weapons/v_physcannon/v_superphyscannon_sheet.vmt"
local BASE_PATH = "hl2sbr/materials/models/weapons/v_physcannon/"

local function readFile(p)
    local f = io.open(p, "r")
    if not f then return nil end
    local d = f:read("*all")
    f:close()
    return d
end

local function writeFile(p, d)
    local f = io.open(p, "w")
    if not f then return false end
    f:write(d)
    f:close()
    return true
end

local function escape(s)
    return s:gsub('"', '\\"')
end

local function CreateColoredPhysgun(name, tint)

    -- Read original material
    local content = readFile(ORIGINAL_VMT)
    if not content or content == "" then
        print("Failed to read physgun VMT")
        return
    end

    -- Replace selfillum tint
    content = string.gsub(
        content,
        '%$selfillumtint%s*"%b[]"',
        '$selfillumtint "' .. escape(tint) .. '"'
    )

    local newFile = BASE_PATH .. "v_superphyscannon_" .. name .. ".vmt"

    -- Write new material
    if not writeFile(newFile, content) then
        print("Failed to write new material")
        return
    end

    print("Created material:", newFile)

    -- Apply material to active weapon
    local pPlayer = pPlayer or _R.CBasePlayer
        local wep = pPlayer.GetActiveWeapon()
        if wep and wep.SetMaterial then
            wep.SetMaterial(
                "models/weapons/v_physcannon/v_superphyscannon_" .. name
            )
    end
end

concommand.Add("set_physgun_color_red", function()
    CreateColoredPhysgun("red", "[1.0 0.0 0.0]")
end)

concommand.Add("set_physgun_color_blue", function()
    CreateColoredPhysgun("blue", "[0.0 0.0 1.0]")
end)

concommand.Add("set_physgun_color_cyan", function()
    CreateColoredPhysgun("cyan", "[0.0 1.0 1.0]")
end)

concommand.Add("set_physgun_color_green", function()
    CreateColoredPhysgun("green", "[0.0 1.0 0.0]")
end)

concommand.Add("set_physgun_color_purple", function()
    CreateColoredPhysgun("purple", "[1.0 0.0 1.0]")
end)