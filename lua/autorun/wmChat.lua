wmChat = wmChat or {}

function wmChat:MakeSafe(text)
    text = string.gsub(text, "<", "&lt;")
    text = string.gsub(text, ">", "&gt;")

    return text
end

include("wmChat/sh_config.lua")

if SERVER then

    resource.AddSingleFile("resource/wmChat/styles.css")
    resource.AddSingleFile("resource/wmChat/chat.html")
    resource.AddSingleFile("resource/wmChat/script.js")

    AddCSLuaFile("wmChat/cl_library.lua")
    AddCSLuaFile("wmChat/cl_chat.lua")

    include("wmChat/sv_chat.lua")

else

    include("wmChat/cl_library.lua")
    include("wmChat/cl_chat.lua")

end

include("anonyChat/anonyChat.lua")

print("Watermelon's HTML Chat Script")