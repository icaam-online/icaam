#!/usr/bin/env python3
"""
ICAAM gallery optimizer
- Put original (full resolution) photos into media/gallery/original/
- Run:  python3 scripts/optimize_gallery.py
- Originals are renamed to clean web-safe names (e.g. "IMG 1234.JPG" ->
  "img_1234.jpg") and a reduced copy (max 1 MB) with the same name is
  written to media/gallery/. media.html shows the reduced copy and opens
  the original when the photo is clicked.

Requires Pillow:  pip3 install Pillow
Options:
  --force        regenerate reduced copies even if they are up to date
  --max-size N   maximum reduced file size in KB (default 1000)
"""
import argparse
import os
import re
import sys
import unicodedata

try:
	from PIL import Image, ImageOps
except ImportError:
	sys.exit("Pillow is required: pip3 install Pillow")

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
ORIGINAL_DIR = os.path.join(ROOT, "media", "gallery", "original")
OUTPUT_DIR = os.path.join(ROOT, "media", "gallery")

EXTENSIONS = (".jpg", ".jpeg", ".png", ".webp", ".heic", ".tif", ".tiff")
MAX_EDGE = 2400                      # longest side of the reduced photo (px)
QUALITIES = (85, 80, 75, 70, 65, 60)  # tried in order until the size fits


def clean_name(filename):
	"""'IMG 1234 (1).JPEG' -> 'img_1234_1.jpg'"""
	base, ext = os.path.splitext(filename)
	# transliterate accented letters: "Açılış Töreni" -> "Acilis Toreni"
	base = base.replace("ı", "i").replace("İ", "I")
	base = unicodedata.normalize("NFKD", base).encode("ascii", "ignore").decode("ascii")
	base = re.sub(r"[^a-z0-9]+", "_", base.lower()).strip("_") or "photo"
	ext = ext.lower()
	if ext == ".jpeg":
		ext = ".jpg"
	return base + ext


def rename_original(filename):
	"""Rename an original to its clean name (never overwrites). Returns new name."""
	new = clean_name(filename)
	if new == filename:
		return filename
	base, ext = os.path.splitext(new)
	i = 2
	while os.path.exists(os.path.join(ORIGINAL_DIR, new)):
		new = "%s_%d%s" % (base, i, ext)
		i += 1
	os.rename(os.path.join(ORIGINAL_DIR, filename), os.path.join(ORIGINAL_DIR, new))
	print("renamed   %s -> %s" % (filename, new))
	return new


def reduce(src, dst, max_bytes):
	"""Write a JPEG copy of src to dst that is at most max_bytes."""
	with Image.open(src) as im:
		icc = im.info.get("icc_profile")
		im = ImageOps.exif_transpose(im)  # apply camera rotation; EXIF (GPS etc.) is dropped
		if im.mode != "RGB":
			im = im.convert("RGB")

		edge = MAX_EDGE
		while True:
			small = im.copy()
			small.thumbnail((edge, edge), Image.LANCZOS)
			for q in QUALITIES:
				small.save(dst, "JPEG", quality=q, optimize=True, progressive=True, icc_profile=icc)
				if os.path.getsize(dst) <= max_bytes:
					return small.size, q
			edge = int(edge * 0.85)  # still too big: shrink and try again


def main():
	parser = argparse.ArgumentParser(description="Create reduced gallery photos for the website.")
	parser.add_argument("--force", action="store_true", help="regenerate all reduced copies")
	parser.add_argument("--max-size", type=int, default=1000, help="max reduced size in KB (default 1000)")
	args = parser.parse_args()

	if not os.path.isdir(ORIGINAL_DIR):
		sys.exit("Folder not found: %s" % ORIGINAL_DIR)

	files = sorted(f for f in os.listdir(ORIGINAL_DIR)
		if f.lower().endswith(EXTENSIONS) and not f.startswith("."))
	if not files:
		print("No photos in %s" % ORIGINAL_DIR)
		return

	for f in files:
		f = rename_original(f)
		src = os.path.join(ORIGINAL_DIR, f)
		dst = os.path.join(OUTPUT_DIR, os.path.splitext(f)[0] + ".jpg")

		if not args.force and os.path.exists(dst) and os.path.getmtime(dst) >= os.path.getmtime(src):
			print("skipped   %s (up to date)" % f)
			continue

		size, q = reduce(src, dst, args.max_size * 1024)
		print("reduced   %s -> %s  %dx%d, q%d, %d KB -> %d KB" % (
			f, os.path.relpath(dst, ROOT), size[0], size[1], q,
			os.path.getsize(src) // 1024, os.path.getsize(dst) // 1024))


if __name__ == "__main__":
	main()
