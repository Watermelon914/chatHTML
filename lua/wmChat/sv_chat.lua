GM = GM or GAMEMODE

hook.Add("PlayerSay", "wmHTMLSafe", function(ply, msg, team)
    return wmChat:MakeSafe(msg)
end)