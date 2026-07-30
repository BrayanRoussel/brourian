#!/bin/bash

# ─── CPU ───
cpu=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{printf "%.0f", 100 - $1}')
[[ -z "$cpu" ]] && cpu="?"

# ─── RAM ───
ram=$(free | awk '/Mem:/ {printf "%.0f", $3/$2 * 100.0}')

# ─── WiFi (wlo1) – solo icono, sin SSID ───
wifi_icon="󰤭"   # desconectado por defecto
if command -v nmcli &>/dev/null; then
    if nmcli -t -f DEVICE,STATE device status 2>/dev/null | grep -q '^wlo1:connected'; then
        wifi_icon="󰤨"   # conectado
    fi
elif command -v iw &>/dev/null; then
    if iw dev wlo1 link 2>/dev/null | grep -q 'SSID:'; then
        wifi_icon="󰤨"
    fi
fi

# ─── Audio (PipeWire/PulseAudio) ───
vol=0
mute=false
if command -v wpctl &>/dev/null; then
    wpctl_out=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null)
    vol=$(echo "$wpctl_out" | awk '{print $2*100}' | cut -d. -f1)
    echo "$wpctl_out" | grep -q 'MUTED' && mute=true
elif command -v pactl &>/dev/null; then
    vol=$(pactl get-sink-volume @DEFAULT_SINK@ 2>/dev/null | head -1 | awk '{print $5}' | sed 's/%//')
    pactl get-sink-mute @DEFAULT_SINK@ 2>/dev/null | grep -q 'yes' && mute=true
else
    vol=$(pamixer --get-volume 2>/dev/null || echo 0)
    [ "$(pamixer --get-mute)" = "true" ] && mute=true
fi

if [ "$mute" = "true" ]; then
    vol_icon="󰝟"
    vol_text=" Mute"
else
    vol_icon="󰕾"
    vol_text=" ${vol}%"
fi

# ─── Batería ───
bat_icon=""
bat_text=""
if [ -d /sys/class/power_supply/BAT0 ]; then
    bat_cap=$(cat /sys/class/power_supply/BAT0/capacity)
    bat_stat=$(cat /sys/class/power_supply/BAT0/status)
    if [ "$bat_stat" = "Charging" ]; then
        bat_icon="󰂄"
    else
        bat_icon="󰁹"
    fi
    bat_text=" ${bat_cap}%"
fi

# ─── Salida ───
echo " ${cpu}%  󰍛 ${ram}%  ${wifi_icon}  ${vol_icon}${vol_text}  ${bat_icon}${bat_text}"
