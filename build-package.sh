#!/bin/bash

NAME=Leehca-Kernel
VERSION=r1
date="$(date +"%m%d-%H%M")"

find . -name '*.dtb' -exec cat {} + >${HOME}/AnyKernel3/dtb
mv out/arch/arm64/boot/Image.gz ${HOME}/AnyKernel3/Image.gz
mv out/arch/arm64/boot/dtbo.img ${HOME}/AnyKernel3/dtbo.img

cd ${HOME}/AnyKernel3
zip -r $NAME-$VERSION-$date.zip *
