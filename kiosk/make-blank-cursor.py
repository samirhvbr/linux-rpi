#!/usr/bin/env python3
"""Gera um tema de cursor Xcursor invisível (1x1 transparente) em /usr/share/icons/blank."""
import os, struct
d = "/usr/share/icons/blank/cursors"
os.makedirs(d, exist_ok=True)
img = struct.pack("<IIIIIIIII", 36, 0xfffd0002, 1, 1, 1, 1, 0, 0, 0) + b"\0\0\0\0"
data = b"Xcur" + struct.pack("<IIII", 16, 0x10000, 1, 0xfffd0002) + struct.pack("<II", 1, 28) + img
base = os.path.join(d, "left_ptr")
open(base, "wb").write(data)
for n in "default arrow pointer text xterm hand1 hand2 grab grabbing watch wait progress crosshair move fleur not-allowed help context-menu cell vertical-text alias copy no-drop all-scroll col-resize row-resize n-resize s-resize e-resize w-resize ne-resize nw-resize se-resize sw-resize ew-resize ns-resize nesw-resize nwse-resize zoom-in zoom-out top_left_arrow".split():
    p = os.path.join(d, n)
    if os.path.lexists(p): os.remove(p)
    os.symlink("left_ptr", p)
open("/usr/share/icons/blank/index.theme", "w").write("[Icon Theme]\nName=blank\n")
