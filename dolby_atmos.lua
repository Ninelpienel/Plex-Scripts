-- Dolby Atmos Auto Pass-through v1.0 by Nino
-- https://github.com/Ninelpienel/Plex-Scripts

function check_audio_title()
    local audio_title = mp.get_property("current-tracks/audio/title")
	local aid = mp.get_property("aid")

    if audio_title and string.match(audio_title, "Atmos") then
        mp.set_property("audio-spdif", "eac3,truehd")
		mp.add_timeout(0.1, function()
			mp.set_property("aid", "no")
		end)
		mp.add_timeout(0.1, function()
			mp.set_property("aid", aid)
		end)
		mp.osd_message('Atmos pass-through activated!')
    end
end

mp.register_event("file-loaded", check_audio_title)