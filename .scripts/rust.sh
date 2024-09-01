#!/bin/sh

sudo apt update
sudo apt install build-essential curl git cmake python3 pkg-config libssl-dev

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

