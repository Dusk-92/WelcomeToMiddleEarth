#!/usr/bin/env python3
from pathlib import Path
import re
import sys
import xml.etree.ElementTree as ET

ROOT = Path(__file__).resolve().parents[1]
PLUGIN = ROOT / "Dusk" / "WelcomeToMiddleEarth.plugin"
MAIN = ROOT / "Dusk" / "WelcomeToMiddleEarth" / "Main.lua"
PROGRESSION = ROOT / "Dusk" / "WelcomeToMiddleEarth" / "Progression.lua"
STRINGS = ROOT / "Dusk" / "WelcomeToMiddleEarth" / "Strings.lua"
IMAGES = ROOT / "Dusk" / "WelcomeToMiddleEarth" / "images"
VERSION = "1.4.17-community"

errors = []

def fail(message):
    errors.append(message)

for path in (PLUGIN, MAIN, PROGRESSION, STRINGS):
    if not path.exists():
        fail(f"Missing required file: {path.relative_to(ROOT)}")

if PLUGIN.exists():
    try:
        tree = ET.parse(PLUGIN)
        root = tree.getroot()
        package = root.findtext("Package")
        version = root.findtext("./Information/Version")
        config = root.find("Configuration")
        if package != "Dusk.WelcomeToMiddleEarth.Main":
            fail(f"Unexpected package: {package!r}")
        if version != VERSION:
            fail(f"Plugin version is {version!r}, expected {VERSION!r}")
        if config is None or config.get("Apartment") != "Dusk.WelcomeToMiddleEarth":
            fail("Missing/incorrect Dusk.WelcomeToMiddleEarth Apartment")
    except ET.ParseError as exc:
        fail(f"Invalid plugin XML: {exc}")

texts = {}
for name, path in (("Main.lua", MAIN), ("Progression.lua", PROGRESSION), ("Strings.lua", STRINGS)):
    if path.exists():
        texts[name] = path.read_text(encoding="utf-8")

for name, content in texts.items():
    if "Thardariel.WelcomeToMiddleEarth" in content or "Thardariel/WelcomeToMiddleEarth" in content:
        fail(f"Legacy namespace remains in {name}")

for name in ("Main.lua", "Progression.lua", "Strings.lua"):
    if VERSION not in texts.get(name, ""):
        fail(f"{name} version is not synchronized")

main = texts.get("Main.lua", "")
for rel in sorted(set(re.findall(r'Dusk/WelcomeToMiddleEarth/images/([^"]+)', main))):
    if not (IMAGES / rel).exists():
        fail(f"Missing image referenced by Main.lua: {rel}")

if PLUGIN.exists():
    plugin_text = PLUGIN.read_text(encoding="utf-8")
    for rel in re.findall(r'Dusk/WelcomeToMiddleEarth/images/([^<]+)', plugin_text):
        if not (IMAGES / rel).exists():
            fail(f"Missing image referenced by plugin XML: {rel}")

strings = texts.get("Strings.lua", "")

def locale_block(locale, next_locale=None):
    start = strings.find(f" {locale} = {{")
    if start < 0:
        fail(f"Missing locale table: {locale}")
        return ""
    end = strings.find(f" {next_locale} = {{", start) if next_locale else strings.rfind("\n }")
    return strings[start:end if end >= 0 else None]

def keys(block):
    return set(re.findall(r"\b([A-Za-z_][A-Za-z0-9_]*)\s*=", block))

locale_keys = {
    "fr": keys(locale_block("fr", "en")),
    "en": keys(locale_block("en", "de")),
    "de": keys(locale_block("de")),
}
baseline = locale_keys["fr"]
for locale, current in locale_keys.items():
    missing = sorted(baseline - current)
    extra = sorted(current - baseline)
    if missing or extra:
        fail(f"Locale {locale} differs: missing={missing}, extra={extra}")

used_text_keys = set(re.findall(r"\btext\.([A-Za-z_][A-Za-z0-9_]*)", main))
for locale, current in locale_keys.items():
    missing = sorted(used_text_keys - current)
    if missing:
        fail(f"Locale {locale} misses keys used by Main.lua: {missing}")

if (ROOT / "Dusk" / "WelcomeToMiddleEarth" / "__init__.lua").exists():
    fail("Redundant __init__.lua should not be present")

if errors:
    print("Validation failed:")
    for error in errors:
        print(f" - {error}")
    sys.exit(1)

print("WelcomeToMiddleEarth validation OK")
