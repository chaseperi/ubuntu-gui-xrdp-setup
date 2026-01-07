#!/usr/bin/env bash

set -e

echo "=== Updating system ==="
sudo apt update

echo "=== Installing XRDP and GNOME session ==="
sudo apt install -y xrdp gnome-session

echo "=== Adding xrdp user to ssl-cert group ==="
sudo adduser xrdp ssl-cert

echo "=== Configuring GNOME session for XRDP ==="

# Create ~/.xsession
cat <<EOF > ~/.xsession
gnome-session
EOF

# Create ~/.xsessionrc
cat <<EOF > ~/.xsessionrc
export XAUTHORITY=\${HOME}/.Xauthority
export GNOME_SHELL_SESSION_MODE=ubuntu
export XDG_CONFIG_DIRS=/etc/xdg/xdg-ubuntu:/etc/xdg
EOF

echo "=== Restarting XRDP service ==="
sudo systemctl restart xrdp

echo "=== XRDP setup complete ==="
