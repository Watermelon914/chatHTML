local CONFIG = wmChat.anonyChat.config

GM = GM or GAMEMODE

local onKeyCodeTyped = wmChat.dTextEntry.OnKeyCodeTyped

wmChat.dTextEntry.OnKeyCodeTyped = function(self, code)
    if code == KEY_ENTER then
        if string.Trim( self:GetText() ) != "" then
			RunConsoleCommand("anony_say", self:GetText())
		end

        wmChat.Close()
        return true
    end

    local boolFromChatHTML = onKeyCodeTyped(self, code)

    return boolFromChatHTML
end

local playErrorSound = 0
wmChat.dTextEntry.AllowInput = function(self, char)
    local value = self:GetValue()
    if #value >= CONFIG.MaxChatLimit then
        if playErrorSound < CurTime() then
            surface.PlaySound(CONFIG.ErrorSound)
            playErrorSound = CONFIG.NextErrorSound + CurTime()
        end
        return true
    end
end

local function getPlyName(ply)
    if (IsValid(ply)) then
        return ply:GetName()
    else
        return "Unknown"
    end
end

if not GM then
    timer.Simple(2, function()
        include("anonyChat/cl_chat.lua")
    end)
    return
end

function GM:OnPlayerChat(ply, strText, bTeamOnly, bPlayerIsDead )
    return
end

net.Receive("anonyChatSendMessage", function(len)
    local chatObject = chat.GetChat(net.ReadString()) // The chat object
    local ply = net.ReadEntity() // The sender
    local msg = net.ReadString() // The chat message

    local channels = net.ReadUInt(16)

    local chats = {}
    for i=1, channels do
        table.insert(chats, chat.GetChat(net.ReadString()))
    end

    local argsCount = net.ReadUInt(16)
    local args = {}
    for i=1, argsCount do
        table.insert(args, net.ReadString())
    end

    local tab = {}
    
    if IsValid(ply) and ply:IsPlayer() then
        tab = chatObject.messageReceivedByPlayer(chatObject, ply, msg, args, chats)

        if hook.Run("OnPlayerChat", ply, msg, false, ply:Alive()) then
            return
        end
    else
        tab = chatObject.messageReceived(chatObject, msg, args, chats)
    end

    chat.AddText(unpack(tab))
end)