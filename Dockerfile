FROM docker.io/ubuntu

ENV VPNADDR \
    VPNUSER \
    VPNPASS \
    VPNPORT \
    VPNCONFIG 

ENV DEBIAN_FRONTEND=noninteractive

# update and install openfortivpn
RUN apt-get update && \
  apt-get install -y -o APT::Install-Recommends=false -o APT::Install-Suggests=false \
  ca-certificates \
  openfortivpn \
  iproute2 \
  iptables \
  wget \
  && apt-get clean -q && apt-get autoremove --purge \
  && rm -rf /var/lib/apt/lists/*


COPY start.sh /start.sh
run chmod +x start.sh
CMD [ "/start.sh" ]
