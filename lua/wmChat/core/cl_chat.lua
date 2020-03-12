if wmChat then
    if IsValid(wmChat.dFrameHtml) then
        wmChat.dFrameHtml:Remove()
    end
end

GM = GM or GAMEMODE

local CONFIG = wmChat.config

wmChat.dFrameHtml = vgui.Create("DFrame")

if !IsValid(wmChat.dFrameHtml) then
    wmChat.ChatLoaded = false
    return
end
wmChat.ChatLoaded = true

wmChat.dFrameHtml.Paint = function(self) end

wmChat.dFrameHtml:SetTitle("")

wmChat.dFrameHtml:SetDraggable(false)
wmChat.dFrameHtml:SetDeleteOnClose(false)
wmChat.dFrameHtml:ShowCloseButton(false)

wmChat.dFrame = vgui.Create("DFrame", wmChat.dFrameHtml)

wmChat.dFrame.Paint = function(self, w, h)

    local top = 24
    local bottom = 32

    local sideThickness = 2

    // The top of the chatbox
    draw.RoundedBoxEx(4, 0, 0, w, top, Color(50, 50, 50, 255), true, true, false, false)

    // The bottom of the chatbox
    draw.RoundedBoxEx(4, 0, h-bottom, w, bottom, Color(80, 80, 80, 220), false, false, true, true)

    local totalHeightOfChat = h - (top+bottom)

    // The sides of the chatbox
    surface.SetDrawColor(Color(80, 80, 80, 220))
    surface.DrawRect(0, top, sideThickness, totalHeightOfChat)
    surface.DrawRect(w-sideThickness, top, sideThickness, totalHeightOfChat)

    // The body of the chatbox
    surface.SetDrawColor(Color(80, 80, 80, 150))
    surface.DrawRect(sideThickness, top, w - sideThickness*2, totalHeightOfChat)
end

wmChat.dFrame:SetTitle(CONFIG.ChatBoxTitle)

wmChat.dFrame:SetDraggable(false)
wmChat.dFrame:SetDeleteOnClose(false)
wmChat.dFrame:ShowCloseButton(false)

local x, y = chat.GetChatBoxPos()

local length, height = chat.GetChatBoxSize()

wmChat.dFrame:SetSize(length, height)
wmChat.dFrameHtml:SetSize(length, height)
wmChat.dFrameHtml:SetPos(x, y)

wmChat.dTextEntry = vgui.Create("DTextEntry", wmChat.dFrame)

wmChat.dTextEntry:Dock(BOTTOM)
wmChat.dTextEntry.OnKeyCodeTyped = function(self, code)
    if code == KEY_ESCAPE then
        gui.HideGameUI()
        wmChat.Close()
        return true
    end

    if code == KEY_FIRST then
        gui.HideGameUI()
    end

    if code == KEY_ENTER then
        if string.Trim( self:GetText() ) != "" then
			LocalPlayer():ConCommand("say \""..self:GetText().."\"")
		end

        wmChat.Close()
        return true
    end
end


wmChat.dTextEntry.AllowInput = function(self, char)
    local value = self:GetValue()
    if #value >= 255 then
        return true
    end
end

wmChat.dTextEntry:SetDrawBackground(false)

wmChat.dTextEntry.Paint = function(self, w, h)
    surface.SetDrawColor(Color(225, 225, 225, 220))
    surface.DrawRect(0, 0, w, h)

    derma.SkinHook( "Paint", "TextEntry", self, w, h )
end

wmChat.dHtml = vgui.Create("DHTML", wmChat.dFrameHtml)

function wmChat.dHtml:Think()
    self:MoveToAfter(wmChat.dFrame)
end

wmChat.dHtml:SetAllowLua(true)
wmChat.dHtml:Dock(TOP)
wmChat.dHtml:SetSize(length, height-56)
wmChat.dHtml:OpenURL("asset://garrysmod/resource/wmChat/chat.html")

wmChat.chatOpen = false


function wmChat.dFrame:Think()
    wmChat.dFrame:MoveToBefore(wmChat.dHtml)
end

hook.Add("HUDShouldDraw", "wmOverrideHUD", function( name )
    if name == "CHudChat" then
		return false
	end
end)

function wmChat.dFrame:Think()
    if wmChat.chatOpen then
        self.fadeVar = Lerp(RealFrameTime() * 30, self.fadeVar or 0, 255)
        self:SetAlpha(self.fadeVar)
    else
        self.fadeVar = Lerp(RealFrameTime() * 30, self.fadeVar or 255, 0)
        self:SetAlpha(self.fadeVar)
    end

end

hook.Add("PlayerBindPress", "wmOverrideChatBind", function(ply, bind, pressed)
    local bPublic = false
    if bind != "messagemode" and bind != "messagemode2" then
        return
    elseif bind == "messagemode" then
        bPublic = true
    end

    wmChat.Open(tonumber(bPublic))

    return true

end)

function GM:ChatText( index, name, text, type )
    local MessageConfig = wmChat.config.ConsoleMessageServer

    MsgC(MessageConfig.head, MessageConfig.name .. " ", MessageConfig.body, text .. "\n")
 
    local ServerMessageMetadata = {
        ["font-weight"] = "bold", 
        ["color"] = wmChat.config.ServerMessageColor,
    }

    chat.AddText(ServerMessageMetadata, text)

end