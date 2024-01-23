-- Dolby Vision to HDR10 v1.0 by Nino
-- https://github.com/Ninelpienel/Plex-Scripts

local function dv_to_hdr10()
	local plex_media = mp.get_property("user-data/plex/playing-media")
	local dovi_present = string.match(plex_media, '"DOVIPresent":true');
	local color_primaries = string.match(plex_media, '"colorPrimaries":"bt2020"');

	if dovi_present == '"DOVIPresent":true' and color_primaries == nil then
		mp.set_property("target-trc", "pq")
		mp.set_property("target-colorspace-hint", "yes")
		mp.add_timeout(1, function()
			mp.osd_message('Dolby Vision converted to HDR10!')
		end)
	end
end

local function dv_to_hdr10_reset()
	mp.set_property("target-trc", "auto")
	mp.set_property("target-colorspace-hint", "no")	
end

mp.register_event("file-loaded", dv_to_hdr10)
mp.register_event("end-file", dv_to_hdr10_reset)