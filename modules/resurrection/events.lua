--addon AutoResurrect: modules/resurrection/events

local addonName, NS = ...;

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