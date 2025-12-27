FROM kasmweb/chrome:1.18.0-rolling-daily

USER root

# Railway Public Networking expects HTTP to the container.
# KasmVNC startup uses -sslOnly by default; remove it so it can accept HTTP (and HTTPS) on the same port.
RUN sed -i 's/ -sslOnly//g' /dockerstartup/vnc_startup.sh

# Defaults (lebih aman kamu override via Railway Variables)
ENV VNC_PW=123456
ENV LAUNCH_URL=https://www.google.com
# Bantu kalau /dev/shm kecil (sering bikin Chrome crash di container)
ENV APP_ARGS=--disable-dev-shm-usage

EXPOSE 6901

# Kasm images typically run as uid 1000
USER 1000
