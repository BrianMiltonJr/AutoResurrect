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




Events = {
  -- Allows us to keep track of what Chat we are joining
  ["CHAT_MSG_CHANNEL_NOTICE"] = function(self, ...) 
    local text, playerName, languageName, channelName, playerName2, zoneChannelID, channelIndex, channelBaseName = ...;
    print(text, channelBaseName, channelName);
    if text == "YOU_CHANGED" then Messages.Chat = channelBaseName; end
  end,

  -- Fires whenever we die
  ["PLAYER_DEAD"] = function(self, ...) 
    SendMessage(Messages.Dead, Messages.Channel, Messages.Language);
  end,
  
  -- Fires whenever we are in range of our corpse
  ["CORPSE_IN_RANGE"] = function(self, ...) 
    AcceptResurrect();
  end,

  -- Fires when you run back to corpse
  ["PLAYER_UNGHOST"] = function(self, ...) 
    SendMessage(Messages.Dead, Messages.Unghost, Messages.Language);
  end,

  -- Fires when you receive a summon
  ["CONFIRM_SUMMON"] = function(self, ...) 
    SendMessage(Messages.Dead, Messages.Thanks.Summon, Messages.Language);
    ConfirmSummon();
  end,

  -- Fires when being Resurrected
  ["RESURRECT_REQUEST"] = function(self, ...) 
    local sender = ...;
    if (Toggles.CombatStatus and Toggles.CombatResurrect) or not Toggles.CombatStatus then
      SendMessage(Messages.Thanks.Resurrect, 'WHISPER', Messages.Language, sender);
      AcceptResurrect();
    end
  end,

  -- Fires when Entering Combat
  ["PLAYER_REGEN_DISABLED"] = function(self, ...) 
    Toggles.CombatStatus = true;
  end,

  -- Fires when Leaving Combat
  ["PLAYER_REGEN_ENABLED"] = function(self, ...) 
    Toggles.CombatStatus = false;
  end,
}

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

--Registers all of our Events to our Frame
for k,v in pairs(Events) do
  AutoResurrect:RegisterEvent(k);
end

--Runs our event handler is we are enabled else we print we are disabled
AutoResurrect:SetScript("OnEvent", function(self, event, ...)
  if Events[event] ~= nil and Toggles.Enabled then
    Events[event](...);
  else
    print(Messages.Disabled);
  end
end)

--Setup our command aliases
SLASH_AUTORESURRECT1 = "/ar";
SLASH_AUTORESURRECT2 = "/autoresurrect";

--Setup our command Handler
SlashCmdList["AUTORESURRECT"] = function(self, txt)
  local args = SplitArgs(txt);
  
  Commands[args[1]](args[2])
end