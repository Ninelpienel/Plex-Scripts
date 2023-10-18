-- Smart Deband v1.0 by Nino
-- https://github.com/Ninelpienel/Plex-Scripts

local mp = require("mp")
local utils = require("mp.utils")

-- Define your whitelist and blacklist paths here.

local whitelist = "C:/Users/<your user>/AppData/Local/Plex HTPC/scripts/smart_deband_whitelist.txt"
local blacklist = "C:/Users/<your user>/AppData/Local/Plex HTPC/scripts/smart_deband_blacklist.txt"

function deband()
    local media = mp.get_property("user-data/plex/playing-media")
    local bit_depth = tonumber(media:match('"bitDepth":(%d+)'))
	local ref_frames = tonumber(media:match('"refFrames":(%d+)'))

    if bit_depth == 8 then
		mp.set_property("deband", "yes")
	end
	
	if ref_frames == 12 then
		mp.set_property("deband", "no")
	end
end

function deband_whitelist_keywords()
    local keywords = {}
    local file = io.open(whitelist, "r")

    if file then
        for line in file:lines() do
            table.insert(keywords, line)
        end
        file:close()
    end

    return keywords
end

function deband_whitelist()
    local media = mp.get_property("user-data/plex/playing-media")

    local keywords = deband_whitelist_keywords()

    local file_text = media:match('"file":"(.-)"')

    if file_text then
        for _, keyword in ipairs(keywords) do
            if string.match(file_text, keyword) then
                mp.set_property("deband", "yes")
                return
            end
        end
    end
end

function deband_blacklist_keywords()
    local keywords = {}
    local file = io.open(blacklist, "r")

    if file then
        for line in file:lines() do
            table.insert(keywords, line)
        end
        file:close()
    end

    return keywords
end

function deband_blacklist()
    local media = mp.get_property("user-data/plex/playing-media")

    local keywords = deband_blacklist_keywords()

    local file_text = media:match('"file":"(.-)"')

    if file_text then
        for _, keyword in ipairs(keywords) do
            if string.match(file_text, keyword) then
                mp.set_property("deband", "no")
                return
            end
        end
    end
end

mp.register_event("start-file", deband)
mp.register_event("start-file", deband_whitelist)
mp.register_event("start-file", deband_blacklist)
