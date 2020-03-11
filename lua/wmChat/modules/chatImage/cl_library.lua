local function rgbToHex(col)
    local r, g, b = bit.tohex(col.r, 2), bit.tohex(col.g, 2), bit.tohex(col.b, 2)

    return tostring(r .. g .. b)
end

hook.Add("wmChat.ChatTextAdd", "chatImage_image", function(arg)
    if istable(arg) and arg.image then
        local spanBuffer = "<span>"
        local styleBuffer = ""
        for styleName, style in pairs(arg) do

            if styleName == "image" then continue end

            if IsColor(style) then
                style = rgbToHex(style)
            end

            if istable(style) then
                continue
            end

            styleName, style = chat.RemoveHTMLTags(styleName), chat.RemoveHTMLTags(style)
            styleBuffer = styleBuffer .. styleName .. ": " .. tostring(style) .. ";"
        end

        local image = arg.image["source"]

        if arg.image["isLocal"] then
            image = "asset://garrysmod/materials/" .. image
        end

        local scaleToFitVar = arg.image["scaleToFit"]

        if scaleToFitVar then
            styleBuffer = styleBuffer .. "max-width: "..scaleToFitVar.."%;"
            styleBuffer = styleBuffer .. "max-height: "..scaleToFitVar.."%;"
        end

        spanBuffer = spanBuffer .. "<img src=\"" .. image .. "\" style=\""..styleBuffer.."\"></img></span>"

        return true, spanBuffer, "<img="..arg.image["source"]..">" -- Prevent default behaviour. Adds custom HTML arguments to the buffer instead



    end

end)