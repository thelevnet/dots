import os
import sys
import zipfile
import subprocess
from pathlib import Path

home = Path.home()
colors_file = home / ".cache/noctalia/telegram/colors.tdesktop-theme"
if not colors_file.exists():
    alt_colors = home / ".config/telegram-desktop/themes/noctalia.tdesktop-theme"
    if alt_colors.exists():
        colors_file = alt_colors
    else:
        sys.exit(0)

# Output zip in user-accessible Downloads
out_zip = home / "Downloads/noctalia.tdesktop-theme"
out_zip.parent.mkdir(parents=True, exist_ok=True)

# Also save in cache
cache_zip = home / ".cache/noctalia/noctalia.tdesktop-theme"

# Find current wallpaper via noctalia msg wallpaper-get
wallpaper_path = None
try:
    res = subprocess.run(["noctalia", "msg", "wallpaper-get"], capture_output=True, text=True)
    wp = res.stdout.strip()
    if wp and os.path.exists(wp):
        wallpaper_path = Path(wp)
except Exception:
    pass

# Pack into ZIP directly with original wallpaper (strict_timestamps=False for Nix 1970 epoch)
with zipfile.ZipFile(out_zip, "w", zipfile.ZIP_DEFLATED, strict_timestamps=False) as zf:
    zf.write(colors_file, arcname="colors.tdesktop-theme")
    if wallpaper_path and wallpaper_path.exists():
        ext = wallpaper_path.suffix.lower()
        if ext in [".jpg", ".jpeg"]:
            arcname = "background.jpg"
        elif ext == ".png":
            arcname = "background.png"
        else:
            arcname = "background.jpg"
        zf.write(wallpaper_path, arcname=arcname)

try:
    cache_zip.write_bytes(out_zip.read_bytes())
except Exception:
    pass
