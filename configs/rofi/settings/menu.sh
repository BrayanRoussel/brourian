#!/usr/bin/env bash

THEME="$HOME/.config/rofi/settings/theme.rasi"
KEYBINDS_SCRIPT="$HOME/.config/rofi/settings/keybinds.sh"

rofi_cmd() {
    rofi -dmenu \
         -theme "$THEME" \
         -p "$1"
}

# -----------------------------------------------------------------------------
# MENÚ PRINCIPAL (OPCIONES LIMPIAS)
# -----------------------------------------------------------------------------
opt_wifi="󰤨  RED WIFI"
opt_audio="󰓃  AUDIO"
opt_bright="󰃠  BRILLO"
opt_apps="󰵆  APLICACIONES"
opt_keys="󰌌  GUÍA DE TECLADO"
opt_info="󰋽  INFO"

main_menu() {
    echo -e "$opt_wifi\n$opt_audio\n$opt_bright\n$opt_apps\n$opt_keys\n$opt_info" | rofi_cmd "⚙ BROURIAN"
}

chosen="$(main_menu)"

case "$chosen" in
    "$opt_wifi")
        if command -v nm-connection-editor &>/dev/null; then
            nm-connection-editor
        else
            kitty -e nmtui
        fi
        ;;

    "$opt_audio")
        # -----------------------------------------------------------------------------
        # VENTANA INTERACTIVA DE AUDIO
        # -----------------------------------------------------------------------------
        if command -v pamixer &>/dev/null; then
            CURR_VOL=$(pamixer --get-volume-human)
        else
            CURR_VOL=$(amixer get Master | grep -o "[0-9]*%" | head -n1 || echo "N/A")
        fi

        a_up="󰝝  Subir Volumen (+5%)"
        a_down="󰝞  Bajar Volumen (-5%)"
        a_mute="󰝟  Alternar Silencio (Mute)"
        a_pavu="󰓃  Abrir Mezclador Completo (Pavucontrol)"

        audio_chosen=$(echo -e "$a_up\n$a_down\n$a_mute\n$a_pavu" | rofi_cmd "󰓃 AUDIO [$CURR_VOL]")

        case "$audio_chosen" in
            *"Subir"*)
                pamixer -i 5 || amixer set Master 5%+
                ;;
            *"Bajar"*)
                pamixer -d 5 || amixer set Master 5%-
                ;;
            *"Silencio"*)
                pamixer -t || amixer set Master toggle
                ;;
            *"Mezclador"*)
                pavucontrol
                ;;
        esac
        ;;

    "$opt_bright")
        # -----------------------------------------------------------------------------
        # VENTANA INTERACTIVA DE BRILLO
        # -----------------------------------------------------------------------------
        if command -v brightnessctl &>/dev/null; then
            CURR_BRIGHT="$(brightnessctl -m | cut -d, -f4)"
        else
            CURR_BRIGHT="N/A"
        fi

        b_up="󰃠  Subir Brillo (+10%)"
        b_down="󰃞  Bajar Brillo (-10%)"
        b_100="󰃠  Establecer al 100%"
        b_75="󰃟  Establecer al 75%"
        b_50="󰃞  Establecer al 50%"
        b_25="󰃝  Establecer al 25%"

        bright_chosen=$(echo -e "$b_up\n$b_down\n$b_100\n$b_75\n$b_50\n$b_25" | rofi_cmd "󰃠 BRILLO [$CURR_BRIGHT]")

        case "$bright_chosen" in
            *"Subir"*)     brightnessctl set +10% ;;
            *"Bajar"*)     brightnessctl set 10%- ;;
            *"100%"*)      brightnessctl set 100% ;;
            *"75%"*)       brightnessctl set 75% ;;
            *"50%"*)       brightnessctl set 50% ;;
            *"25%"*)       brightnessctl set 25% ;;
        esac
        ;;

    "$opt_apps")
        rofi -show drun -theme ~/.config/rofi/themes/brourian.rasi
        ;;

    "$opt_keys")
        # -----------------------------------------------------------------------------
        # DIRECTORIO DE ATAJOS DE TECLADO
        # -----------------------------------------------------------------------------
        if [ -f "$KEYBINDS_SCRIPT" ]; then
            bash "$KEYBINDS_SCRIPT"
        fi
        ;;

    "$opt_info")
        # -----------------------------------------------------------------------------
        # VENTANA DE INFORMACIÓN DEL PROYECTO
        # -----------------------------------------------------------------------------
        KERNEL_VER=$(uname -r)
        DISK_USAGE=$(df -h / | awk 'NR==2 {print $3 " / " $2 " (" $5 ")"}')

        info_ver="󰅂 Proyecto: Brourian v0.19"
        info_os="󰣌 Sistema: Debian Linux (Trixie)"
        info_kernel="󰌽 Kernel: $KERNEL_VER"
        info_wm="󰍹  WM: i3wm"
        info_term="󰞍 Terminal: Kitty"
        info_disk="󰋊 Disco: $DISK_USAGE"
        info_gh="󰊤 Repositorio de GitHub"
        info_web="󰖟 Página Web Oficial"

        info_chosen=$(echo -e "$info_ver\n$info_os\n$info_kernel\n$info_wm\n$info_term\n$info_disk\n$info_gh\n$info_web" | rofi_cmd "󰋽 INFO")

        case "$info_chosen" in
            *"GitHub"*)   ;;
            *"Página"*)   ;;
        esac
        ;;
esac
