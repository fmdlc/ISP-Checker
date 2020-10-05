FROM telegraf:latest

LABEL mantainer="Facu de la Cruz"
LABEL PROJECT="ISP_monitor"

COPY ./bin/entrypoint.sh /entrypoint.sh

RUN apt-get update && apt-get install -y --no-install-recommends \
    mtr \
    speedtest-cli && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 8125/udp 8092/udp 8094

ENTRYPOINT ["/entrypoint.sh"]

CMD ["telegraf"]
