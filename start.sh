#!/usr/bin/env bash
set -e

# Railway menyediakan PORT dinamis. Kalau tidak ada, fallback ke 6901.
export NO_VNC_PORT="${PORT:-6901}"

# VNC server tetap internal 5901 (default image)
export VNC_PORT="${VNC_PORT:-5901}"

# Passwordless (biar tidak minta password di web)
export VNC_PASSWORDLESS="${VNC_PASSWORDLESS:-true}"

echo "[boot] NO_VNC_PORT=$NO_VNC_PORT  VNC_PORT=$VNC_PORT  PASSWORDLESS=$VNC_PASSWORDLESS"

exec /dockerstartup/vnc_startup.sh --wait
