# HTML Chat
Made by Watermelon, edit the config file if you need to modify some stuff

``chat.AddText`` had to be modified to allow this to happen, but will not break any scripts that use it. Instead, with chat.AddText, you can now pass tables with CSS arguments that will apply those styles to the text that appears afterwards

## Modules
### AnonyChat
Anonychat is a module that makes the chat system modular.
Chat channels can be made by creating a folder in your LUA folder called "channels", and base channels (which automatically inherit from "channel_default") can be made by making a subfolder in your channels folder and calling it "bases". 

Channel class names will rely on the file name, so keep your file name simple

channel_default
```lua
CHANNEL.Name = "Default" -- Name of the channel

CHANNEL.Styles = { --Not mandatory, but helps organises the styles that you may use
    bold = {
        ["font-weight"] = "bold",
        ["font-size"] = "1em", -- Recommended to use em for chat size, so that players can resize the font for themselves if need be
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
    
CHANNEL.canHearMessage = function(self, sender, listener, msg) return true end -- Run a function for whether the player can hear this message or not
CHANNEL.shouldSend = function(self, ply, msg) return true end -- Run a function for whether a message should go to this chat or not

    
CHANNEL.messageSent = function(self, ply, msg) return msg end -- Used to add possible arguments onto the message

CHANNEL.messageReceivedByPlayer = function(self, ply, msg, args, chats) -- This is called when the client receives the messages from another player
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

CHANNEL.messageReceived = function(self, msg, args, chats) -- This is called when a client receives a message from a non-player entity (e.g. the world) or a null entity
    local tab = {}
    local styles = table.Copy(self.Styles) 

    table.insert(tab, styles.bold)
    
    if args[1] then 
        table.insert(tab, args[1]..": ")
    end

    table.insert(tab, msg)

    return tab
end

CHANNEL.priority = 0 -- This'll prevent it from sending to other chats if this value is higher than other chat values. Keep at 0 if you don't know what you're doing
CHANNEL.orderPriority = 0 -- Controls the order at which the channel appears. Higher == appears later (this'll appear at the top of every other message)
```

Default Config
```lua
CONFIG.MaxChatLimit = 350

CONFIG.ErrorSound = "ambient/alarms/klaxon1.wav"
CONFIG.NextErrorSound = 1
```

### Chat Customizability
Allows chat to be modified using various console commands.

#### Console Commands
``chat_anchor`` - This'll unanchor the chat
``chat_font_size`` - This'll set the default font size of the chat (will not affect those that do not use the em value)
``chat_font_style`` - This'll allow you to change the default font of the fonts in chat (will not affect those that set their font)

### Chat Image
Allows images to be uploaded to the chat from the internet and from local directories (asset://garrysmod/materials/..)

#### Usage
```lua
chat.AddText({
 image = {
  source = "icon16/user.png", -- The location of the image
  scaleToFit = true, -- Automatically scales the image to fit the chatbox, useful for very large images
  isLocal = true, -- This'll cause "asset://garrysmod/materials/" to be added before the source, so that it gets the image from a local directory
 },
 
 -- Extra args can be added here too to apply CSS effects to the image
})
```

### Chat Link
Allows chat links in chat to send lua functions clientside
Currently, image links are not supported right now

#### Usage
```lua
chat.AddText({
 link = {
  text = "Click Me!" -- Text needs to be contained here, not outside
  functionName = "print" -- Must be the name of the function, do not pass the function itself. Can also work with nested functions (e.g. chat.AddText)
  arguments = {
   LocalPlayer(), "clicked me!"
  }
 }
})
```
