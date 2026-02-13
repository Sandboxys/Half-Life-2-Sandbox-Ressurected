--- Copyright © 2026, YourLocalCappy, all rights deserved ---

require("bit")

-- bitbuffer
bitbuffer = {}
bitbuffer.__index = bitbuffer

function bitbuffer.new()
    return setmetatable({
        data = {},
        bitpos = 1
    }, bitbuffer)
end

function bitbuffer:WriteBit(b)
    self.data[self.bitpos] = b and 1 or 0
    self.bitpos = self.bitpos + 1
end

function bitbuffer:ReadBit()
    local b = self.data[self.bitpos] or 0
    self.bitpos = self.bitpos + 1
    return b
end

function bitbuffer:WriteUInt(num, bits)
    for i = bits - 1, 0, -1 do
        local mask = bit.lshift(1, i)
        self:WriteBit(bit.band(num, mask) ~= 0)
    end
end

function bitbuffer:ReadUInt(bits)
    local value = 0
    for i = bits - 1, 0, -1 do
        if self:ReadBit() == 1 then
            value = bit.bor(value, bit.lshift(1, i))
        end
    end
    return value
end

-- flags
flags = {}

function flags.Set(value, flag)
    return bit.bor(value, flag)
end

function flags.Remove(value, flag)
    return bit.band(value, bit.bnot(flag))
end

function flags.Has(value, flag)
    return bit.band(value, flag) ~= 0
end

--[[
FLAG_VISIBLE = 1      -- 0001
FLAG_ALIVE   = 2      -- 0010
FLAG_ADMIN   = 4      -- 0100
]]

-- Net
net = {}
net._receivers = {}

function net.Receive(name, func)
    net._receivers[name] = func
end

function net.Start(name)
    net._current = {
        name = name,
        buffer = bitbuffer.new()
    }
end

function net.WriteUInt(num, bits)
    net._current.buffer:WriteUInt(num, bits)
end

function net.Send()
    if not net._current then return end
    
    local msg = net._current
    local receiver = net._receivers[msg.name]

    if receiver then
        msg.buffer.bitpos = 1
        receiver(msg.buffer)
    end

    net._current = nil
end

-- serializer
serializer = {}

function serializer.WriteTable(buf, tbl)
    local count = 0
    for _ in pairs(tbl) do count = count + 1 end
    
    buf:WriteUInt(count, 16)

    for k, v in pairs(tbl) do
        buf:WriteUInt(#k, 8)
        for i = 1, #k do
            buf:WriteUInt(string.byte(k, i), 8)
        end
        
        buf:WriteUInt(v, 32)
    end
end

function serializer.ReadTable(buf)
    local tbl = {}
    local count = buf:ReadUInt(16)

    for i = 1, count do
        local len = buf:ReadUInt(8)
        local key = ""
        for j = 1, len do
            key = key .. string.char(buf:ReadUInt(8))
        end
        
        local value = buf:ReadUInt(32)
        tbl[key] = value
    end

    return tbl
end

-- snapshot
snapshot = {}

function snapshot.Capture(ent)
    return {
        pos = ent.pos,
        health = ent.health,
        flags = ent.flags
    }
end

function snapshot.Apply(ent, snap)
    ent.pos = snap.pos
    ent.health = snap.health
    ent.flags = snap.flags
end

-- rpc
rpc = {}
rpc._funcs = {}

function rpc.Register(name, func)
    rpc._funcs[name] = func
end

function rpc.Call(name, ...)
    if rpc._funcs[name] then
        return rpc._funcs[name](...)
    end
end

-- virtual machine
vrm = {}
vrm.__index = vrm

vrm.OP_ADD = 1
vrm.OP_SUB = 2
vrm.OP_PRINT = 3

function vrm.new()
    return setmetatable({
        stack = {},
        code = {},
        ip = 1
    }, vrm)
end

function vrm:Push(v)
    table.insert(self.stack, v)
end

function vrm:Pop()
    return table.remove(self.stack)
end

function vrm:Run()
    while self.ip <= #self.code do
        local op = self.code[self.ip]
        
        if op == vrm.OP_ADD then
            local b = self:Pop()
            local a = self:Pop()
            self:Push(a + b)
            
        elseif op == vrm.OP_SUB then
            local b = self:Pop()
            local a = self:Pop()
            self:Push(a - b)
            
        elseif op == vrm.OP_PRINT then
            print(self:Pop())
        end
        
        self.ip = self.ip + 1
    end
end

-- compressor
compressor = {}

function compressor.Compress(str)
    local result = ""
    local count = 1

    for i = 2, #str + 1 do
        if str:sub(i,i) == str:sub(i-1,i-1) then
            count = count + 1
        else
            result = result .. count .. str:sub(i-1,i-1)
            count = 1
        end
    end

    return result
end

function compressor.Decompress(str)
    local result = ""
    for count, char in str:gmatch("(%d+)(.)") do
        result = result .. string.rep(char, tonumber(count))
    end
    return result
end

function compressor.CompressBits(data)
    local result = {}
    local count = 1

    for i = 2, #data + 1 do
        if data[i] == data[i-1] then
            count = count + 1
        else
            table.insert(result, {bit = data[i-1], count = count})
            count = 1
        end
    end

    return result
end

function compressor.DecompressBits(comp)
    local result = {}

    for _, block in ipairs(comp) do
        for i = 1, block.count do
            table.insert(result, block.bit)
        end
    end

    return result
end

-- mask builder
mask_builder = {}
mask_builder.__index = mask_builder

function mask_builder.new()
    return setmetatable({ value = 0 }, mask_builder)
end

function mask_builder:Add(flag)
    self.value = bit.bor(self.value, flag)
end

function mask_builder:Remove(flag)
    self.value = bit.band(self.value, bit.bnot(flag))
end

function mask_builder:Get()
    return self.value
end