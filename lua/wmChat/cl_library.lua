
function wmChat.AddHTML(text)
    text = string.JavascriptSafe(text)
    wmChat.dHtml:RunJavascript( "document.getElementById(\"chat\").insertAdjacentHTML( \"beforeend\", \""..text.."\" );" )
    wmChat.dHtml:RunJavascript("window.scrollTo(0,document.body.scrollHeight);")
end

function wmChat.Close()

    wmChat.dHtml:RunJavascript("makeNormal(); clearSelection();")

    wmChat.chatOpen = false

    wmChat.dFrameHtml:SetKeyboardInputEnabled( false )
    wmChat.dFrameHtml:SetMouseInputEnabled( false )
	gui.EnableScreenClicker( false )


    -- We are done chatting
	gamemode.Call("FinishChat")
	
	-- Clear the text entry
	wmChat.dTextEntry:SetText( "" )
	gamemode.Call( "ChatTextChanged", "" )

end

function wmChat.Open()
    
    wmChat.dHtml:RunJavascript("makeAllOpaque()")

    wmChat.chatOpen = true

    wmChat.dFrameHtml:MakePopup()
    wmChat.dTextEntry:RequestFocus()

    gamemode.Call("StartChat")

end

local function rgbToHex(col)
    local r, g, b = bit.tohex(col.r, 2), bit.tohex(col.g, 2), bit.tohex(col.b, 2)

    return r .. g .. b
end

function chat.RemoveHTMLTags(str)
    return wmChat:MakeSafe(str)
end

wmChat.chatId = wmChat.chatId or 1
function chat.AddHTML(str) //Unsafe for user input. User input should be chat.RemoveHTMLTags
    local id = tostring(wmChat.chatId)

    wmChat.AddHTML("<div name=\"chatObject\" id=\""..id.."\" class=\"visible\" data-faded=0>"..str.."</div>")

    wmChat.dHtml:RunJavascript("makeFade(\""..id.."\", "..wmChat.config.ChatTimeFadeout..")")

    wmChat.chatId = wmChat.chatId + 1
end

function chat.AddText(...)
    local htmlBuffer = "<span>"

    local consoleBuffer = {}
    local args = {...}
    for _, arg in pairs(args) do
        if IsColor(arg) then
            local hexCol = rgbToHex(arg)

            htmlBuffer = htmlBuffer .. "</span><span style=\"color: #"..hexCol..";\">"

        elseif type(arg) == "string" then
            local safeArg = chat.RemoveHTMLTags(arg) // Prevent any HTML from being passed. Use AddHTML to add HTML to the chat or insert tables into chat.AddText with special arguments
            htmlBuffer = htmlBuffer .. safeArg

            table.insert(consoleBuffer, arg)
        elseif type(arg) == "table" then
            spanBuffer = "</span><span style=\""
            for styleName, style in pairs(arg) do

                if IsColor(style) then
                    style = rgbToHex(style)
                end

                if istable(style) then
                    continue
                end

                styleName, style = chat.RemoveHTMLTags(styleName), chat.RemoveHTMLTags(style)
                spanBuffer = spanBuffer .. styleName .. ": " .. tostring(style) .. ";"
            end
            spanBuffer = spanBuffer .. "\">"
            
            htmlBuffer = htmlBuffer .. spanBuffer
        elseif arg:IsPlayer() then
            local col = GM:GetTeamColor(arg)
            local hexCol = rgbToHex(col)
            htmlBuffer = htmlBuffer .. "</span><span style=\"color: #"..hexCol..";\">"

            htmlBuffer = htmlBuffer .. arg:GetName()

            table.insert(consoleBuffer, col)
            table.insert(consoleBuffer, arg)
        end

        
    end

    table.insert(consoleBuffer, "\n")

    Msg(unpack(consoleBuffer))

    htmlBuffer = htmlBuffer .. "</span>"
    chat.AddHTML(htmlBuffer)

end