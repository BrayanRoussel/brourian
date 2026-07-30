#!/usr/bin/env bash

# ==========================================================
# BROURIAN KEYBINDINGS DIRECTORY
# ==========================================================

THEME="$HOME/.config/rofi/settings/theme.rasi"

# Lista de Atajos de Teclado del Sistema (i3wm / Rofi / Kitty)
KEYS="
󰌌  Super + Enter       ➜  Abrir Terminal (Kitty)
󰌌  Super + Shift + Q   ➜  Cerrar Ventana Enfocada
󰌌  Super + D           ➜  Lanzador de Aplicaciones (Rofi)
󰌌  Super + Espacio     ➜  Panel de Ajustes / Menú
󰌌  Super + U           ➜  Cambiar Fondo de Pantalla (Aleatorio)
󰌌  Super + Shift + E   ➜  Salir de i3 / Apagar Sistema
󰌌  Super + F           ➜  Modo Pantalla Completa (Fullscreen)
󰌌  Super + E           ➜  Modo Split Vertical / Horizontal
󰌌  Super + S           ➜  Modo Layout Stacking
󰌌  Super + W           ➜  Modo Layout Tabbed
󰌌  Super + Teclas Dir  ➜  Mover Enfoque entre Ventanas
󰌌  Super + Shift + Dir ➜  Mover Ventana de Posición
󰌌  Super + 1-9         ➜  Cambiar de Workspace
󰌌  Super + Shift + 1-9 ➜  Mover Ventana a Workspace
󰌌  Super + Shift + R   ➜  Reiniciar / Recargar Configuración i3
"

# Mostrar la lista en Rofi usando tu tema RASI
echo "$KEYS" | sed '/^$/d' | rofi -dmenu \
    -p "󰋖 Atajos i3wm" \
    -theme "$THEME" \
    -selected-row 0
