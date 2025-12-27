FROM consol/rocky-xfce-vnc:v2.0.4

USER 0
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Default: tanpa password (kamu bisa override dari Railway Variables)
ENV VNC_PASSWORDLESS=true

USER 1000
CMD ["/start.sh"]
