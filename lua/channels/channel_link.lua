CHANNEL.Name = "Default"

CHANNEL.isDefault = true
CHANNEL.Styles = { // Styles to implement when using messageSent
    bold = {
        ["color"] = Color(0, 0, 0),
        ["font-weight"] = "bold",
        ["font-size"] = "1em",
    },
    normal = {
        ["color"] = Color(255, 255, 255),
        ["font-size"] = "1em",
    },
}
    
CHANNEL.canHearMessage = function(self, sender, listener, msg) return true end // Run a function for whether the player can hear this message or not
CHANNEL.shouldSend = function(self, ply, msg) return true end // Run a function for whether a message should go to this chat or not

CHANNEL.messageSent = function(self, ply, msg) return msg end

local extensionNames = {
    ["jpeg"] = true,
    ["jpg"] = true,
    ["gif"] = true,
    ["png"] = true,
}

local whitelistedSites = { // No need to add it yet. Maybe in the future
    ["https://cdn.discordapp.com/attachments/"] = true,
}

CHANNEL.messageReceivedByPlayer = function(self, ply, msg, args, chats) //This is called when the client receives the messages from another player
    local tab = {}
    local styles = table.Copy(self.Styles) 

    table.insert(tab, styles.bold)
    table.insert(tab, ply:GetName())

    table.insert(tab, ": ")
    table.insert(tab, styles.normal)

    local msgExploded = string.Split(msg, " ", false)

    for _, str in ipairs(msgExploded) do
        local strSplitted = string.Split(str, ".")
        local extensionName = strSplitted[#strSplitted]
        if extensionNames[extensionName] and (string.sub(str, 1, 7) == "http://" or string.sub(str, 1, 8) == "https://") then
            table.insert(tab, {image={source=str, scaleToFit=50}, ["vertical-align"]="middle"})
        else 
            table.insert(tab, str .. " ")
        end
    end

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

CHANNEL.priority = -5 //This effectively disables it
CHANNEL.orderPriority = 0