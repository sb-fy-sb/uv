@echo off
chcp 936 >nul
title Push uv to HarmonyOS

set "HDC=C:\Program Files\Huawei\DevEco Studio\sdk\default\openharmony\toolchains\hdc.exe"
set "SRC=%~dp0"

echo ============================================
echo   Push uv + uv_verify.py to HarmonyOS
echo ============================================
echo.

if not exist "%HDC%" (
    echo [ERROR] hdc not found
    pause
    exit /b 1
)

echo [1/8] Check device...
"%HDC%" list targets 2>nul
echo.
"%HDC%" list targets 2>nul | findstr /i /c:"[Empty]" >nul
if %errorlevel%==0 (
    echo [ERROR] No device found
    pause
    exit /b 1
)
echo.

echo [2/8] Enter root mode...
"%HDC%" smode
echo   Waiting for reconnect...
timeout /t 3 /nobreak >nul
"%HDC%" list targets 2>nul
echo.

echo [3/8] Set SELinux Permissive...
"%HDC%" shell setenforce 0
echo.

echo [4/8] Remount /system as writable...
"%HDC%" target mount
echo.

echo [5/8] Push uv...
"%HDC%" file send "%SRC%uv" /data/local/tmp/uv
if %errorlevel% neq 0 (
    echo [ERROR] Push uv failed
    pause
    exit /b 1
)
echo.

echo [6/8] Push uv_verify.py...
"%HDC%" file send "%SRC%uv_verify.py" /data/local/tmp/uv_verify.py
if %errorlevel% neq 0 (
    echo [ERROR] Push uv_verify.py failed
    pause
    exit /b 1
)
echo.

echo [7/8] Set permissions...
"%HDC%" shell chmod +x /data/local/tmp/uv
"%HDC%" shell chmod +x /data/local/tmp/uv_verify.py
echo.

echo [8/8] Create symlinks in PATH...
"%HDC%" shell mkdir -p /usr/local/bin
"%HDC%" shell ln -sf /data/local/tmp/uv /usr/local/bin/uv
"%HDC%" shell ln -sf /data/local/tmp/uv_verify.py /usr/local/bin/uv_verify.py
echo.

echo ============================================
echo   Verify
echo ============================================
echo.
echo [symlinks]
"%HDC%" shell ls -la /usr/local/bin/
echo.
echo [uv version]
"%HDC%" shell uv --version
echo.
echo [SELinux]
"%HDC%" shell getenforce
echo.
echo ============================================
echo   All done!
echo.
echo   You can now use uv directly in hdc shell
echo ============================================
pause