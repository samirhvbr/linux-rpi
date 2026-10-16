#!/bin/bash
# Abre as URLs de /etc/kiosk/urls.txt em abas do Chromium (rodando dentro do cage).
mapfile -t URLS < <(grep -vE '^\s*(#|$)' /etc/kiosk/urls.txt)
exec chromium \
  --kiosk --noerrdialogs --disable-infobars --no-first-run \
  --disable-session-crashed-bubble --disable-features=Translate \
  --password-store=basic --ozone-platform=wayland \
  --user-data-dir="$HOME/.config/kiosk-chromium" \
  --remote-debugging-port=9222 --remote-allow-origins='*' \
  --autoplay-policy=no-user-gesture-required \
  "${URLS[@]}"
