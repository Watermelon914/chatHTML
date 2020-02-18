wmChat = wmChat or {}

function wmChat:MakeSafe(text)
    text = string.gsub(text, "<", "&lt;")
    text = string.gsub(text, ">", "&gt;")

    return text
end

include("wmChat/core/sh_config.lua")

if SERVER then

    resource.AddSingleFile("resource/wmChat/styles.css")
    resource.AddSingleFile("resource/wmChat/chat.html")
    resource.AddSingleFile("resource/wmChat/script.js")

    AddCSLuaFile("wmChat/core/cl_library.lua")
    AddCSLuaFile("wmChat/core/cl_chat.lua")

    include("wmChat/core/sv_chat.lua")

else

    include("wmChat/core/cl_library.lua")
    include("wmChat/core/cl_chat.lua")



end

local function LoadModules()
    local _, modules = file.Find("wmChat/modules/*", "LUA")

    for _, mod in pairs(modules) do // Loads in modules
        include("wmChat/modules/"..mod.."/"..mod..".lua")
    end
end

if wmChat.ChatLoaded or SERVER then 

    LoadModules()

elseif CLIENT then
    timer.Create("wmChat.LoadChat", 1, 0, function()
        include("wmChat/core/cl_chat.lua")

        if wmChat.ChatLoaded then 
            LoadModules()
            timer.Remove("wmChat.LoadChat")
        end
    end)
end

print("Watermelon's HTML Chat Script")