@echo off
setlocal

:: 设置 Android NDK 路径（请修改为你的路径）
set ANDROID_NDK=C:\Users\xd\AppData\Local\Android\Sdk\ndk\23.2.8568313

:: 设置 Android 工具链
set TOOLCHAIN=%ANDROID_NDK%\build\cmake\android.toolchain.cmake
set API_LEVEL=21

:: 创建构建目录
cd /d E:\Work\oneTBB
if not exist build-android mkdir build-android
cd build-android

:: 运行 CMake 生成 Android 工程
cmake .. -G "Ninja" -DCMAKE_TOOLCHAIN_FILE=%TOOLCHAIN% -DANDROID_NDK=%ANDROID_NDK% -DANDROID_ABI=arm64-v8a -DANDROID_PLATFORM=android-%API_LEVEL% -DCMAKE_BUILD_TYPE=Release -DTBB_TEST=OFF

:: 编译
cmake --build . --config Release -j %NUMBER_OF_PROCESSORS%

echo Build completed!
endlocal
pause
