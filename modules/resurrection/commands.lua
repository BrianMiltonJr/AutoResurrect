--addon AutoResurrect: modules/resurrection/commands
local addonName, NS = ...;

Commands = {
    --Enables and Disables the addon from executing
    ["status"] = function(self, ...)
        local command = ...;
        NS.funcs.FlipToggle("Enabled", command);
    end,

    --Enables and Disables messages addon posts to chat
    ["messages"] = function(self, ...)
        local command = ...;
        NS.funcs.FlipToggle("Messages", command);
    end,

    --Enables and Disables accepting resurrects during combat
    ["combat"] = function(self, ...)
        local command = ...;
        NS.funcs.FlipToggle("CombatResurrect", command);
    end,

    ["print"] = function(self, ...)
        for k,v in pairs(...) do
            NS.funcs.Debug(k);
            for k1,v1 in pairs(v) do
                NS.funcs.Debug(k1, v1);
            end
        end
    end,
}

--Setup our command aliases
SLASH_AUTORESURRECT1 = "/ar";
SLASH_AUTORESURRECT2 = "/autoresurrect";

--Setup our command Handler
SlashCmdList["AUTORESURRECT"] = function(txt)
    local split = NS.funcs.SplitArgs(txt);
    local Command = split[1];
    local args = {};
    for i=2, #split do
        table.insert(args, split[i]);
    end

    Commands[Command](args);
end