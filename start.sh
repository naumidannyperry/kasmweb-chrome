#!/usr/bin/env bash
set -euo pipefail

# Railway selalu ngasih PORT. Kalau tidak ada, default 8080.
export PORT="${PORT:-8080}"

# Start Kasm default entrypoint (sesuai image layer)
# ENTRYPOINT: kasm_default_profile.sh vnc_startup.sh kasm_startup.sh
# CMD: --wait
/dockerstartup/kasm_default_profile.sh /dockerstartup/vnc_startup.sh /dockerstartup/kasm_startup.sh --wait &
KASM_PID=$!

# Tunggu KasmVNC siap di 6901
for i in {1..60}; do
  if (echo >/dev/tcp/127.0.0.1/6901) >/dev/null 2>&1; then
    break
  fi
  sleep 1
done

# Render nginx config dari template
envsubst '${PORT}' < /etc/nginx/templates/kasm.conf.template > /etc/nginx/conf.d/kasm.conf

# Jika container dimatikan, matikan juga proses kasm
trap "kill $KASM_PID 2>/dev/null || true" TERM INT

# Nginx foreground (jadi Railway lihat service “listen” di $PORT)
exec nginx -g 'daemon off;'
