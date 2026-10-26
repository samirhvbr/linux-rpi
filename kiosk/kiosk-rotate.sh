#!/usr/bin/env python3
"""Alterna entre as abas do Chromium (via DevTools, funciona no Wayland).
Cada linha de /etc/kiosk/urls.txt: URL [segundos]. A aba e achada pelo host da URL
(o redirect para /login mantem o host). Sem segundos usa DEFAULT_INTERVAL."""
import json, os, time, urllib.request
from urllib.parse import urlparse

DEFAULT = int(os.environ.get("INTERVAL", "60"))
API = "http://127.0.0.1:9222"

def get(path):
    with urllib.request.urlopen(API + path, timeout=5) as r:
        return r.read()

def load():
    out = []
    for line in open("/etc/kiosk/urls.txt"):
        line = line.strip()
        if not line or line.startswith("#"):
            continue
        p = line.split()
        out.append((urlparse(p[0]).netloc, int(p[1]) if len(p) > 1 else DEFAULT))
    return out

while True:
    try:
        get("/json/version"); break
    except Exception:
        time.sleep(2)
time.sleep(15)
while True:
    try:
        pages = [t for t in json.loads(get("/json")) if t.get("type") == "page"]
        for host, secs in load():
            for t in pages:
                if urlparse(t["url"]).netloc == host:
                    get("/json/activate/" + t["id"])
                    break
            time.sleep(secs)
    except Exception:
        time.sleep(5)
