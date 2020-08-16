--addon AutoResurrect: libs/helper

NS.funcs = {
    ["ToString"] = function(val)
        if val then return "true" elseif not val then return "false" else
            return val;
        end
    end,

    --If our Debug Toggle is set we print to chat.
    ["Debug"] = function(...) 
        if NS.Toggles.Debug then print(...); end 
    end,

    --Checks to see what Channels we can talk and picks one on priority
    ["GetChatChannel"] = function()
        local isInLocal, isInInstance = IsInGroup(LE_PARTY_CATEGORY_HOME), IsInGroup(LE_PARTY_CATEGORY_INSTANCE);
        local isRaid = IsInRaid();

        if isInLocal and isInInstance then --Player is in both an Instance and Party group
            if NS.Messages.FavoredChat == "instance" then
                return "INSTANCE_CHAT";
            else
                if isRaid then return "RAID"; else return "PARTY"; end
            end
            
        elseif isInInstance then --Player is only an Instance Group 
            return "INSTANCE_CHAT";

        elseif isInLocal then --Player is only in a Local Party
            if isRaid then return "RAID"; else return "PARTY" end
        end

    end,

     -- Handily checks if we can send a message.
    ["SendMessage"] = function(msg, channel, language, target)
        if channel == nil then channel = NS.funcs.GetChatChannel(); end
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