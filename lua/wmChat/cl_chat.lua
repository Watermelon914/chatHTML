if wmChat then
    if IsValid(wmChat.dFrameHtml) then
        wmChat.dFrameHtml:Remove()
    end
end

GM = GM or GAMEMODE

local CONFIG = wmChat.config

wmChat.dFrameHtml = vgui.Create("DFrame")

if !IsValid(wmChat.dFrameHtml) then
    timer.Simple(2, function()
        include("wmChat/cl_chat.lua")
    end)
    return
end

wmChat.dFrameHtml.Paint = function(self) end

wmChat.dFrameHtml:SetTitle("")

wmChat.dFrameHtml:SetDraggable(false)
wmChat.dFrameHtml:SetDeleteOnClose(false)
wmChat.dFrameHtml:ShowCloseButton(false)

wmChat.dFrame = vgui.Create("DFrame", wmChat.dFrameHtml)

wmChat.dFrame:SetTitle("Watermelon's Chat Box")

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

    if code == KEY_ENTER then
        if string.Trim( self:GetText() ) != "" then
			LocalPlayer():ConCommand("say \""..self:GetText().."\"")
		end

        wmChat.Close()
        return true
    end
end

wmChat.dHtml = vgui.Create("DHTML", wmChat.dFrameHtml)

function wmChat.dHtml:Think()
    self:MoveToAfter(wmChat.dFrame)
end

wmChat.dHtml:SetAllowLua(true)
wmChat.dHtml:Dock(TOP)
wmChat.dHtml:SetSize(length, height*0.8)
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