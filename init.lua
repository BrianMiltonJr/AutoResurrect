--addon AutoResurrect: index
addonName, NS = ...;

NS.Frame = CreateFrame("Frame");

--The messages our addon spits out
NS.Messages = {
	["Thanks"] = {
		["Resurrect"] = "Thank you for resurrecting me.",
		["Summon"] = "Thank you for summoning me."
	},
	["Combat"] = {
		["Enabled"] = "Combat resurrections are enabled. Use the /ar combat off command to enable Combat Resurrections.",
		["Disabled"] = "Combat resurrections are disabled. Use the /ar combat on command to enable Combat Resurrections.",
	},
	["Unghost"] = "I walked back to my body.",
	["Dead"] = "I died, please resurrect me at your earliest convenience.",
	
	["Language"] = GetDefaultLanguage("player"),
	["FavoredChat"] = "instance",
};

--Whether certain features are enabled of disabled
NS.Toggles = {
	["CombatResurrect"] = true, --Accept Rez during Combat
	["Messages"] = true, --Post messages in chat
	["CombatStatus"] = false, --Are we in combat
	["Enabled"] = true, --Is the addon enabled
	["Debug"] = true, --Do we print Debug information to chat
};