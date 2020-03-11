AddCSLuaFile()

wmChat.anonyChat.config = wmChat.anonyChat.config or {}

local CONFIG = wmChat.anonyChat.config

wmChat.anonyChat.__chats = {}

if SERVER then
    chat = chat or {}
end

function chat.GetAllChats()
    return wmChat.anonyChat.__chats
end

function chat.GetChat(className)
    return chat.GetAllChats()[className]
end

function chat.GetName(className)
    return chat.GetChat(className).Name
end

function chat.GetChatsForMsg(ply, msg)
    local chats, chatsToSendTo, highestPriority = chat.GetAllChats(), {}, 0

    
    for index, chatObject in pairs(chats) do
        if chatObject.shouldSend(chatObject, ply, msg) then
            table.insert(chatsToSendTo, chatObject)
            highestPriority = chatObject.priority > highestPriority and chatObject.priority or highestPriority 
        end
    end

    local priorityFilter = {}
    for index, chatObject in pairs(chatsToSendTo) do
        if chatObject.priority == highestPriority then
            table.insert(priorityFilter, chatObject)
        end
    end

    return priorityFilter

end

function chat.GetCanSeePlayers(className, sender, msg)
    local chatObject = chat.GetChat(className)

    local players = player.GetAll()

    local playersWhoCanSeeChat = {}
    for _, ply in pairs(players) do
        if chatObject.canHearMessage(chatObject, sender, ply, msg) then
            playersWhoCanSeeChat[ply:EntIndex()] = ply
        end
    end

    return playersWhoCanSeeChat
end