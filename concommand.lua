--- Copyright © 2026, YourLocalCappy, all rights deserved ---

if not concommand then
  concommand = require("concommand")
end

function concommand.Add(name, fn)
  concommand.Create(name, fn, "None", 0)
end