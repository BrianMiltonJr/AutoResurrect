--addon AutoResurrect: index
local addonName, NS = ...;

NS.Frame = CreateFrame("Frame");

--The messages our addon spits out
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

--Whether certain features are enabled of disabled
NS.Toggles = {
  ["CombatResurrect"] = true, --Accept Rez during Combat
  ["Messages"] = true, --Post messages in chat
  ["CombatStatus"] = false, --Are we in combat
  ["Enabled"] = true, --Is the addon enabled
  ["Debug"] = true, --Do we print Debug information to chat
};