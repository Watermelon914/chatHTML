AddCSLuaFile()

local channelTbl = chat.GetAllChats()

local bases = file.Find("channels/bases/*.lua", "LUA")
local channels = file.Find("channels/*.lua", "LUA")

local index = 1

//Load in the base file for everything

CHANNEL = {}
CHANNEL.Index = index
AddCSLuaFile("baseChannel/channel_default.lua")
include("baseChannel/channel_default.lua")

CHANNEL.FileName = "channel_default"

if !wmChat.anonyChat.allFilesLoaded then 
    baseclass.Set(CHANNEL.FileName, CHANNEL)
end

channelTbl[CHANNEL.FileName] = CHANNEL

index = index + 1


//Load the bases in first
for _, file in pairs(bases) do --Goes through the item folder and iterates through each team folder
    CHANNEL = {}
    CHANNEL.Index = index 

    AddCSLuaFile("channels/bases/"..file)
    include("channels/bases/"..file) --Each folder needs a file in it with the folder's name

    table.Inherit(CHANNEL, channelTbl["channel_default"])
    table.Inherit(CHANNEL.Styles, channelTbl["channel_default"].Styles)

    CHANNEL.FileName = string.sub(file, 1, string.len(file)-4)

    if !wmChat.anonyChat.allFilesLoaded then 
        baseclass.Set(CHANNEL.FileName, CHANNEL)
    end

    channelTbl[CHANNEL.FileName] = CHANNEL

    index = index + 1

end

//Load the regular channels in next
for _, file in pairs(channels) do --Goes through the item folder and iterates through each team folder
    CHANNEL = {}
    CHANNEL.Index = index 
    
    AddCSLuaFile("channels/"..file)
    include("channels/"..file) --Each folder needs a file in it with the folder's name

    local base = channelTbl[CHANNEL.Base] or channelTbl["channel_default"]

    table.Inherit(CHANNEL, base)
    table.Inherit(CHANNEL.Styles, base.Styles)

    CHANNEL.FileName = string.sub(file, 1, string.len(file)-4)

    if !wmChat.anonyChat.allFilesLoaded then 
        baseclass.Set(CHANNEL.FileName, CHANNEL)
    end
    channelTbl[CHANNEL.FileName] = CHANNEL

    index = index + 1

end

CHANNEL = nil

wmChat.anonyChat.allFilesLoaded = true