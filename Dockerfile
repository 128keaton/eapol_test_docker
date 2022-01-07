FROM debian:buster

RUN apt update; apt install -y make gcc wget pkg-config libssl-dev libdbus-1-dev libnl-3-dev libnl-genl-3-dev
RUN wget http://w1.fi/releases/wpa_supplicant-2.9.tar.gz -O wpa_supplicant.tar.gz
RUN tar xzf wpa_supplicant.tar.gz

WORKDIR wpa_supplicant-2.9/wpa_supplicant

RUN cp defconfig .config
RUN sed -i 's/#CONFIG_EAPOL_TEST=y/CONFIG_EAPOL_TEST=y/' .config
RUN make eapol_test
RUN cp eapol_test /usr/local/bin/
WORKDIR /root
