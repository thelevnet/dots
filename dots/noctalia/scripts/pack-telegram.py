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

# Pack into ZIP with ONLY colors.tdesktop-theme (no background image)
with zipfile.ZipFile(out_zip, "w", zipfile.ZIP_DEFLATED, strict_timestamps=False) as zf:
    zf.write(colors_file, arcname="colors.tdesktop-theme")

try:
    cache_zip.write_bytes(out_zip.read_bytes())
except Exception:
    pass

# If Telegram is running, prompt to send/share so it can be applied in chat
try:
    p = subprocess.run(["pgrep", "-f", "Telegram"], stdout=subprocess.PIPE)
    if p.returncode == 0:
        subprocess.Popen(["Telegram", str(out_zip)])
except Exception:
    pass
