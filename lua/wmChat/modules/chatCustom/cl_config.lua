wmChat.chatCustom.config = wmChat.chatCustom.config or {}

local CONFIG = wmChat.chatCustom.config

local w, h = chat.GetChatBoxSize()

CONFIG.MinWidth = 300 // Can't be larger than the chatbox
CONFIG.MinHeight = 200



CONFIG.MinWidth = math.min(CONFIG.MinWidth, w)
CONFIG.MinHeight = math.min(CONFIG.MinHeight, h)
CONFIG.MaxFontSize = 50

CONFIG.Fonts = {
    ["georgia"] = "Georgia, serif",
    ["palatino linotype"] = "\"Palatino Linotype\", \"Book Antiqua\", Palatino, serif",
    ["times new roman"] = "\"Times New Roman\", Times, serif",
    ["arial"] = "Arial, Helvetica, sans-serif",
    ["arial black"] = "\"Arial Black\", Gadget, sans-serif",
    ["comic sans"] = "\"Comic Sans MS\", cursive, sans-serif",
    ["impact"] = "Impact, Charcoal, sans-serif",
    ["lucida sans unicode"] = "\"Lucida Sans Unicode\", \"Lucida Grande\", sans-serif",
    ["tahoma"] = "Tahoma, Geneva, sans-serif",
    ["trebuchet"] = "\"Trebuchet MS\", Helvetica, sans-serif",
    ["verdana"] = "Verdana, Geneva, sans-serif",
    ["courier new"] = "\"Courier New\", Courier, monospace",
    ["lucida console"] = "\"Lucida Console\", Monaco, monospace",
}