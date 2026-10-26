#!/bin/bash
# Abre as URLs de /etc/kiosk/urls.txt (1o campo) em abas do Chromium (rodando dentro do cage).
mapfile -t URLS < <(grep -vE '^\s*(#|$)' /etc/kiosk/urls.txt | awk '{print $1}')
exec chromium \
  --kiosk --noerrdialogs --disable-infobars --no-first-run \
  --disable-session-crashed-bubble --disable-features=Translate \
  --password-store=basic --ozone-platform=wayland \
  --user-data-dir="$HOME/.config/kiosk-chromium" \
  --remote-debugging-port=9222 --remote-allow-origins='*' \
  --autoplay-policy=no-user-gesture-required \
  "${URLS[@]}"
