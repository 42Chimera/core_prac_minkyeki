#!/bin/bash

print_style () {
    if [ "$2" == "info" ] ; then
        COLOR="96m";
    elif [ "$2" == "success" ] ; then
        COLOR="92m";
    elif [ "$2" == "warning" ] ; then
        COLOR="93m";
    elif [ "$2" == "danger" ] ; then
        COLOR="91m";
    else #default color
        COLOR="0m";
    fi
    STARTCOLOR="\e[$COLOR";
    ENDCOLOR="\e[0m";
    printf "$STARTCOLOR%b$ENDCOLOR" "$1";
}

print_dependency_header () {
  print_style "-------------------------------------------\n" "info";
  print_style "   Building $1 \n"                             "info";
  print_style "-------------------------------------------\n" "info";
}

print_dependency_header skia
#
# 리눅스 / 윈도우 기본 빌드 
# ----------------------------------------------------------------------------
# https://skia.org/docs/user/download/
# git clone 'https://chromium.googlesource.com/chromium/tools/depot_tools.git'
# export PATH="${PWD}/depot_tools:${PATH}"
# git clone https://skia.googlesource.com/skia.git
# cd skia
# python3 tools/git-sync-deps
# bin/fetch-ninja

# ----------------------------------------------------------------------------
# https://skia.org/docs/user/build/
# tools/install_dependencies.sh
# bin/gn gen out/Static --args='is_official_build=true'
# ninja -C out/Static

# ----------------------------------------------------------------------------
# MacOS build 방식
# MacOS build 는 다르게 해야 합니다! 아래 링크 참조.
# https://gist.github.com/velyan/7f474a09c51d2c7b658036913edfe003
mkdir $PWD/source
cd $PWD/source
git clone 'https://chromium.googlesource.com/chromium/tools/depot_tools.git'
export PATH="${PWD}/depot_tools:${PATH}"
git clone https://skia.googlesource.com/skia.git
cd skia
python3 tools/git-sync-deps
bin/fetch-ninja
# //static
# bin/gn gen out/release --args="is_official_build=true skia_use_system_expat=false skia_use_system_icu=false skia_use_libjpeg_turbo=false skia_use_system_libpng=false skia_use_system_libwebp=false skia_use_system_zlib=false skia_use_libwebp=false extra_cflags_cc=[\"-frtti\"]"

# //dynamic
bin/gn gen out/release \
    --args="is_official_build=true \
            is_component_build=true \
            skia_use_system_expat=false \
            skia_use_system_icu=false \
            skia_use_libjpeg_turbo_decode=false \
            skia_use_libjpeg_turbo_encode=false \
            skia_use_system_libpng=false \
            skia_use_system_libwebp=false \
            skia_use_system_zlib=false \
            extra_cflags_cc=[\"-frtti\"] \
            "

ninja -C out/release skia
# --> link libskia.dylib