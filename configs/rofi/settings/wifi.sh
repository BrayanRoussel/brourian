#!/usr/bin/env bash

THEME="$HOME/.config/rofi/settings/theme.rasi"

rofi_cmd() {
    rofi -dmenu -theme "$THEME" -p "$1"
}

notify() {
    if command -v notify-send &>/dev/null; then
        notify-send -a "Wi-Fi" "$1" "$2"
    fi
}

while true; do

    # 1. ESTADO DEL WI-FI
    IS_OFF=$(nmcli -t -f WIFI g 2>/dev/null | grep -i "disabled")

    if [ -n "$IS_OFF" ]; then
        OPT_TOGGLE="󰖩  Activar Wi-Fi"
        SELECTION=$(echo -e "$OPT_TOGGLE" | rofi_cmd "󰤭 Wi-Fi Apagado")

        if [ "$SELECTION" = "$OPT_TOGGLE" ]; then
            nmcli radio wifi on
            notify "󰤨 Wi-Fi Encendido" "Usa 'Actualizar redes' para buscar."
            continue
        fi
        exit 0
    fi

    # 2. CARGA DE TODAS LAS REDES (Lee la lista completa del aire)
    WIFI_LIST=$(nmcli -f "IN-USE,SSID,SECURITY" dev wifi list 2>/dev/null | sed 1d | \
        awk -F'  +' '{
            in_use = $1; ssid = $2; sec = $3;
            if (ssid != "" && ssid != "--") {
                lock = (sec ~ /WPA|WEP/) ? " 󰌾" : "";
                active = (in_use ~ /\*/) ? " (Conectado)" : "";
                printf "󰤨  %s%s%s\n", ssid, lock, active
            }
        }' | sort -u)

    OPT_RESCAN="󰑐  Actualizar redes"
    OPT_TOGGLE="󰖩  Desactivar Wi-Fi"
    OPT_DISCONNECT="󰤭  Desconectar"
    OPT_FORGET="󰈂  Olvidar Red"

    MENU_CONTENT="$OPT_RESCAN\n$OPT_TOGGLE\n$OPT_DISCONNECT\n$OPT_FORGET\n--------------------------------\n$WIFI_LIST"

    SELECTION=$(echo -e "$MENU_CONTENT" | rofi_cmd "󰤨 Wi-Fi")

    [ -z "$SELECTION" ] && exit 0

    case "$SELECTION" in
        "$OPT_RESCAN")
            notify "󰑐 Escaneando..." "Buscando redes en el aire..."
            nmcli dev wifi rescan &>/dev/null
            sleep 1
            continue
            ;;

        "$OPT_TOGGLE")
            nmcli radio wifi off
            notify "󰤭 Wi-Fi Desactivado" "Interfaz apagada."
            exit 0
            ;;

        "$OPT_DISCONNECT")
            ACTIVE_CON=$(nmcli -t -f NAME,TYPE connection show --active | grep wireless | cut -d: -f1)
            if [ -n "$ACTIVE_CON" ]; then
                nmcli connection down "$ACTIVE_CON" &>/dev/null
                notify "󰤭 Desconectado" "Te has desconectado de $ACTIVE_CON."
            fi
            exit 0
            ;;

        "$OPT_FORGET")
            SAVED_NETS=$(nmcli -g NAME connection show | grep -v 'lo')
            [ -z "$SAVED_NETS" ] && notify "Info" "No hay redes guardadas." && continue

            NET_TO_FORGET=$(echo -e "$SAVED_NETS" | rofi_cmd "󰈂 Olvidar Red")
            if [ -n "$NET_TO_FORGET" ]; then
                nmcli connection delete "$NET_TO_FORGET" &>/dev/null
                notify "󰈂 Red Olvidada" "Se eliminó $NET_TO_FORGET."
            fi
            continue
            ;;

        "--------------------------------")
            continue
            ;;

        *)
            # Limpiar SSID
            SSID=$(echo "$SELECTION" | sed -E 's/^󰤨[[:space:]]+//; s/[[:space:]]*󰌾//; s/[[:space:]]*\(Conectado\)//')

            [ -z "$SSID" ] && continue

            # Revisa si la red ya está guardada en NetworkManager
            IS_SAVED=$(nmcli -g NAME connection show | grep -x "$SSID")

            if [ -n "$IS_SAVED" ]; then
                # Red ya guardada: conecta directo
                notify "Conectando..." "Conectando a red conocida $SSID..."
                if nmcli connection up "$SSID" &>/dev/null; then
                    notify "󰤨 ¡Conectado!" "Conexión establecida con $SSID."
                    exit 0
                else
                    notify "󰅙 Error" "No se pudo conectar a $SSID."
                fi
            else
                # Red nueva: PIDE LA CONTRASEÑA DIRECTAMENTE POR ROFI
                PASS=$(rofi -dmenu -theme "$THEME" -password -p "󰌾 Clave para $SSID")

                # Si presiona ESC o la deja en blanco, cancela sin desconectarte de tu Wi-Fi actual
                [ -z "$PASS" ] && continue

                notify "Autenticando..." "Validando credenciales para $SSID..."

                OUT=$(nmcli dev wifi connect "$SSID" password "$PASS" 2>&1)

                if echo "$OUT" | grep -iqE "successfully|éxito"; then
                    notify "󰤨 ¡Conectado!" "Te has conectado correctamente a $SSID."
                    exit 0
                else
                    notify "󰅙 Error de Contraseña" "Clave incorrecta o la red rechazó la conexión."
                    nmcli connection delete "$SSID" &>/dev/null
                fi
            fi
            ;;
    esac
done
