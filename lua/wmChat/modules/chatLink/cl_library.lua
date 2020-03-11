local function rgbToHex(col)
    local r, g, b = bit.tohex(col.r, 2), bit.tohex(col.g, 2), bit.tohex(col.b, 2)

    return tostring(r .. g .. b)
end

hook.Add("wmChat.ChatTextAdd", "chatLink_link", function(arg)

    if istable(arg) and arg.link then
        local spanBuffer = "<span>"
        local styleBuffer = ""
        for styleName, style in pairs(arg) do

            if styleName == "link" then continue end

            if IsColor(style) then
                style = rgbToHex(style)
            end

            if istable(style) then
                continue
            end

            styleName, style = chat.RemoveHTMLTags(styleName), chat.RemoveHTMLTags(style)
            styleBuffer = styleBuffer .. styleName .. ": " .. tostring(style) .. ";"
        end

        local argumentBuffer = {} 
        for _, argument in pairs(arg.link["arguments"]) do

            if type(argument) == "string" then
                argument = "\\\"" .. argument .. "\\\""
            end

            table.insert(argumentBuffer, argument)

        end




        spanBuffer = spanBuffer .. 
            "<a href=\"javascript:void(0)\" onclick='console.log(\"RUNLUA:" .. string.JavascriptSafe(chat.RemoveHTMLTags(arg.link["functionName"])) .. "("..table.concat(argumentBuffer, ", ")..")\")', " .. 
            "style=\""..styleBuffer.."\">"..chat.RemoveHTMLTags(arg.link["text"]).."</a></span>"

        return true, spanBuffer, arg.link["text"] -- Prevent default behaviour. Adds custom HTML arguments to the buffer instead
    end

end)
