"""Create the Content PPT Pipeline plugin identity artwork.

This deterministic vector-like fallback does not invoke CPA ImgGen.
Requires Pillow only when regenerating the bundled PNG assets.
"""

from pathlib import Path
from PIL import Image, ImageDraw, ImageFilter


ROOT = Path(__file__).resolve().parents[1]
DEST = ROOT / "assets"
DEST.mkdir(exist_ok=True)

N = 1024
SCALE = 2
N2 = N * SCALE


def box(*coords):
    return tuple(int(v * SCALE) for v in coords)


def rounded(d, coords, radius, fill, outline=None, width=1):
    d.rounded_rectangle(box(*coords), radius=radius * SCALE, fill=fill,
                        outline=outline, width=width * SCALE)


img = Image.new("RGBA", (N2, N2), (0, 0, 0, 0))

# Dark blue rounded app tile, with a restrained top-to-bottom color shift.
gradient = Image.new("RGBA", (N2, N2))
px = gradient.load()
for y in range(N2):
    t = y / (N2 - 1)
    for x in range(N2):
        flare = max(0.0, 1.0 - ((x / SCALE - 260)**2 + (y / SCALE - 80)**2)**0.5 / 920)
        px[x, y] = (
            round(17 + 19*t + 11*flare),
            round(27 + 22*t + 13*flare),
            round(59 + 47*t + 22*flare),
            255,
        )

mask = Image.new("L", (N2, N2), 0)
md = ImageDraw.Draw(mask)
md.rounded_rectangle(box(48, 48, 976, 976), radius=208*SCALE, fill=255)
img.paste(gradient, (0, 0), mask)

# Haze behind the stack makes its layered identity legible at small sizes.
glow = Image.new("RGBA", img.size, (0, 0, 0, 0))
gd = ImageDraw.Draw(glow)
rounded(gd, (236, 218, 806, 748), 95, (73, 125, 248, 116))
glow = glow.filter(ImageFilter.GaussianBlur(69*SCALE))
img = Image.alpha_composite(img, glow)

shadow = Image.new("RGBA", img.size, (0, 0, 0, 0))
sd = ImageDraw.Draw(shadow)
rounded(sd, (195, 326, 827, 785), 69, (0, 7, 35, 190))
shadow = shadow.filter(ImageFilter.GaussianBlur(31*SCALE))
img = Image.alpha_composite(img, shadow)

d = ImageDraw.Draw(img)

# Recurring pages / stages of a presentation pipeline.
rounded(d, (291, 216, 792, 665), 64, (78, 78, 163, 255),
        outline=(163, 146, 255, 255), width=17)
rounded(d, (250, 266, 836, 714), 66, (51, 98, 170, 255),
        outline=(80, 181, 251, 255), width=16)

# Main presentation page and a thin cyan accent rail.
rounded(d, (196, 325, 819, 770), 67, (242, 249, 255, 255),
        outline=(255, 255, 255, 255), width=12)
rounded(d, (228, 356, 786, 379), 11, (85, 215, 230, 255))

# Left half: three evidence bars, conveying structured data.
for coords, color in [
    ((281, 538, 353, 674), (78, 169, 250, 255)),
    ((384, 476, 456, 674), (113, 104, 240, 255)),
    ((487, 429, 559, 674), (49, 207, 204, 255)),
]:
    rounded(d, coords, 26, color)

# Right half: concise narrative / slide text, in polished graphic strokes.
rounded(d, (604, 434, 742, 467), 16, (50, 81, 147, 255))
rounded(d, (604, 508, 754, 539), 15, (137, 151, 190, 255))
rounded(d, (604, 577, 712, 608), 15, (137, 151, 190, 255))
rounded(d, (604, 646, 734, 675), 15, (137, 151, 190, 255))

result = img.resize((N, N), Image.Resampling.LANCZOS)
result.save(DEST / "logo.png", optimize=True)
result.resize((256, 256), Image.Resampling.LANCZOS).save(
    DEST / "icon.png", optimize=True
)
print(f"Wrote {DEST / 'logo.png'} and {DEST / 'icon.png'}")
