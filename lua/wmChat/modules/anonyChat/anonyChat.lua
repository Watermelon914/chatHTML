AddCSLuaFile()

wmChat.anonyChat = wmChat.anonyChat or {}

include("anonyChat/sh_library.lua")

include("anonyChat/loader.lua")

include("anonyChat/sh_config.lua")

if SERVER then

    AddCSLuaFile("anonyChat/cl_chat.lua")

    include("anonyChat/sv_chat.lua")

else

    include("anonyChat/cl_chat.lua")

end

print("Watermelon's Modular Text Chat")
