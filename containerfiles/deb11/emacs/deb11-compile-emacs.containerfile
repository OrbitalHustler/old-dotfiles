FROM debian:11.0

RUN apt-get update
RUN apt-get -y full-upgrade
RUN apt-get -y install wget libssl-dev libcurl4-gnutls-dev gettext librsvg2-dev liblcms2-dev \
    libgccjit-10-dev man-db make autoconf build-essential autoconf texinfo libxaw7-dev libcairo2-dev \
    libharfbuzz-dev libgif-dev libtiff-dev libjpeg-dev libpng-dev libxpm-dev libgnutls28-dev pkg-config \
    libncurses-dev libjansson-dev libvterm-dev cmake mailutils libgtk-3-dev libgpm-dev libgconf2-dev \
    libotf-dev libm17n-dev libwebkit2gtk-4.0-dev curl git sudo checkinstall vim sudo

RUN useradd -ms /bin/bash podmatt
RUN echo 'podmatt ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN echo 'podmatt:podmatt' | chpasswd
USER podmatt
WORKDIR /home/podmatt/

COPY clone-emacs.sh /home/podmatt/
COPY configure-emacs.sh /home/podmatt/


# ENTRYPOINT ["sh"]
