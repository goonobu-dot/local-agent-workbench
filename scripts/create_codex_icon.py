#!/usr/bin/env python3
from pathlib import Path

from PIL import Image, ImageDraw, ImageFont


ROOT = Path(__file__).resolve().parents[1]
ASSETS = ROOT / "Assets"
ICONSET = ASSETS / "CodexCLI9Panes.iconset"
PREVIEW = ASSETS / "CodexCLI9Panes.png"


def font(size: int, bold: bool = False) -> ImageFont.FreeTypeFont:
    candidates = [
        "/System/Library/Fonts/Supplemental/Arial Bold.ttf" if bold else "/System/Library/Fonts/Supplemental/Arial.ttf",
        "/System/Library/Fonts/SFNS.ttf",
        "/System/Library/Fonts/Helvetica.ttc",
    ]
    for candidate in candidates:
        try:
            return ImageFont.truetype(candidate, size)
        except Exception:
            pass
    return ImageFont.load_default()


def draw_rounded_rectangle(draw: ImageDraw.ImageDraw, box, radius, fill, outline=None, width=1):
    draw.rounded_rectangle(box, radius=radius, fill=fill, outline=outline, width=width)


def make_icon(size: int) -> Image.Image:
    scale = size / 1024
    img = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)

    def s(value: int) -> int:
        return max(1, int(value * scale))

    # Outer app tile.
    draw_rounded_rectangle(
        draw,
        (s(74), s(74), s(950), s(950)),
        s(188),
        fill=(15, 23, 42, 255),
    )
    draw_rounded_rectangle(
        draw,
        (s(110), s(112), s(914), s(910)),
        s(150),
        fill=(18, 31, 58, 255),
        outline=(68, 210, 255, 210),
        width=s(10),
    )

    # Terminal header.
    draw_rounded_rectangle(
        draw,
        (s(160), s(168), s(864), s(276)),
        s(42),
        fill=(28, 44, 78, 255),
    )
    for idx, color in enumerate([(255, 95, 86), (255, 189, 46), (39, 201, 63)]):
        x = s(210 + idx * 58)
        draw.ellipse((x, s(203), x + s(30), s(233)), fill=color)

    # Nine panes.
    grid_left, grid_top = s(172), s(326)
    cell, gap = s(202), s(18)
    colors = [
        (52, 211, 153, 255),
        (34, 211, 238, 255),
        (96, 165, 250, 255),
        (129, 140, 248, 255),
        (45, 212, 191, 255),
        (56, 189, 248, 255),
        (74, 222, 128, 255),
        (125, 211, 252, 255),
        (147, 197, 253, 255),
    ]
    for row in range(3):
        for col in range(3):
            i = row * 3 + col
            x0 = grid_left + col * (cell + gap)
            y0 = grid_top + row * (cell + gap)
            x1 = x0 + cell
            y1 = y0 + cell
            fill = (22, 36, 65, 255)
            outline = colors[i]
            draw_rounded_rectangle(draw, (x0, y0, x1, y1), s(30), fill=fill, outline=outline, width=s(8))
            draw.rectangle((x0 + s(24), y0 + s(52), x1 - s(24), y0 + s(64)), fill=(148, 163, 184, 210))
            draw.rectangle((x0 + s(24), y0 + s(86), x1 - s(54), y0 + s(96)), fill=(71, 85, 105, 230))
            draw.rectangle((x0 + s(24), y0 + s(120), x1 - s(82), y0 + s(130)), fill=(71, 85, 105, 210))

    # Center badge.
    badge = (s(348), s(424), s(676), s(604))
    draw_rounded_rectangle(draw, badge, s(56), fill=(2, 132, 199, 242), outline=(186, 230, 253, 235), width=s(7))
    title_font = font(s(76), bold=True)
    text = "CODEX"
    tb = draw.textbbox((0, 0), text, font=title_font)
    draw.text((s(512) - (tb[2] - tb[0]) / 2, s(456)), text, font=title_font, fill=(240, 249, 255, 255))

    number_font = font(s(168), bold=True)
    tb = draw.textbbox((0, 0), "9", font=number_font)
    draw.text((s(512) - (tb[2] - tb[0]) / 2, s(616)), "9", font=number_font, fill=(224, 242, 254, 255))

    return img


def save_iconset() -> None:
    ASSETS.mkdir(exist_ok=True)
    ICONSET.mkdir(exist_ok=True)
    base = make_icon(1024)
    base.save(PREVIEW)

    sizes = {
        "icon_16x16.png": 16,
        "icon_16x16@2x.png": 32,
        "icon_32x32.png": 32,
        "icon_32x32@2x.png": 64,
        "icon_128x128.png": 128,
        "icon_128x128@2x.png": 256,
        "icon_256x256.png": 256,
        "icon_256x256@2x.png": 512,
        "icon_512x512.png": 512,
        "icon_512x512@2x.png": 1024,
    }
    for name, output_size in sizes.items():
        base.resize((output_size, output_size), Image.Resampling.LANCZOS).save(ICONSET / name)


if __name__ == "__main__":
    save_iconset()
