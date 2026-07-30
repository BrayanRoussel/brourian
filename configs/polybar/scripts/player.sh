#!/bin/bash
status=$(playerctl status 2>/dev/null)
# Si no hay reproductor o está detenido → no mostrar nada
if [[ -z "$status" || "$status" == "Stopped" ]]; then
    exit 0
fi

# Icono play/pause
if [[ "$status" == "Playing" ]]; then
    pp_icon=""
else
    pp_icon=""
fi

# Título (máximo 30 caracteres para que no desborde)
title=$(playerctl metadata title 2>/dev/null | cut -c1-20)
[[ -z "$title" ]] && exit 0

# Solo el interior de la píldora (polybar añade  y )
echo "%{A1:playerctl play-pause:}${pp_icon}%{A}  ${title}"
