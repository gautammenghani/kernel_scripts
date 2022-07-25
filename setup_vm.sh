#!/bin/bash

# When setting up a QEMU vm, it is generally bare bones so this script makes it easy to setup things

apt update
echo "[+] Install vim"
apt install vim -y

echo "[+] Create syzkaller_bugs dir"
mkdir syzkaller_bugs

echo "[+] Install go"
mkdir tools
cd tools
apt install wget -y
wget https://go.dev/dl/go1.18.4.linux-amd64.tar.gz
tar -xf go1.18.4.linux-amd64.tar.gz
rm go1.18.4.linux-amd64.tar.gz
echo "export GOROOT=\"/root/tools/go\"" >> ~/.bashrc
echo "export PATH=\$GOROOT/bin:\$PATH" >> ~/.bashrc
source ~/.bashrc

echo "[+] Install syzkaller"
apt install make git gcc g++ flex bison libncurses-dev libelf-dev libssl-dev -y
cd ~/tools
git clone https://github.com/google/syzkaller --depth 1
cd syzkaller
make -j1


