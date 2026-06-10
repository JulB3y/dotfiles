#!/bin/sh

export TRASH_BUFFERS=1

echo '{"version":1}'
echo '['
echo '[]'

while true; do
    datetime=$(date '+%Y-%m-%d %H:%M')
    bat_cap=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null || echo "0")
    bat_status=$(cat /sys/class/power_supply/BAT0/status 2>/dev/null || echo "Unknown")
    
    case "$bat_status" in
        Charging) bat_icon="󰂄" ;;
        Full) bat_icon="󰁹" ;;
        *) bat_icon="󰁹" ;;
    esac
    
    net=$(iwctl station wlan0 show 2>/dev/null | grep "Connected network" | sed 's/.*Connected network\s*//' | sed 's/\x1b\[[0-9;]*m//g' | xargs)
    if [ -z "$net" ]; then
        net="Disconnected"
    fi
    
    # Der gesamte JSON-String steht jetzt sicher in einer einzigen Zeile
    printf ',[{"full_text":"","min_width":800,"align":"right","separator":false},{"full_text":"%s","name":"clock","separator":false},{"full_text":"","min_width":600,"align":"right"},{"full_text":"󰖩 %s ","name":"network"},{"full_text":"%s %s%%","name":"battery"}]\n' "$datetime" "$net" "$bat_icon" "$bat_cap"
    
    sleep 5
done
