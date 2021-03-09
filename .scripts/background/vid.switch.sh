#!/bin/bash
IFS=$'\n'

if [ -z "$1" ]; then
	echo 'Missing dir argument.'
	exit 1
fi

if [ -z "$2" ]; then
	echo 'Missing direction argument (next/prev).'
	exit 1
fi

dir=$1
direction=$2
dir_config=~/.config/wall/vid/

window=$(xprop -root | grep "_NET_ACTIVE_WINDOW(WINDOW)" | cut -d " " -f5)
position=$(xwininfo -id $window | grep "Absolute upper-left X:" | cut -d ":" -f2 | tr -d " ")

if [ "$position" -gt 1920 ]; then
	screen="screen_1.conf"
else
	screen="screen_0.conf"
fi

config="$dir_config$screen"
current=""
new=""

if [ ! -d "$dir_config" ]; then
	mkdir -p $dir_config
fi

if [ -f "$config" ]; then
	current=$(cat "$config")
fi

videos=$(find $dir -type f -printf "%T@ %p\n" | sort -nr | awk '{sub($1 OFS, ""); print $0}')
for f in $videos; do
	echo $f
	if [ -z "$current" ]; then
		new=$f
		break
	fi

	if [ "$direction" == "next" ]; then
		if [ "$prev" == "$current" ]; then
			new=$f
			break
		fi
	fi

	if [ "$direction" == "prev" ]; then
		if [ "$f" == "$current" ]; then
			new=$prev
			break
		fi
	fi

	prev=$f
done

if [ ! -z "$new" ]; then
	echo "$new" > $config
	echo Saved persistent: $config
	echo Setting wallpaper: $(basename "$new")
	~/.scripts/background/vidbg.sh
fi
