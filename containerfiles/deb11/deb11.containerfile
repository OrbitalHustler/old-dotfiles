FROM debian:11.0

RUN apt-get update
RUN apt-get -y full-upgrade
RUN apt-get -y install git curl file build-essential lsb-release vim sudo zsh

RUN useradd -ms /bin/bash podmatt
RUN chsh -s /bin/zsh podmatt
RUN echo 'podmatt ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN echo 'podmatt:podmatt' | chpasswd

USER podmatt

COPY  --chown=podmatt:users ./chezmoi-init.sh /home/podmatt/
WORKDIR /home/podmatt/

# ENTRYPOINT ["sh", "docker-entrypoint.sh"]
# ENTRYPOINT ["bash"]
# CMD bash
