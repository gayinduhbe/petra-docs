#!/usr/bin/env python3
"""Generate a restrained, luxury-grade palette in OKLCH, anchored on the
brand gold. Principles (from color-theory research):
  * one metallic accent (gold) carries the design
  * supporting colours are LOW chroma (muted), not saturated
  * warm-tinted near-black + cream neutrals do the structural work
  * a single complementary (deep muted navy) used sparingly
"""
from coloraide import Color

def hexof(c):
    return Color(c).convert("srgb").to_string(hex=True, upper=True)

GOLD = Color("#C9A24B").convert("oklch")
L, C, H = GOLD["lightness"], GOLD["chroma"], GOLD["hue"]
print(f"brand gold  OKLCH  L={L:.3f} C={C:.3f} H={H:.1f}")

def oklch(l, c, h):
    return hexof(Color("oklch", [l, c, h]))

print("\n--- NEUTRALS (warm-tinted, very low chroma, hue≈gold) ---")
nh = H  # keep the warm hue so blacks/greys feel warm, not clinical
neutrals = {
    "bg-base":  oklch(0.150, 0.006, nh),  # warm onyx
    "bg-card":  oklch(0.205, 0.008, nh),
    "bg-card2": oklch(0.245, 0.010, nh),
    "border":   oklch(0.320, 0.012, nh),
    "text-mut": oklch(0.620, 0.012, nh),  # muted taupe-grey
    "text-bod": oklch(0.800, 0.010, nh),  # warm light grey
    "text-hi":  oklch(0.960, 0.008, nh),  # cream / ivory
}
for k, v in neutrals.items():
    print(f"  {k:9} {v}")

print("\n--- GOLD ramp (the one accent) ---")
golds = {
    "gold-deep":  oklch(L - 0.10, C, H),
    "gold":       oklch(L, C, H),
    "gold-light": oklch(L + 0.14, C * 0.85, H),
}
for k, v in golds.items():
    print(f"  {k:10} {v}")

print("\n--- SECONDARY: complement, DEEP & MUTED (used sparingly) ---")
comp_h = (H + 180) % 360
sec = {
    "navy-deep": oklch(0.300, 0.045, comp_h),
    "navy":      oklch(0.420, 0.055, comp_h),
    "navy-soft": oklch(0.680, 0.045, comp_h),  # for the rare bit of text
}
for k, v in sec.items():
    print(f"  {k:10} {v}  (H={comp_h:.0f})")

print("\n--- STATUS (muted, earthy, low chroma) ---")
status = {
    "ok-green": oklch(0.700, 0.060, 150),   # muted sage
    "amber":    oklch(0.720, 0.075, 70),     # muted honey (ongoing)
}
for k, v in status.items():
    print(f"  {k:9} {v}")
