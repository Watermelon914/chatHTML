AddCSLuaFile()

wmChat.chatCustom = wmChat.chatCustom or {}


if SERVER then

    AddCSLuaFile("cl_chat.lua")
    AddCSLuaFile("cl_config.lua")

else

    include("cl_config.lua")
    include("cl_chat.lua")

end

print("Watermelon's Chat Customiser")
