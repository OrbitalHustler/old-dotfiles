#!/usr/bin/env bash

BINDIR="$HOME/.local/bin" sh -c "$(curl -fsLS git.io/chezmoi)" -- init Percee
cd "$HOME/.local/share/chezmoi"
