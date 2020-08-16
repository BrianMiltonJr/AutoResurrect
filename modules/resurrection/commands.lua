--addon AutoResurrect: modules/resurrection/commands

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

    --Used to print in memory vars to console
    ["print"] = function(...)
        local command = ...;
        for i,v in ipairs(command) do
            local obj = NS[v];
            if obj == nil then NS.funcs.Debug("The property "..v.." does not exists"); return nil; end

            NS.funcs.Debug(v);
            for k1,v1 in pairs(obj) do
                NS.funcs.Debug("  "..k1..": "..NS.funcs.ToString(v1).."");
            end
        end
    end,

    --Personal Test Command
    ["test"] = function()
        --NS.funcs.GetChatChannel();
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

    if Commands[Command] ~= null then
        Commands[Command](args);
    else
        print(txt.." is not a valid command, please try again");
    end
end