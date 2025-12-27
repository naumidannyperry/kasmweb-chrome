FROM kasmweb/chrome:1.18.0-rolling-daily

USER root

RUN apt-get update \
 && apt-get install -y --no-install-recommends nginx gettext-base ca-certificates \
 && rm -rf /var/lib/apt/lists/* \
 && rm -f /etc/nginx/sites-enabled/default

COPY nginx.conf.template /etc/nginx/templates/kasm.conf.template
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Railway akan route ke $PORT (nginx yang listen), Kasm tetap internal di 6901
ENTRYPOINT ["/start.sh"]
