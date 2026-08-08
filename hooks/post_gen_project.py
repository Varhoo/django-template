"""Post-generation hook: inject a Django SECRET_KEY into settings."""

from pathlib import Path
from secrets import choice

PLACEHOLDER = "<cookiecutter.hooks.generate_key>"
# Same character set as django.core.management.utils.get_random_secret_key
CHARS = "abcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*(-_=+)"


def generate_secret_key(length=50):
    return "".join(choice(CHARS) for _ in range(length))


def set_secret_key():
    settings_path = Path("{{ cookiecutter.package_name }}") / "settings" / "basic.py"
    content = settings_path.read_text(encoding="utf-8")
    if PLACEHOLDER not in content:
        return
    settings_path.write_text(content.replace(PLACEHOLDER, generate_secret_key()), encoding="utf-8")


if __name__ == "__main__":
    set_secret_key()
