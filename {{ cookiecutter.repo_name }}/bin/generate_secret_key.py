#!/usr/bin/env python3
"""Generate a Django SECRET_KEY (same charset as Django's get_random_secret_key)."""

from secrets import choice

CHARS = "abcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*(-_=+)"


def generate_secret_key(length=50):
    return "".join(choice(CHARS) for _ in range(length))


if __name__ == "__main__":
    print(generate_secret_key())
