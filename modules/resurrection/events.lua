--addon AutoResurrect: modules/resurrection/events
local addonName, NS = ...;

Events = {
    -- Fires whenever we die
    ["PLAYER_DEAD"] = function(self, ...) 
      NS.funcs.SendMessage(NS.Messages.Dead, nil, NS.Messages.Language);
    end,
    
    -- Fires whenever we are in range of our corpse
    ["CORPSE_IN_RANGE"] = function(self, ...) 
      AcceptResurrect();
    end,
  
    -- Fires when you run back to corpse
    ["PLAYER_UNGHOST"] = function(self, ...) 
      NS.funcs.SendMessage(NS.Messages.Unghost, nil, NS.Messages.Language);
    end,
  
    -- Fires when you receive a summon
    ["CONFIRM_SUMMON"] = function(self, ...) 
      NS.funcs.SendMessage(NS.Messages.Thanks.Summon, nil, NS.Messages.Language);
      ConfirmSummon();
    end,
  
    -- Fires when being Resurrected
    ["RESURRECT_REQUEST"] = function(self, ...) 
      local sender = ...;
      if (NS.Toggles.CombatStatus and NS.Toggles.CombatResurrect) or not NS.Toggles.CombatStatus then
        NS.funcs.SendMessage(NS.Messages.Thanks.Resurrect, 'WHISPER', NS.Messages.Language, sender);
        AcceptResurrect();
      end
    end,
  
    -- Fires when Entering Combat
    ["PLAYER_REGEN_DISABLED"] = function(self, ...) 
      NS.Toggles.CombatStatus = true;
    end,

    -- Fires when Leaving Combat
    ["PLAYER_REGEN_ENABLED"] = function(self, ...) 
      NS.Toggles.CombatStatus = false;
    end,

}

--Registers all of our Events to our Frame
for k,v in pairs(Events) do
    NS.Frame:RegisterEvent(k);
end
  
--Runs our event handler is we are enabled else we print we are disabled
NS.Frame:SetScript("OnEvent", function(self, event, ...)
    if Events[event] ~= nil and NS.Toggles.Enabled then
        Events[event](...);
    else
        print(NS.Messages..Combat.Disabled);
    end
end)