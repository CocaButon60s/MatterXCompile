FROM ubuntu:22.04

ENV TZ=Asia/Tokyo
RUN ln -s /usr/share/zoneinfo/$TZ /etc/localtime


RUN <<EOF
apt-get update

# matter sdk
apt-get install -y git gcc g++ pkg-config libssl-dev libdbus-1-dev libglib2.0-dev libavahi-client-dev ninja-build python3-venv python3-dev python3-pip unzip libgirepository1.0-dev libcairo2-dev libreadline-dev default-jre

# yocto
# apt-get install -y gawk wget git diffstat unzip texinfo gcc build-essential chrpath socat cpio python3 python3-pip python3-pexpect xz-utils debianutils iputils-ping python3-git python3-jinja2 python3-subunit zstd liblz4-tool file locales libacl1

# utility
apt-get install -y neovim sudo

# symbolic link
ln -s python3 /usr/bin/python

useradd -m -s /bin/bash user
EOF

COPY <<EOF /etc/sudoers.d/user
user ALL=(ALL) NOPASSWD: ALL

EOF
