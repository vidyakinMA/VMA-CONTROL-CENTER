@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion
title БЭКАП-МАШИНА ОТ ВИДЯКИНА М.А.
color 07
cls

:MENU
cls
echo.
echo ==================================================
echo            БЭКАП-МАШИНА ОТ ВИДЯКИНА М.А.
echo ==================================================
echo.
echo ИНСТРУКЦИЯ:
echo 1. Для копирования ВСЕЙ системы выберите пункт 1.
echo 2. Для копирования конкретной папки (например, Документы)
echo    выберите пункт 2 и введите полный путь.
echo    Пример: C:\Users\MAKAR\Documents
echo 3. Для копирования СВОИХ файлов (из папки "Мои документы"
echo    и "Рабочий стол") выберите пункт 3.
echo.
echo ==================================================
echo Доступные диски и устройства:
echo.

:: Определяем все доступные диски и их названия
for /f "skip=1 tokens=1,2" %%a in ('wmic logicaldisk get DeviceID^,VolumeName') do (
    if not "%%a"=="" (
        if "%%b"=="" (
            echo [%%a] Локальный диск (Без имени)
        ) else (
            echo [%%a] Флешка / Диск: %%b
        )
    )
)

echo.
echo ==================================================
echo ВЫБЕРИТЕ ДЕЙСТВИЕ:
echo [1] Скопировать ВСЮ систему (C:\) на флешку
echo [2] Скопировать конкретную папку по пути
echo [3] Скопировать важные файлы (Документы + Рабочий стол)
echo [0] Выход
echo ==================================================
echo.
set /p "choice=Введите номер действия: "

if "%choice%"=="0" exit
if "%choice%"=="1" goto COPY_SYSTEM
if "%choice%"=="2" goto COPY_FOLDER
if "%choice%"=="3" goto COPY_IMPORTANT
echo.
echo [ОШИБКА] Неверный выбор. Попробуйте снова.
pause
goto MENU

:COPY_SYSTEM
cls
echo.
echo ==================================================
echo            КОПИРОВАНИЕ ВСЕЙ СИСТЕМЫ (C:\)
echo ==================================================
echo ВНИМАНИЕ: Это займет много времени и места!
echo.
set /p "dest_drive=Введите букву диска для сохранения (например, E:): "
if not exist "%dest_drive%\" (
    echo [ОШИБКА] Диск %dest_drive% не найден!
    pause
    goto MENU
)
set "dest_path=%dest_drive%\FULL_SYSTEM_BACKUP"
echo.
echo Копирование системы на %dest_drive%...
echo Пожалуйста, подождите...
robocopy "C:\" "%dest_path%" /E /R:1 /W:1 /XD "C:\Windows" "C:\Program Files" "C:\Program Files (x86)" "C:\$Recycle.Bin" >nul
echo.
echo [УСПЕХ] Копия системы создана в %dest_path%
pause
goto MENU

:COPY_FOLDER
cls
echo.
echo ==================================================
echo            КОПИРОВАНИЕ ПАПКИ ПО ПУТИ
echo ==================================================
echo.
echo Примеры путей:
echo - C:\Users\MAKAR\Documents
echo - D:\Игры\Subnautica\SNAppData
echo.
set /p "source_path=Введите путь к папке (откуда копировать): "
if not exist "%source_path%" (
    echo [ОШИБКА] Папка "%source_path%" не найдена!
    pause
    goto MENU
)
echo.
set /p "dest_drive=Введите букву диска для сохранения (например, E:): "
if not exist "%dest_drive%\" (
    echo [ОШИБКА] Диск %dest_drive% не найден!
    pause
    goto MENU
)
:: Создаем папку с именем исходной папки
for %%f in ("%source_path%") do set "folder_name=%%~nxf"
set "dest_path=%dest_drive%\%folder_name%_BACKUP"
echo.
echo Копирование из "%source_path%" на "%dest_path%"...
robocopy "%source_path%" "%dest_path%" /E /R:1 /W:1 >nul
echo.
echo [УСПЕХ] Папка скопирована в %dest_path%
pause
goto MENU

:COPY_IMPORTANT
cls
echo.
echo ==================================================
echo            КОПИРОВАНИЕ ВАЖНЫХ ФАЙЛОВ
echo ==================================================
echo.
echo Будет скопировано:
echo - Ваши Документы (C:\Users\%USERNAME%\Documents)
echo - Ваш Рабочий стол (C:\Users\%USERNAME%\Desktop)
echo.
set /p "dest_drive=Введите букву диска для сохранения (например, E:): "
if not exist "%dest_drive%\" (
    echo [ОШИБКА] Диск %dest_drive% не найден!
    pause
    goto MENU
)
set "dest_path=%dest_drive%\IMPORTANT_BACKUP"
mkdir "%dest_path%"
echo.
echo Копирование Документов...
robocopy "C:\Users\%USERNAME%\Documents" "%dest_path%\Documents" /E /R:1 /W:1 >nul
echo Копирование Рабочего стола...
robocopy "C:\Users\%USERNAME%\Desktop" "%dest_path%\Desktop" /E /R:1 /W:1 >nul
echo.
echo [УСПЕХ] Важные файлы скопированы в %dest_path%
pause
goto MENU