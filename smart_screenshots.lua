-- Smart Screenshots v2.0 by Nino
-- https://github.com/Ninelpienel/Plex-Scripts

function screenshot()
    local media, file
	
	timedate = os.date("%Y%m%d_%H.%M.%S")
	
    dir = mp.get_property_native("screenshot-directory")
    if (string.len(dir) > 0) then dir = dir..'/' end
    dir = mp.command_native({"expand-path", dir})
	
    media = mp.get_property("user-data/plex/playing-media")
	
	media_typ = media:match('"type":"([%w_]+)","updatedAt"')
	
	if media_typ == 'episode' then
		media_cut = media:sub(media:find('grandparentTitle')+19, #media)
		title = media_cut:sub(0,media_cut:find('guid')-4)
		title = title:gsub("[%<%>%:%\"%/\\|%?%*]", "")
		epnumber = media_cut:sub(media_cut:find('index')+7,media_cut:find('key')-3)
		epnumber = string.format("%02d", tonumber(epnumber))
		snumber = tonumber(media_cut:match('"parentIndex":(%d+)') or 0)
		snumber = string.format("%02d", tonumber(snumber))
	
		position = mp.get_property_osd("time-pos")
		positionf=string.gsub(position,"[:]",".")
	
		mp.commandv("screenshot-to-file", dir..timedate.."_"..title.." - S"..snumber.."E"..epnumber.." ("..positionf..").png")
		mp.osd_message('Screenshot created!')
	end
	
	if media_typ == 'movie' then
		title = media:match(',"title":"([^"]+)","type"') or media:match(',"title":"([^"]+)","titleSort"')
		title = title:gsub("[%<%>%:%\"%/\\|%?%*]", "")
		
		position = mp.get_property_osd("time-pos")
		positionf=string.gsub(position,"[:]",".")
	
		mp.commandv("screenshot-to-file", dir..timedate.."_"..title.." ("..positionf..").png")
		mp.osd_message('Screenshot created!')
	end
	return nil
end

function screenshot_no_subs()
    local media, file
	
	timedate = os.date("%Y%m%d_%H.%M.%S")
	
    dir = mp.get_property_native("screenshot-directory")
    if (string.len(dir) > 0) then dir = dir..'/' end
    dir = mp.command_native({"expand-path", dir})
	
    media = mp.get_property("user-data/plex/playing-media")
	
	media_typ = media:match('"type":"([%w_]+)","updatedAt"')
	
	if media_typ == 'episode' then
		media_cut = media:sub(media:find('grandparentTitle')+19, #media)
		title = media_cut:sub(0,media_cut:find('guid')-4)
		title = title:gsub("[%<%>%:%\"%/\\|%?%*]", "")
		epnumber = media_cut:sub(media_cut:find('index')+7,media_cut:find('key')-3)
		epnumber = string.format("%02d", tonumber(epnumber))
		snumber = tonumber(media_cut:match('"parentIndex":(%d+)') or 0)
		snumber = string.format("%02d", tonumber(snumber))
	
		position = mp.get_property_osd("time-pos")
		positionf=string.gsub(position,"[:]",".")
	
		mp.commandv("screenshot-to-file", dir..timedate.."_"..title.." - S"..snumber.."E"..epnumber.." ("..positionf..").png", "video")
		mp.osd_message('Screenshot created without subs!')
	end
	
	if media_typ == 'movie' then
		title = media:match(',"title":"([^"]+)","type"') or media:match(',"title":"([^"]+)","titleSort"')
		title = title:gsub("[%<%>%:%\"%/\\|%?%*]", "")
		
		position = mp.get_property_osd("time-pos")
		positionf=string.gsub(position,"[:]",".")
	
		mp.commandv("screenshot-to-file", dir..timedate.."_"..title.." ("..positionf..").png", "video")
		mp.osd_message('Screenshot created without subs!')
	end
	return nil
end

function qc_screenshot()
    local media, file
	local format="{\\an8\\fs18\\bord1.2\\c&HFFFFFF&\\3c&H000074&\\b1}"
	
	timedate = os.date("%Y%m%d_%H.%M.%S")
	
    dir = mp.get_property_native("screenshot-directory")
    if (string.len(dir) > 0) then dir = dir..'/' end
    dir = mp.command_native({"expand-path", dir})
	
	qcdir = mp.command_native({"expand-path", dir.."QC/"})
	
    media = mp.get_property("user-data/plex/playing-media")
	
	media_typ = media:match('"type":"([%w_]+)","updatedAt"')
	
	if media_typ == 'episode' then
		media_cut = media:sub(media:find('grandparentTitle')+19, #media)
		title = media_cut:sub(0,media_cut:find('guid')-4)
		titlef = title:gsub("[%<%>%:%\"%/\\|%?%*]", "")
		epnumber = media_cut:sub(media_cut:find('index')+7,media_cut:find('key')-3)
		epnumber = string.format("%02d", tonumber(epnumber))
		snumber = tonumber(media_cut:match('"parentIndex":(%d+)') or 0)
		snumber = string.format("%02d", tonumber(snumber))
	
		position = mp.get_property_osd("time-pos")
		positionf=string.gsub(position,"[:]",".")
	
		msg=format..title.." – S"..snumber.."E"..epnumber.." ("..position..")"
	
		mp.osd_message(mp.get_property_osd("osd-ass-cc/0")..msg..mp.get_property_osd("osd-ass-cc/1"), 4)
		mp.add_timeout(0.1, function()
			mp.commandv("screenshot-to-file", qcdir..timedate.."_"..titlef.." - S"..snumber.."E"..epnumber.." ("..positionf..").png", "window")
		end)
	end
	
	if media_typ == 'movie' then
		title = media:match(',"title":"([^"]+)","type"') or media:match(',"title":"([^"]+)","titleSort"')
		titlef = title:gsub("[%<%>%:%\"%/\\|%?%*]", "")
		
		position = mp.get_property_osd("time-pos")
		positionf=string.gsub(position,"[:]",".")
	
		msg=format..title.." ("..position..")"
	
		mp.osd_message(mp.get_property_osd("osd-ass-cc/0")..msg..mp.get_property_osd("osd-ass-cc/1"), 4)
		mp.add_timeout(0.1, function()
			mp.commandv("screenshot-to-file", qcdir..timedate.."_"..titlef.." ("..positionf..").png", "window")
		end)
	end
	return nil
end

-- Define your key bindings here.

mp.add_forced_key_binding("ä", "screenshot", screenshot)
mp.add_forced_key_binding("ö", "screenshot_no_subs", screenshot_no_subs)
mp.add_forced_key_binding("ü", "qc_screenshot", qc_screenshot)
