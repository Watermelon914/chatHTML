GM = GM or GAMEMODE

util.AddNetworkString("anonyChatSendMessage")

if not GM then
    timer.Simple(2, function()
        include("wmChat/modules/anonyChat/anonyChat/sv_chat.lua")
    end)
    return
end


local CONFIG = wmChat.anonyChat.config

local function anonyChatSendMessage(sender, chats, text, receivers, args) // Receivers and args is optional
    local channels = {}

    for _, chatObject in pairs(chats) do
        table.insert(channels, chatObject.FileName)
    end

    if !IsValid(sender) then
        sender = game.GetWorld()
    end

    local sortedChats = table.Copy(chats)

    table.sort(sortedChats, function(a, b)
        return a.orderPriority < b.orderPriority
    end)

    for index, chatObject in SortedPairs(sortedChats) do
        local players = chat.GetCanSeePlayers(chatObject.FileName, sender, text)

        if receivers then // Still won't be able to receive if you don't have access to the text channel
            if istable(receivers) then
                
                for index, ply in pairs(receivers) do
                    if !players[v:EntIndex()] then
                        table.remove(players, index)
                    end
                end

            elseif IsValid(receivers) and receivers:IsPlayer() then // If they sent only one person, it'll assist them here
                if players[receivers:EntIndex()] then
                    players = receivers
                end
            end
        end

        local orderedPlayerList = {}
        for _, v in pairs(players) do
            table.insert(orderedPlayerList, v)
        end

        net.Start("anonyChatSendMessage")
            net.WriteString(chatObject.FileName) //The index of the chatObject being sent
            net.WriteEntity(sender) //The sender of the message
            net.WriteString(text) // The message itself

            net.WriteUInt(#channels, 16) //The amount of chatObjects being sent
            for _, channel in ipairs(channels) do
                net.WriteString(channel, 16)
            end

            if args then
                net.WriteUInt(#args, 16)
                for _, argument in pairs(args) do
                    net.WriteString(argument)
                end
            else
                net.WriteUInt(0, 16)
            end

        net.Send(orderedPlayerList)

    end
end

function anony_say(sender, cmd, args, text)
    if string.sub(text, 1, 1) == "\"" then
        text = string.sub(text, 2, #text-1)
    end

    if #text > CONFIG.MaxChatLimit then
        text = string.sub(text, 1, CONFIG.MaxChatLimit)
    end

    if (sender.nextChatMsgDelay or 0) > CurTime() then return end

    text = wmChat:MakeSafe(text)

    local chats = sender.sendToChannels or chat.GetChatsForMsg(sender, text)
    sender.sendToChannels = nil

    if !chats then return end

    local text, channels = hook.Run("PlayerSay", sender, text, false) or text

    if istable(channels) then
        chats = channels or chats
    end

    if text == "" then return end

    local args = {}
    for index, chatObject in pairs(chats) do
        text, args = chatObject.messageSent(chatObject, sender, text)
    end

    if text == "" then return end

    anonyChatSendMessage(sender, chats, text, nil, args)
    sender.nextChatMsgDelay = CurTime() + 1

    return
end

concommand.Add("anony_say", anony_say, nil, nil, FCVAR_PRINTABLEONLY)

local pMeta = FindMetaTable("Player")

function pMeta:Say(text)
    channels = channels or nil
    
    self.nextChatMsgDelay = 0
    self:ConCommand("anony_say \""..text.."\"")

end

function pMeta:ChatPrint(text, channels)
    channels = channels or {chat.GetChat("channel_default")}


    anonyChatSendMessage(nil, channels, text)
end

function chat.SendChannel(className, text, name)

    if istable(className) then
        local chats = {}
    
        for k, v in pairs(className) do
            table.insert(chats, chat.GetChat(v))
        end

        anonyChatSendMessage(nil, chats, text, nil, {name})
    else
        anonyChatSendMessage(nil, {chat.GetChat(className)}, text, nil, {name})
    end
end