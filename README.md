# My Plex HTPC Script Collection

This is a collection of my personal Plex HTPC scripts.

I'm not really a programmer, but kind of cobbled most of the stuff together and tweaked it with ChatGPT. Maybe the scripts are still helpful.

## Overview

* [Smart Deband](https://github.com/Ninelpienel/Plex-Scripts#smart-deband)
* [Smart Screenshots](https://github.com/Ninelpienel/Plex-Scripts#smart-screenshots)
* Dolby Atmos Auto Pass-through (Soon)

## Smart Deband

This script activates the deband function of mpv if the video is in H.264 8-bit format. In addition, you can add exceptions via a whitelist and blacklist. Since mostly bad encodes or web rips are in H.264 8-bit, the debanding should only be applied to these videos.

I have added a single exception: If the video has 12 ref frames, debanding is not enabled. This primarily affects high quality web rips that have already been cleanly filtered.

### Step 1

Put [smart_deband.lua](https://github.com/Ninelpienel/Plex-Scripts/blob/main/smart_deband.lua) in `C:\Users\%username%\AppData\Local\Plex HTPC\scripts`.

### Step 2

Create `smart_deband_blacklist.txt` and `smart_deband_whitelist.txt` in your desired folder.

Update the paths in the lua file.

```
local whitelist = "C:/Your/desired/path/smart_deband_whitelist.txt"
local blacklist = "C:/Your/desired/path/smart_deband_blacklist.txt"
```

### Step 3

Put the settings below into your mpv.conf file.

```
deband=no
deband-iterations=6
deband-threshold=64
deband-range=32
deband-grain=0
```

The file is located in `C:\Users\%username%\AppData\Local\Plex HTPC`.

### Step 4

Now you just have to define which files outside the H.264 8-bit rule should be either additionally debanded (whitelisted) or excluded from this rule (blacklisted). You just have to put a part of the filename into the respective text file.

### Examples

If you put `[Bad Encode] Random Anime` in the whitelist, the debanding will be applied even if the video is in HEVC or H.264 10-bit.

If you put `[Good Encode] Random Anime` in the blacklist, the debanding will not be applied even if the video is in H.264 8-bit.

## Smart Screenshots

With this script you can take 3 different types of screenshots. It also inserts the series name, episode number and timestamp into the file name.

1. Regular sceenshots.
2. Screenshots without subtitles.
3. Screenshots with informations of the episode and a time stamp. Pretty nice for QC stuff.

Currently, this only works for series, not for movies.

### Step 1

Put [smart_screenshots.lua](https://github.com/Ninelpienel/Plex-Scripts/blob/main/smart_screenshots.lua) in `C:\Users\%username%\AppData\Local\Plex HTPC\scripts`.

### Step 2

Change the key bindings at the end of the script (`1`, `2` and `3`) to your liking.

```
mp.add_forced_key_binding("1", "screenshot", screenshot)
mp.add_forced_key_binding("2", "screenshot_no_subs", screenshot_no_subs)
mp.add_forced_key_binding("3", "qc_screenshot", qc_screenshot)
```

### Step 3

Put the settings below into your mpv.conf file.

```
screenshot-format=png
screenshot-high-bit-depth=no
screenshot-png-compression=6
screenshot-directory="C:\Users\User\Documents\Screenshots"
```

The file is located in `C:\Users\%username%\AppData\Local\Plex HTPC`.

Update the screenshot directory path.

### Step 4

Create a subfolder named `QC` in your screenshot directory. The screenshots with and without subtitles will go directly into the defined directory, the QC screenshots will go into the subfolder.

### Examples

These screenshots were taken from the same frame.

#### A regular screenshot

![20231018_19 44 48_Ishuzoku Reviewers - 04 (00 17 21)](https://github.com/Ninelpienel/Plex-Scripts/assets/1890524/5b507f20-e46a-4c63-8c6f-90435a049a08)

#### A screenshot without subtitles

![20231018_19 44 54_Ishuzoku Reviewers - 04 (00 17 21)](https://github.com/Ninelpienel/Plex-Scripts/assets/1890524/764fdcd4-3cc3-4f6e-844d-4832a0dda057)

#### A screenshot with informations of the episode and a time stamp

![20231018_19 44 50_Ishuzoku Reviewers - 04 (00 17 21)](https://github.com/Ninelpienel/Plex-Scripts/assets/1890524/35a4770d-cf96-4be7-a56c-81cf76d4fec1)
