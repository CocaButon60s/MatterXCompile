#!/bin/bash

WORKDIR=$(pwd)

SYSROOT=/opt/fsl-imx-wayland/5.15-kirkstone/sysroots
HOSTBIN=${SYSROOT}/x86_64-pokysdk-linux/usr/bin/aarch64-poky-linux

args=$(cat <<EOF
target_cpu="arm64"
target_os="linux"
sysroot="${SYSROOT}/armv8a-poky-linux"
custom_toolchain="custom"
target_cc="${HOSTBIN}/aarch64-poky-linux-gcc"
target_cxx="${HOSTBIN}/aarch64-poky-linux-g++"
target_ar="${HOSTBIN}/aarch64-poky-linux-ar"
EOF
)

function dbginfo() {
  echo -e "\033[36m$1\033[m"
}

function fetch() {
	dbginfo "start fetch"

	git clone --depth=1 https://github.com/project-chip/connectedhomeip.git
	cd ${WORKDIR}/connectedhomeip
	./scripts/checkout_submodules.py --shallow --platform linux
	git submodule update --init
}

function build() {
	dbginfo "start build"

	cd ${WORKDIR}/connectedhomeip
	source scripts/activate.sh

	cd ${WORKDIR}/connectedhomeip/examples/bridge-app/linux
	gn gen out/debug --args="$args"
	ninja -C out/debug
}

fetch
build
