@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion
title МЕНЕДЖЕР АВТОЗАГРУЗКИ ОТ ВИДЯКИНА М.А.
color 07
cls

:MENU
cls
echo.
echo ==================================================
echo            МЕНЕДЖЕР АВТОЗАГРУЗКИ
echo            ОТ ВИДЯКИНА М.А.
echo ==================================================
echo.
echo Список программ в автозагрузке (HKCU\...\Run):
echo.
set "count=0"
for /f "tokens=1,2*" %%a in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" 2^>nul ^| findstr /v "HKEY"') do (
    set /a count+=1
    set "app_name_!count!=%%a"
    set "app_path_!count!=%%b"
    echo [!count!] %%a
)

if %count%==0 (
    echo [ПУСТО] В автозагрузке нет программ.
    pause
    exit
)

echo.
echo [0] Выход
echo ==================================================
set /p "choice=Введите номер программы для УДАЛЕНИЯ из автозагрузки (или 0 для выхода): "

if "%choice%"=="0" exit
if not defined app_name_%choice% (
    echo [ОШИБКА] Неверный номер.
    pause
    goto MENU
)

:: Удаление из реестра
set "target_app=!app_name_%choice%!"
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "!target_app!" /f >nul 2>&1

if %errorlevel%==0 (
    echo.
    echo [УСПЕХ] Программа "!target_app!" удалена из автозагрузки!
) else (
    echo.
    echo [ОШИБКА] Не удалось удалить. Возможно, нужны права администратора.
)
pause
goto MENU