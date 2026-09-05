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
        wallpaper_path = wp
except Exception:
    pass

bg_jpg = Path("/tmp/telegram-background.jpg")
has_bg = False
if wallpaper_path and os.path.exists(wallpaper_path):
    try:
        subprocess.run(
            ["magick", wallpaper_path, "-resize", "1920x1080^", "-gravity", "center", "-extent", "1920x1080", str(bg_jpg)],
            check=True,
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )
        has_bg = bg_jpg.exists()
    except Exception:
        pass

# Pack into ZIP with colors and background.jpg
with zipfile.ZipFile(out_zip, "w", zipfile.ZIP_DEFLATED, strict_timestamps=False) as zf:
    zf.write(colors_file, arcname="colors.tdesktop-theme")
    if has_bg:
        zf.write(bg_jpg, arcname="background.jpg")

try:
    cache_zip.write_bytes(out_zip.read_bytes())
except Exception:
    pass

