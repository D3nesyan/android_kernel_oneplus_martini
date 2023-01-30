#!/bin/bash

defconfig="vendor/lahaina-qgki_defconfig"
date="$(date +"%m%d-%H%M")"

export KBUILD_BUILD_HOST="D3nesyan"

args="CC=${HOME}/toolchain/clang-r450784d/bin/clang \
        LD=${HOME}/toolchain/clang-r450784d/bin/ld.lld \
        AR=${HOME}/toolchain/clang-r450784d/bin/llvm-ar \
        NM=${HOME}/toolchain/clang-r450784d/bin/llvm-nm \
        OBJCOPY=${HOME}/toolchain/clang-r450784d/bin/llvm-objcopy \
        OBJDUMP=${HOME}/toolchain/clang-r450784d/bin/llvm-objdump \
        STRIP=${HOME}/toolchain/clang-r450784d/bin/llvm-strip \
        O=out \
        LLVM=1 \
        LLVM_IAS=1 \
        ARCH=arm64 \
        -j$(nproc) "

print() {
    case ${2} in
        "red")
            echo -e "\033[31m $1 \033[0m"
            ;;

        "blue")
            echo -e "\033[34m $1 \033[0m"
            ;;

        "yellow")
            echo -e "\033[33m $1 \033[0m"
            ;;

        "purple")
            echo -e "\033[35m $1 \033[0m"
            ;;

        "sky")
            echo -e "\033[36m $1 \033[0m"
            ;;

        "green")
            echo -e "\033[32m $1 \033[0m"
            ;;

        *)
            echo $1
            ;;
    esac
}

print "Removing output dir" yellow
rm -rf out

print "Compilation Start" green
START=$(date +"%s")
make $args $defconfig && make $args
if [ $? -ne 0 ]; then
    print "Compilation failed" red
else
    print "Compilation Success" green
    END=$(date +"%s")
    KDURTION=$((END - START))
    print "Cost time $((KDURTION / 60)) min $((KDURTION % 60)) s" blue
    if [ "${1}" != "skip" ]; then
        print "Start to build package" yellow
        ./build-package.sh || exit 1
    fi
fi
exit 1
