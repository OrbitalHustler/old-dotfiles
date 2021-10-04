#!/usr/bin/env bash
set -euo pipefail

make -j16
# Fix because bug on WSL 2 Debian 11, dunno why
#umask 022 && /bin/mkdir -p "/usr/local/libexec/emacs/28.0.50/x86_64-pc-linux-gnu"
#checkinstall -D -y \
#    --pkgname emacs \
#    --pkgversion 28.0.50 \
#    make install
