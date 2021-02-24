#!/bin/bash
IFS=$'\n'

# Kill previous instances
pkill xwinwrap
#sleep 1

vo='gpu'
dir_config=~/.config/wall/vid/
monitors=$(xrandr --listactivemonitors | grep -v Monitors)
for monitor in $monitors; do
	screen=$(echo ${monitor//:} | awk '{print $1}')
	screen_x=$(echo $monitor | awk '{print $3}' | awk -F"/" '{print $1}')
	screen_y=$(echo $monitor | awk '{print $3}' | awk -F"/" '{print $2}' | awk -F"x" '{print $2}')
	screen_pos=$(echo $monitor | awk '{print $3}' | awk -F"/" '{print $3}' | sed 's/^[^+]*+//')

	config="${dir_config}screen_$screen.conf"
	if [ ! -f "$config" ]; then
		echo "No config for screen $screen in $config."
		exit
	fi
	
	wallpaper=$(cat "$config")
	wallpaper_img=~/.cache/wall/vidbg.$(basename "$wallpaper").png

	if [ ! -f "$wallpaper_img" ]; then
		~/.scripts/colors/vid2img.sh "$wallpaper" "$wallpaper_img" > /dev/null 2>&1
	fi

	echo Setting wallpaper.
	echo - screen: $screen
	echo - config: $config
	echo - video: $wallpaper
	echo - image: $wallpaper_img
	echo - size: ${screen_x}x${screen_y}
	echo - pos: $screen_pos

	feh --bg-scale "$wallpaper_img"
	xwinwrap -g ${screen_x}x${screen_y}+$screen_pos -ov -ni -s -nf -- mpv --vo=$vo --no-audio --loop -wid WID "$wallpaper" &
done

