#!/bin/sh
# Adjust volume/brightness and show the new level in wob via /tmp/wobpipe.
# Usage: wob.sh volume {+5%|-5%|mute} | wob.sh brightness {5%+|5%-}

WOB_PIPE=/tmp/wobpipe

wob_show() {
	[ -p "$WOB_PIPE" ] && printf '%s\n' "$1" >"$WOB_PIPE"
}

case "$1" in
volume)
	if [ "$2" = mute ]; then
		pactl set-sink-mute @DEFAULT_SINK@ toggle
		muted=$(pactl get-sink-mute @DEFAULT_SINK@ | grep -o 'yes\|no' | head -1)
		if [ "$muted" = yes ]; then
			wob_show 0
		else
			wob_show "$(pactl get-sink-volume @DEFAULT_SINK@ | grep -o '[0-9]\+%' | head -1 | tr -d '%')"
		fi
	else
		pactl set-sink-volume @DEFAULT_SINK@ "$2"
		wob_show "$(pactl get-sink-volume @DEFAULT_SINK@ | grep -o '[0-9]\+%' | head -1 | tr -d '%')"
	fi
	;;
brightness)
	brightnessctl set "$2"
	wob_show "$((100 * $(brightnessctl get) / $(brightnessctl max)))"
	;;
esac
