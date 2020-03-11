AddCSLuaFile()

wmChat.chatImage = wmChat.chatImage or {}

if SERVER then

    AddCSLuaFile("cl_library.lua")


else

    include("cl_library.lua")

end

print("Watermelon's Image Support")
