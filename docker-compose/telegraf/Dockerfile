FROM telegraf:1.15.3

ARG ARCH

LABEL mantainer="Facu de la Cruz"
LABEL email="fmdlc.unix@gmail.com"
LABEL project="ISP-Checker"
LABEL component="telegraf"

COPY ./bin/entrypoint.sh /entrypoint.sh

RUN apt-get update && apt-get install -y --no-install-recommends \
    mtr=0.92-2 \
    speedtest-cli=2.0.2-1+deb10u2 && \
    rm -rf /var/lib/apt/lists/* && \
    usermod -G video telegraf

EXPOSE 8125/udp 8092/udp 8094

ENTRYPOINT ["/entrypoint.sh"]

CMD ["telegraf"]
