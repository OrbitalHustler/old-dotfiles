#!/usr/bin/env bash
set -euo pipefail

./autogen.sh
./configure --with-native-compilation --with-x-toolkit=lucid --with-modules --prefix=$1
