--addon AutoResurrect: libs/helper
local addonName, NS = ...;

NS.funcs = {
    --If our Debug Toggle is set we print to chat.
    ["Debug"] = function(...) 
        if NS.Toggles.Debug then print(...); end 
    end,

     -- Handily checks if we can send a message.
    ["SendMessage"] = function(msg, channel, language, target)
        if NS.Toggles.Messages then SendChatMessage(msg, channel, language, target); end
    end,

    -- Sets our toggle to false or true if status == "off" or "on". If Status == null then we flip the toggle.
    ["FlipToggle"] = function(key, status)
        if NS.Toggles[key] == nil then return nil; end

        if status == "on" then 
            NS.Toggles[key] = true; 
        elseif status == "off" then 
            NS.Toggles[key] = false; 
        else 
            NS.Toggles[key] = not NS.Toggles[key]; 
            status = "Flip-op";
        end
        NS.funcs.Debug("You have toggled "..key.." to "..status..".");
    end,

    --Splits our Command Arguments. Currently only does Space.
    ["SplitArgs"] = function(txt, delimiter, start, j)
        if start == nil then start = 1; end
        if j == nil then j = #txt; end
        if delimiter == nil then delimiter = " "; end

        local arr = {};
        local pos = 1;

        for i = start, j do
            local char = strsub(txt, i, i);
            if arr[pos] == nil then arr[pos] = ""; end

            if char ~= delimiter then
                arr[pos] = arr[pos] .. char;
            else
                pos = pos+1
            end
        end

        if #arr > 0 then
            return arr;
        else
            return {txt};
        end
    end,
}

