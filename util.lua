--- Copyright © 2026, YourLocalCappy, all rights deserved ---

if not UTIL or not util then
  util = require("util")
  UTIL = util
end

function UTIL.Remove(...)
  if util then
  util.Remove()
  else
  engine.ServerCommand("ent_remove")
 end
end