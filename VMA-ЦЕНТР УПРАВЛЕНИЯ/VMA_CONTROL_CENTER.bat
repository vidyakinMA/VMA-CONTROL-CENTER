@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion
title VMA CONTROL CENTER - V 4.5
mode con: cols=90 lines=40
color 0F
cls

:MAIN_MENU
cls
echo.
echo  ██╗   ██╗███╗   ███╗ █████╗ 
echo  ██║   ██║████╗ ████║██╔══██╗
echo  ██║   ██║██╔████╔██║███████║
echo  ╚██╗ ██╔╝██║╚██╔╝██║██╔══██║
echo   ╚████╔╝ ██║ ╚═╝ ██║██║  ██║
echo    ╚═══╝  ╚═╝     ╚═╝╚═╝  ╚═╝
echo.
echo ======================================================================
echo                  V M A   C O N T R O L   C E N T E R
echo                        ОТ ВИДЯКИНА М.А.
echo ======================================================================
echo.
echo    Выберите категорию:
echo.
echo    [1]  СИСТЕМНЫЕ УТИЛИТЫ (Диагностика, Сеть, Бэкапы)
echo    [2]  РАЗВЛЕЧЕНИЯ (Игры, Музыка)
echo.
echo    [0]  ВЫХОД
echo.
echo ======================================================================
set "main_choice="
set /p "main_choice=  >> ВАШ ВЫБОР: "

if "%main_choice%"=="0" goto EXIT
if "%main_choice%"=="1" goto SYSTEM_MENU
if "%main_choice%"=="2" goto FUN_MENU
goto MAIN_MENU

:: ======================================================================
:: РАЗДЕЛ 1: СИСТЕМНЫЕ УТИЛИТЫ
:: ======================================================================
:SYSTEM_MENU
cls
echo.
echo ======================================================================
echo                 [ СИСТЕМНЫЕ УТИЛИТЫ ]
echo ======================================================================
echo.
echo    [1] Системный Информатор (SystemInfo)
echo    [2] Сканер Портов и Сетей (PortScanner)
echo    [3] Пинг-Тестер (PingTest)
echo    [4] Бэкап-Машина (BackupPro)
echo    [5] Генератор Паролей (PasswordSystem)
echo    [6] Умный Сортировщик Файлов (FileOrganizer)
echo    [7] Менеджер Автозагрузки (StartupManager)
echo.
echo    [0] НАЗАД В ГЛАВНОЕ МЕНЮ
echo ======================================================================
set "choice="
set /p "choice=  >> ВАШ ВЫБОР: "

if "%choice%"=="0" goto MAIN_MENU
if "%choice%"=="1" goto RUN_1
if "%choice%"=="2" goto RUN_2
if "%choice%"=="3" goto RUN_3
if "%choice%"=="4" goto RUN_4
if "%choice%"=="5" goto RUN_5
if "%choice%"=="6" goto RUN_6
if "%choice%"=="7" goto RUN_7
goto SYSTEM_MENU

:RUN_1
if exist "%~dp0SystemInfo.bat" ( call "%~dp0SystemInfo.bat" ) else ( echo [ОШИБКА] Файл SystemInfo.bat не найден! & pause )
goto SYSTEM_MENU
:RUN_2
if exist "%~dp0PortScanner.bat" ( call "%~dp0PortScanner.bat" ) else ( echo [ОШИБКА] Файл PortScanner.bat не найден! & pause )
goto SYSTEM_MENU
:RUN_3
if exist "%~dp0PingTest.bat" ( call "%~dp0PingTest.bat" ) else ( echo [ОШИБКА] Файл PingTest.bat не найден! & pause )
goto SYSTEM_MENU
:RUN_4
if exist "%~dp0BackupPro.bat" ( call "%~dp0BackupPro.bat" ) else ( echo [ОШИБКА] Файл BackupPro.bat не найден! & pause )
goto SYSTEM_MENU
:RUN_5
if exist "%~dp0PasswordSystem.bat" ( call "%~dp0PasswordSystem.bat" ) else ( echo [ОШИБКА] Файл PasswordSystem.bat не найден! & pause )
goto SYSTEM_MENU
:RUN_6
if exist "%~dp0FileOrganizer.bat" ( call "%~dp0FileOrganizer.bat" ) else ( echo [ОШИБКА] Файл FileOrganizer.bat не найден! & pause )
goto SYSTEM_MENU
:RUN_7
if exist "%~dp0StartupManager.bat" ( call "%~dp0StartupManager.bat" ) else ( echo [ОШИБКА] Файл StartupManager.bat не найден! & pause )
goto SYSTEM_MENU

:: ======================================================================
:: РАЗДЕЛ 2: РАЗВЛЕЧЕНИЯ
:: ======================================================================
:FUN_MENU
cls
echo.
echo ======================================================================
echo                    [ РАЗВЛЕЧЕНИЯ ]
echo ======================================================================
echo.
echo    [1] Запустить Steam Client (Поиск игр)
echo    [2] Музыкальный Центр (Плеер)
echo.
echo    [0] НАЗАД В ГЛАВНОЕ МЕНЮ
echo ======================================================================
set "fun_choice="
set /p "fun_choice=  >> ВАШ ВЫБОР: "

if "%fun_choice%"=="0" goto MAIN_MENU
if "%fun_choice%"=="1" goto RUN_STEAM
if "%fun_choice%"=="2" goto MUSIC_MENU
goto FUN_MENU

:RUN_STEAM
if exist "%~dp0SteamLibrary.bat" ( call "%~dp0SteamLibrary.bat" ) else ( echo [ОШИБКА] Файл SteamLibrary.bat не найден! & pause )
goto FUN_MENU

:: ======================================================================
:: МУЗЫКАЛЬНЫЙ ЦЕНТР (ЗАПУСК ЧЕРЕЗ СИСТЕМНЫЙ ПЛЕЕР)
:: ======================================================================
:MUSIC_MENU
cls
echo.
echo ======================================================================
echo                    [ МУЗЫКАЛЬНЫЙ ЦЕНТР VMA ]
echo ======================================================================
echo.

set "MUSIC_DIR="
if exist "%~dp0Музыка для клиента" set "MUSIC_DIR=%~dp0Музыка для клиента"
if exist "%~dp0музыка для клиента" set "MUSIC_DIR=%~dp0музыка для клиента"

if not defined MUSIC_DIR (
    echo    [ОШИБКА] Папка "Музыка для клиента" не найдена!
    pause
    goto FUN_MENU
)

set "track_count=0"
for %%f in ("!MUSIC_DIR!\*.wav") do (
    set /a track_count+=1
    set "track_!track_count!=%%~nxf"
    set "path_!track_count!=%%~ff"
    echo    [!track_count!] %%~nxf
)

if !track_count!==0 (
    echo    [ПУСТО] В папке нет .wav файлов!
    pause
    goto FUN_MENU
)

echo.
echo    [0] НАЗАД
echo ======================================================================
set "music_choice="
set /p "music_choice=  >> ВЫБЕРИТЕ ТРЕК: "

if "%music_choice%"=="0" goto FUN_MENU
if not defined track_%music_choice% (
    echo [ОШИБКА] Неверный номер трека.
    pause
    goto MUSIC_MENU
)

set "selected_track=!path_%music_choice%!"
echo.
echo Открываю файл в стандартном плеере Windows:
echo !selected_track!
echo.

:: Запуск файла через ассоциацию Windows (откроется плеер по умолчанию)
start "" "!selected_track!"

echo (Плеер запущен. Закройте его, когда наслушаетесь.)
pause
goto MUSIC_MENU

:EXIT
taskkill /f /im powershell.exe >nul 2>&1
exit