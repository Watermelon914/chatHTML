AddCSLuaFile()

wmChat.chatCustom = wmChat.chatCustom or {}

if SERVER then

    AddCSLuaFile("cl_chat.lua")


else

    include("cl_chat.lua")

end

print("Watermelon's Chat Customiser")
