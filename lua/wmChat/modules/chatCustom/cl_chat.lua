local chatCustom = wmChat.chatCustom

local CONFIG = chatCustom.config

chatCustom.LastMousePos = {
    x = 0,
    y = 0,
}
chatCustom.LastSize = {
    w = 0,
    h = 0,
}

local function ClearActions()
    chatCustom.IsDragging = false
    chatCustom.IsResizing = false
end

wmChat.dFrameHtml:SetMinWidth(CONFIG.MinWidth)
wmChat.dFrameHtml:SetMinHeight(CONFIG.MinHeight)

ClearActions()

function wmChat.dFrame:OnMousePressed(keyCode)
    if keyCode != MOUSE_FIRST or chatCustom.isAnchored then return end

    local x, y = self:LocalCursorPos()

    chatCustom.LastMousePos.x = x
    chatCustom.LastMousePos.y = y

    local sizeX, sizeY = self:GetSize()

    chatCustom.LastSize.w = sizeX
    chatCustom.LastSize.h = sizeY

    if y < 24 then // Top bar, for dragging
        chatCustom.IsDragging = true
    elseif x > sizeX - 30 and y > sizeY - 30 then
        chatCustom.IsResizing = true
    end
end

function wmChat.dFrame:OnMouseReleased(keyCode)
    if keyCode != MOUSE_FIRST then return end

    ClearActions()
end

function wmChat.dFrameHtml:Think()
    if chatCustom.IsDragging then 
        local x, y = gui.MousePos()

        local lastX, lastY = chatCustom.LastMousePos.x, chatCustom.LastMousePos.y

        self:SetPos(x-lastX, y-lastY)
    elseif chatCustom.IsResizing then
        local x, y = self:LocalCursorPos()
        local lastX, lastY = chatCustom.LastMousePos.x, chatCustom.LastMousePos.y
        local relativeX, relativeY = x-lastX, y-lastY

        local lastW, lastH = chatCustom.LastSize.w, chatCustom.LastSize.h

        local newSizeX, newSizeY = lastW + relativeX, lastH + relativeY

        newSizeX = math.max(newSizeX, self:GetMinWidth())
        newSizeY = math.max(newSizeY, self:GetMinHeight())

        self:SetSize(newSizeX, newSizeY)
        wmChat.dFrame:SetSize(newSizeX, newSizeY)
        wmChat.dHtml:SetSize(newSizeX, newSizeY-56)
    end

    if !input.IsMouseDown(MOUSE_FIRST) then 
        ClearActions()
    end 
end

concommand.Add("chat_anchor", function(ply, cmd, args, argStr)
    if chatCustom.isAnchored then
        chatCustom.isAnchored = false
        print("Chat is now unanchored. You are now able to drag and resize it")
    else
        chatCustom.isAnchored = true
        print("Chat is now anchored. You are no longer able to drag and resize it")
    end
end)

concommand.Add("chat_font_size", function(ply, cmd, args, argStr)
    if tonumber(argStr) then
        local newFontSize = math.min(math.max(tonumber(argStr), 8), CONFIG.MaxFontSize)

        wmChat.dHtml:RunJavascript('var chatElement = document.getElementById("chat"); chatElement.style.fontSize = "'..tostring(newFontSize)..'px"')
    end

end, nil, nil, FCVAR_CLIENTDLL)

concommand.Add("chat_font_style", function(ply, cmd, args, argStr)
    local newFont = string.JavascriptSafe(argStr)

    wmChat.dHtml:RunJavascript('var chatElement = document.getElementById("chat"); chatElement.style.fontFamily = "'..tostring(newFont)..'"')

end, function(cmd, args)
    local fonts = {}

    local argsLower = string.Trim(string.lower(args))

    for font, fontFull in pairs(CONFIG.Fonts) do

        if string.find(string.lower(fontFull), argsLower) then
            table.insert(fonts, cmd.." "..fontFull)
        end

    end

    if #fonts == 0 and args == "" then
        for font, fontFull in pairs(CONFIG.Fonts) do

            table.insert(fonts, cmd.." "..fontFull)

        end
    end 
    return fonts 

end, nil, FCVAR_CLIENTDLL)