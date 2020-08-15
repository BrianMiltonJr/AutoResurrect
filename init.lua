--addon AutoResurrect: index
local AutoResurrect, NS = ...;
NS.Messages = {
  ["Thanks"] = {
    ["Resurrect"] = "Thank you for Resurrecting me.",
    ["Summon"] = "Thank you for Summoning me."
  },
  ["Unghost"] = "Walked back to my body.",
  ["Dead"] = "I died, please Resurrect me at your earliest convenience.",
  ["Disabled"] = "Combat Resurrections have been disabled. Use the /ar cr_on command to enable Combat Resurrections.",
  ["Language"] = GetDefaultLanguage("player"),
  ["Channel"] = nil
};
NS.Toggles = {
  ["CombatResurrect"] = true,
  ["Messages"] = true,
  ["CombatStatus"] = false,
  ["Enabled"] = true,
}

local AutoResurrect = CreateFrame("Frame");

-- Handily checks if we can send a message
local function SendMessage(msg, channel, language, target)
  if Toggle.Messages then SendChatMessage(msg, channel, language, target); end
end

-- Sets our toggle to false or true if status == "off" or "on". If Status == nil the we flip the toggle
local function FlipToggle(key, status)
  if Toggles[key] == nil then return nil; end

  if status == "on" then Toggles[key] = true; elseif status == "off" then Toggles[key] = false; else Toggles[key] = not Toggles[key]; end
end

--Splits our Command Arguments. Currently only does Space.
local function SplitArgs(txt, delimiter)
  local args = {};
  for arg in string.gmatch(txt, "%S+") do table.insert(args, arg); end
  return {args[1], table.unpack(args, 2)};
end






Commands = {
  ["status"] = function(self, ...)
    local command = ...;
    FlipToggle("Enabled", command);
  end,
  ["messages"] = function(self, ...)
    local command = ...;
    FlipToggle("Messages", command);
  end,
  ["combat"] = function(self, ...)
    local command = ...;
    FlipToggle("CombatResurrect", command);
  end,
}



--Setup our command aliases
SLASH_AUTORESURRECT1 = "/ar";
SLASH_AUTORESURRECT2 = "/autoresurrect";

--Setup our command Handler
SlashCmdList["AUTORESURRECT"] = function(self, txt)
  local args = SplitArgs(txt);
  
  Commands[args[1]](args[2])
end