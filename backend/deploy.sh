#!/bin/bash
echo "Production incoming ..."
curl -L https://fly.io/install.sh | sh

export FLYCTL_INSTALL="/home/koni/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

fly deploy