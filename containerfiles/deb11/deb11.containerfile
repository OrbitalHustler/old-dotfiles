FROM debian:11.0

RUN apt-get update
RUN apt-get -y full-upgrade
RUN apt-get -y install git curl file build-essential lsb-release vim sudo zsh
RUN apt-get -y install apt-file autoconf bash-completion build-essential cmake copyq curl dvipng editorconfig gawk gettext glslang-tools gnuplot graphviz imagemagick isync libbz2-dev libffi-dev libgccjit0 libreadline-dev libsqlite3-dev libssl-dev locate lsb-release maildir-utils mailutils maim make man-db markdown msmtp pkg-config podman source-highlight sqlite3 ssh subversion texinfo texlive texlive-latex-extra tmux vim wget xclip zip zlib1g-dev zsh

RUN useradd -ms /bin/bash podmatt
RUN chsh -s /bin/zsh podmatt
RUN echo 'podmatt ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN echo 'podmatt:podmatt' | chpasswd
USER podmatt
WORKDIR /home/podmatt/

COPY  --chown=podmatt:users ./chezmoi-init.sh /home/podmatt/

# ENTRYPOINT ["sh", "docker-entrypoint.sh"]
# ENTRYPOINT ["bash"]
# CMD bash
