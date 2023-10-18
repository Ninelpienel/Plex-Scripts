# My Plex HTPC Script Collection

This is a collection of my personal Plex HTPC scripts.

I'm not really a programmer, but kind of cobbled most of the stuff together and tweaked it with ChatGPT. Maybe the scripts are still helpful.

## Smart Deband

This script activates the deband function of mpv if the video is in H.264 8-bit format. In addition, you can add exceptions via a whitelist and blacklist. Since mostly bad encodes or web rips are in H.264 8-bit, the debanding should only be applied to these videos.

### Step 1

Put [smart_deband.lua](https://github.com/Ninelpienel/Plex-Scripts/blob/main/smart_deband.lua) in `C:\Users\<your user>\AppData\Local\Plex HTPC\scripts`.

### Step 2

Create `smart_deband_blacklist.txt` and `smart_deband_whitelist.txt` in your desired folder.

Please update the paths in the lua file.

```
local whitelist = "C:/Your/desired/path/smart_deband_whitelist.txt"
local blacklist = "C:/Your/desired/path/smart_deband_blacklist.txt"
```

### Step 3

Please put the settings below into your mpv.conf file.

```
deband=no
deband-iterations=6
deband-threshold=64
deband-range=32
deband-grain=0
```

The file is located in `C:\Users\<your user>\AppData\Local\Plex HTPC`.

### Step 4

Now you just have to define which files outside the H.264 8-bit rule should be either additionally debanded (whitelisted) or excluded from this rule (blacklisted). You just have to put a part of the filename into the respective text file.

### Example

If you put `[Bad Encode] Random Anime` in the whitelist, the debanding will be applied even if the video is in HEVC or H.264 10-bit.

If you put `[Good Encode] Random Anime` in the blacklist, the debanding will not be applied even if the video is in H.264 8-bit.

## Smart Screenshot

With this script you can make 3 different types of screenshots.

Soon.
