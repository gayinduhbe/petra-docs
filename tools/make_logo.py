#!/usr/bin/env python3
"""Rebuild the Petra logo as a clean transparent lockup:
  * keep the gold emblem (ellipse + buildings + arrow) from the source
  * drop the original "PETRA HOLDINGS" wordmark
  * render a new "PETRA / CONSTRUCTION" wordmark to match

Run from the repo root:  python3 tools/make_logo.py

Outputs:
  assets/logo/logo-dark.png    emblem + "PETRA" in cream  (for dark pages)
  assets/logo/logo-light.png   emblem + "PETRA" in ink    (for light pages)
"""
import numpy as np
from PIL import Image, ImageDraw, ImageFont

SRC = "assets/logo/logo-source.jpeg"
FONT_BOLD = "/usr/share/fonts/gsfonts/NimbusSans-Bold.otf"

GOLD = (201, 162, 75)     # brand gold  #C9A24B
CREAM = (244, 241, 236)   # #F4F1EC
INK = (18, 16, 14)        # #12100E

# --- 1. Background-removed, recoloured RGBA of the WHOLE source ----------
def keyed(ink_color):
    img = Image.open(SRC).convert("RGB")
    a = np.asarray(img).astype(np.float32)
    R, G, B = a[..., 0], a[..., 1], a[..., 2]
    minc = a.min(axis=2)
    alpha = np.clip((185.0 - minc) / (185.0 - 150.0), 0.0, 1.0)
    is_gold = (R > 110) & (G > 80) & (B < 150) & (R >= G) & (G >= B) & ((R - B) > 40)
    out = np.zeros((*a.shape[:2], 4), dtype=np.uint8)
    rgb = np.empty_like(a)
    for i, c in enumerate(ink_color):
        rgb[..., i] = c
    for i, c in enumerate(GOLD):
        rgb[..., i] = np.where(is_gold, c, rgb[..., i])
    out[..., :3] = rgb.astype(np.uint8)
    out[..., 3] = (alpha * 255).astype(np.uint8)
    return Image.fromarray(out, "RGBA"), alpha

# --- 2. Find the gap between emblem and the old wordmark -----------------
_, alpha = keyed(CREAM)
rows = (alpha > 0.25).sum(axis=1)          # ink per row
h = len(rows)
# search the lower 55%..90% band for the widest run of (near-)empty rows
lo, hi = int(h * 0.45), int(h * 0.92)
best_run, best_start = 0, lo
run, start = 0, lo
for y in range(lo, hi):
    if rows[y] <= 2:
        if run == 0:
            start = y
        run += 1
        if run > best_run:
            best_run, best_start = run, start
    else:
        run = 0
emblem_bottom = best_start + best_run // 2
print(f"image h={h}, emblem cut at y={emblem_bottom} (gap {best_run}px)")

# --- 3. Compose emblem + new wordmark -----------------------------------
def build(ink_color, name):
    full, _ = keyed(ink_color)
    emblem = full.crop((0, 0, full.width, emblem_bottom))
    # tight horizontal crop of the emblem
    bb = emblem.getbbox()
    emblem = emblem.crop(bb)
    ew = emblem.width

    # Type sized relative to emblem width
    main_fs = int(ew * 0.30)
    sub_fs = int(ew * 0.135)
    f_main = ImageFont.truetype(FONT_BOLD, main_fs)
    f_sub = ImageFont.truetype(FONT_BOLD, sub_fs)
    track = int(sub_fs * 0.42)   # letter-spacing for "CONSTRUCTION"

    def text_w(font, s, tracking=0):
        w = sum(font.getbbox(ch)[2] - font.getbbox(ch)[0] + tracking for ch in s)
        return w - tracking if s else 0

    main_s = "PETRA"
    sub_s = "CONSTRUCTION"
    gap1 = int(ew * 0.06)   # emblem -> PETRA
    gap2 = int(ew * 0.05)   # PETRA -> CONSTRUCTION

    a_main, d_main = f_main.getmetrics()
    main_h = a_main + d_main
    a_sub, d_sub = f_sub.getmetrics()
    sub_h = a_sub + d_sub

    total_h = emblem.height + gap1 + main_h + gap2 + sub_h
    W = max(ew, text_w(f_main, main_s), text_w(f_sub, sub_s, track)) + 8
    canvas = Image.new("RGBA", (W, total_h), (0, 0, 0, 0))
    draw = ImageDraw.Draw(canvas)

    # emblem centred
    canvas.alpha_composite(emblem, ((W - ew) // 2, 0))

    # PETRA centred
    y = emblem.height + gap1
    mw = text_w(f_main, main_s)
    draw.text(((W - mw) // 2, y), main_s, font=f_main, fill=(*ink_color, 255))

    # CONSTRUCTION centred, tracked, in gold
    y += main_h + gap2
    sw = text_w(f_sub, sub_s, track)
    x = (W - sw) // 2
    for ch in sub_s:
        draw.text((x, y), ch, font=f_sub, fill=(*GOLD, 255))
        bb2 = f_sub.getbbox(ch)
        x += (bb2[2] - bb2[0]) + track

    canvas = canvas.crop(canvas.getbbox())
    canvas.save(name)
    print(f"wrote {name}  size={canvas.size}")

build(CREAM, "assets/logo/logo-dark.png")
build(INK, "assets/logo/logo-light.png")
