--- Copyright © 2026, YourLocalCappy, all rights deserved ---

require("mnlib")

local pPlayer = _R.CBasePlayer

DUPES = DUPES or {}
DUPE_INDEX = DUPE_INDEX or 0

function DoTrace(pPlayer, dist)
    local start = pPlayer:EyePosition()

    local f = Vector()
    pPlayer:EyeVectors(f, nil, nil)

    local finish = start + f * (dist or 8192)

    local tr = trace_t()

    UTIL.TraceLine(
        start,
        finish,
        _E.MASK and _E.MASK.SHOT or 0,
        ply,
        0,
        tr
    )

    return tr
end

local function IsValidEnt(ent)
    return ent and ent ~= NULL and not ent:IsPlayer()
end

function DupeCreate()
    local ply = pPlayer
    if not ply then return end

    local tr = DoTrace(ply)
    if not tr then return end

    local ent = tr.m_pEnt
    if not IsValidEnt(ent) then return end

    local phys = ent:VPhysicsGetObject()

    DUPE_INDEX = DUPE_INDEX + 1
    local id = DUPE_INDEX

    DUPES[id] = {
        class  = ent:GetClassname(),
        model  = ent.GetModelName and ent:GetModelName() or nil,
        angles = ent:GetAbsAngles(),
        mass   = phys ~= NULL and phys:GetMass() or nil
    }

    local cmd = "dupe_spawn_" .. id

    concommand.Add(cmd, function()
        DupeSpawn(id)
    end)

    mnlib.CreateButtonInTab("Dupes", "Dupe " .. id, cmd)
end

function DupeSpawn(id)
    local ply = pPlayer
    if not ply then return end

    local data = DUPES[id]
    if not data then return end

    if not tr or not tr:DidHitWorld() then return end

    local spawnPos = tr.endpos + Vector(0, 0, 8)

    local ent = CreateEntityByName(data.class or "prop_physics")
    if not ent or ent == NULL then return end

    if data.model and ent.SetModel then
        ent:SetModel(data.model)
    end

    ent:SetAbsOrigin(spawnPos)
    ent:SetAbsAngles(data.angles or QAngle(0,0,0))

    ent:Spawn()
    ent:Activate()

    local phys = ent:VPhysicsGetObject()
    if phys ~= NULL and data.mass then
        phys:SetMass(data.mass)
        phys:Wake()
    end
end

concommand.Add("dupe_copy", function()
    DupeCreate()
end)