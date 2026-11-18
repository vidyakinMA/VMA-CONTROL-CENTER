@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
color 07
title СИСТЕМНЫЙ ИНФОРМАТОР

echo.
echo ==================================================
echo            СИСТЕМНЫЙ ИНФОРМАТОР
echo            ОТ ВИДЯКИНА М.А.
echo ==================================================
echo.

echo [1] ОПЕРАЦИОННАЯ СИСТЕМА:
wmic os get Caption, Version, BuildNumber /format:list | findstr /v /r "^$"
echo.

echo [2] ПРОЦЕССОР:
wmic cpu get Name, NumberOfCores, NumberOfLogicalProcessors /format:list | findstr /v /r "^$"
echo.

echo [3] ОПЕРАТИВНАЯ ПАМЯТЬ (В ГИГАБАЙТАХ):
for /f "skip=1" %%a in ('wmic computersystem get TotalPhysicalMemory') do (
    if not "%%a"=="" (
        set /a RAM=%%a/1024/1024/1024
        echo TotalPhysicalMemory: !RAM! ГБ
        goto :ram_done
    )
)
:ram_done
echo.

echo [4] ВИДЕОКАРТА:
wmic path win32_VideoController get Name, AdapterRAM /format:list | findstr /v /r "^$"
echo.

echo [5] МАТЕРИНСКАЯ ПЛАТА:
wmic baseboard get Manufacturer, Product /format:list | findstr /v /r "^$"
echo.

echo [6] ДИСКИ (ЛОГИЧЕСКИЕ):
wmic logicaldisk get DeviceID, VolumeName, Size, FreeSpace /format:list | findstr /v /r "^$"
echo.

echo [7] IP-АДРЕС И СЕТЬ:
ipconfig | findstr /i "IPv4"
echo.

echo ==================================================
echo            СБОР ИНФОРМАЦИИ ЗАВЕРШЕН
echo            ОТ ВИДЯКИНА М.А.
echo ==================================================
echo.
pause