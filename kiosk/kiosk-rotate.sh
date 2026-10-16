#!/bin/bash
# Alterna entre as abas do Chromium a cada INTERVAL segundos (via DevTools, funciona no Wayland).
INTERVAL="${INTERVAL:-60}"
until curl -sf http://127.0.0.1:9222/json/version >/dev/null; do sleep 2; done
sleep 15
while true; do
  mapfile -t IDS < <(curl -sf http://127.0.0.1:9222/json | python3 -c '
import json,sys
for t in json.load(sys.stdin):
    if t.get("type")=="page": print(t["id"])')
  if [ "${#IDS[@]}" -eq 0 ]; then sleep 5; continue; fi
  for id in "${IDS[@]}"; do
    curl -sf "http://127.0.0.1:9222/json/activate/$id" >/dev/null
    sleep "$INTERVAL"
  done
done
