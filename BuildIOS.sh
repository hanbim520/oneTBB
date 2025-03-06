#!/bin/bash

# 设置 iOS SDK 和目标
export IOS_SDK=$(xcrun --sdk iphoneos --show-sdk-path)
export IOS_DEPLOYMENT_TARGET=11.0

# 确保 Ninja 已安装
if ! command -v ninja &> /dev/null; then
    echo "❌ Ninja 未安装，请安装 Ninja（brew install ninja）"
    exit 1
fi

# 创建编译目录
mkdir -p build-ios
cd build-ios

# 运行 CMake 配置
cmake .. \
    -G "Ninja" \
    -DCMAKE_SYSTEM_NAME=iOS \
    -DCMAKE_SYSTEM_PROCESSOR=arm64 \
    -DCMAKE_OSX_SYSROOT="$IOS_SDK" \
    -DCMAKE_OSX_DEPLOYMENT_TARGET="$IOS_DEPLOYMENT_TARGET" \
    -DCMAKE_C_COMPILER="$(xcrun --sdk iphoneos --find clang)" \
    -DCMAKE_CXX_COMPILER="$(xcrun --sdk iphoneos --find clang++)" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_MAKE_PROGRAM=ninja \
    -DTBB_BUILD_STATIC=ON \
    -DTBB_TEST=OFF

# 开始编译
ninja
