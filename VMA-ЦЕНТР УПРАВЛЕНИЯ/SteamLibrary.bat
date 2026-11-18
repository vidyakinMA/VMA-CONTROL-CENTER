@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion
title VMA Steam Client (v2.1)
color 0B
cls

:LOGIN
cls
echo.
echo ==================================================
echo            VMA STEAM CLIENT (ИМИТАЦИЯ)
echo            ОТ ВИДЯКИНА М.А.
echo ==================================================
echo.
echo Вход в аккаунт Steam:
echo.
set /p "user=Логин: "
set /p "pass=Пароль: "
echo.
echo Проверка учетных данных...
timeout /t 1 >nul
echo Подключение к серверам Steam...
timeout /t 1 >nul
echo Успешный вход!
timeout /t 1 >nul
goto LIBRARY

:LIBRARY
cls
echo.
echo ==================================================
echo            БИБЛИОТЕКА ИГР
echo            (Поиск по всем дискам...)
echo ==================================================
echo.

set "count=0"

:: Ищем папку common на всех локальных дисках
for %%D in (C D E F G H) do (
    if exist "%%D:\" (
        if exist "%%D:\Steam\steamapps\common" (
            call :SCAN "%%D:\Steam\steamapps\common"
        )
        if exist "%%D:\SteamLibrary\steamapps\common" (
            call :SCAN "%%D:\SteamLibrary\steamapps\common"
        )
        if exist "%%D:\Program Files (x86)\Steam\steamapps\common" (
            call :SCAN "%%D:\Program Files (x86)\Steam\steamapps\common"
        )
    )
)

if %count%==0 (
    echo [ПУСТО] Игры не найдены.
    pause
    exit
)

echo.
echo [0] Выход
echo ==================================================
set /p "game_choice=Выберите номер игры: "

if "%game_choice%"=="0" exit
if not defined game_%game_choice% (
    echo [ОШИБКА] Неверный номер.
    pause
    goto LIBRARY
)

:: Запуск игры
set "target_path=!path_%game_choice%!"
echo.
echo Поиск запускающего файла в "%target_path%"...

:: Ищем .exe файл, игнорируя uninstall, dxsetup, vcredist и т.д.
set "found_exe="
for %%f in ("%target_path%\*.exe") do (
    set "exe_name=%%~nxf"
    set "skip=0"
    if /I "!exe_name!"=="uninstall.exe" set "skip=1"
    if /I "!exe_name!"=="dxsetup.exe" set "skip=1"
    if /I "!exe_name!"=="vcredist_x64.exe" set "skip=1"
    if /I "!exe_name!"=="vcredist_x86.exe" set "skip=1"
    
    if !skip!==0 (
        if not defined found_exe (
            set "found_exe=%%~ff"
            echo Найден: !exe_name!
        )
    )
)

if defined found_exe (
    echo Запуск игры...
    start "" "!found_exe!"
) else (
    echo [ОШИБКА] Запускающий файл не найден. Открываю папку.
    explorer "!target_path!"
)

pause
goto LIBRARY

:SCAN
set "folder_path=%~1"
for /d %%d in ("%folder_path%\*") do (
    if /I not "%%~nxd"=="Steamworks Shared" (
        if /I not "%%~nxd"=="Steam Controller Configs" (
            set /a count+=1
            set "game_!count!=%%~nxd"
            set "path_!count!=%%~fd"
            echo [!count!] %%~nxd
        )
    )
)
exit /b