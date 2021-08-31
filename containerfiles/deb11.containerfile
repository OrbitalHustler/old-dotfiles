FROM debian:11.0

RUN apt-get update
RUN apt-get -y full-upgrade
RUN apt-get -y install git curl file build-essential lsb-release
RUN apt-get -y install sudo

RUN useradd -ms /bin/bash archie
RUN echo 'archie ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER archie

COPY  --chown=archie:users .. ./home/archie/dotfiles
WORKDIR /home/archie/dotfiles

# ENTRYPOINT ["sh", "docker-entrypoint.sh"]
# ENTRYPOINT ["bash"]
# CMD bash
