CHANNEL.Name = "Default"

CHANNEL.isDefault = true
CHANNEL.Styles = { // Styles to implement when using messageSent
    bold = {
        ["font-weight"] = "bold",
        ["font-size"] = "1em",
    },
    normal = {
        ["color"] = Color(255, 255, 255),
        ["font-size"] = "1em",
    },
    italic = {
        ["font-style"] = "italic",
        ["color"] = Color(255, 255, 255),
        ["font-size"] = "1em",
    }
}
    
CHANNEL.canHearMessage = function(self, sender, listener, msg) return true end // Run a function for whether the player can hear this message or not
CHANNEL.shouldSend = function(self, ply, msg) return true end // Run a function for whether a message should go to this chat or not

    
CHANNEL.messageSent = function(self, ply, msg) return msg end

CHANNEL.messageReceivedByPlayer = function(self, ply, msg, args, chats) //This is called when the client receives the messages from another player
    local tab = {}
    local styles = table.Copy(self.Styles) 

    styles.bold["color"] = team.GetColor(ply:Team())
    table.insert(tab, styles.bold)
    table.insert(tab, ply:GetName())
    table.insert(tab, styles.normal)

    table.insert(tab, ": ")

    if #chats > 1 then
        table.insert(tab, styles.italic)
    end

    table.insert(tab, msg)

    return tab
end

CHANNEL.messageReceived = function(self, msg, args, chats) //This is called when a client receives a message from a non-player entity (e.g. the world) or a null entity
    local tab = {}
    local styles = table.Copy(self.Styles) 

    table.insert(tab, styles.bold)
    
    if args[1] then 
        table.insert(tab, args[1]..": ")
    end

    table.insert(tab, msg)

    return tab
end

CHANNEL.priority = 0 //This'll prevent it from sending to other chats if this value is higher than other chat values. Keep at 0 if you don't know what you're doing
CHANNEL.orderPriority = 0