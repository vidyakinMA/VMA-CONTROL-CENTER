@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion
title СИСТЕМА ПАРОЛЕЙ ОТ ВИДЯКИНА М.А.
color 07
cls

:MENU
cls
echo.
echo ==================================================
echo            СИСТЕМА ПАРОЛЕЙ
echo            ОТ ВИДЯКИНА М.А.
echo ==================================================
echo.
echo [1] Создать пароль вручную
echo [2] Открыть генератор паролей
echo [0] Выход
echo.
set /p "choice=Выберите действие: "

if "%choice%"=="0" exit
if "%choice%"=="1" goto MANUAL
if "%choice%"=="2" goto GENERATOR_MENU
echo [ОШИБКА] Неверный ввод.
pause
goto MENU

:MANUAL
cls
echo.
echo ==================================================
echo            РУЧНОЙ ВВОД ПАРОЛЯ
echo ==================================================
echo.
set /p "user_pass=Введите ваш пароль: "
echo.
echo Вы ввели: [ !user_pass! ]
pause
goto MENU

:GENERATOR_MENU
cls
echo.
echo ==================================================
echo            ГЕНЕРАТОР ПАРОЛЕЙ (ВЫБЕРИТЕ ДЛИНУ)
echo ==================================================
echo [1] Пароль из 5 символов
echo [2] Пароль из 8 символов
echo [3] Пароль из 10 символов
echo [4] Пароль из 16 символов
echo [5] Пароль из 24 символов
echo [6] Пароль из 64 символов
echo [0] Назад
echo ==================================================
set /p "len_choice=Выберите длину: "

if "%len_choice%"=="0" goto MENU
if "%len_choice%"=="1" set "LEN=5" & goto TYPE_MENU
if "%len_choice%"=="2" set "LEN=8" & goto TYPE_MENU
if "%len_choice%"=="3" set "LEN=10" & goto TYPE_MENU
if "%len_choice%"=="4" set "LEN=16" & goto TYPE_MENU
if "%len_choice%"=="5" set "LEN=24" & goto TYPE_MENU
if "%len_choice%"=="6" set "LEN=64" & goto TYPE_MENU
echo [ОШИБКА] Неверный ввод.
pause
goto GENERATOR_MENU

:TYPE_MENU
cls
echo.
echo ==================================================
echo            ТИП СИМВОЛОВ (ДЛИНА: !LEN!)
echo ==================================================
echo [1] Русские буквы + цифры
echo [2] Английские буквы + цифры
echo [3] Русские буквы + ЗАГЛАВНЫЕ Английские + цифры
echo [4] Английские буквы + ЗАГЛАВНЫЕ Русские + цифры
echo [0] Назад
echo ==================================================
set /p "type_choice=Выберите тип: "

if "%type_choice%"=="0" goto GENERATOR_MENU

:: Вызов PowerShell для генерации
if "%type_choice%"=="1" (
    powershell -Command "$chars = 'абвгдеёжзийклмнопрстуфхцчшщъыьэюя0123456789'; -join ((1..!LEN!) | ForEach-Object { $chars[(Get-Random -Maximum $chars.Length)] })"
)
if "%type_choice%"=="2" (
    powershell -Command "$chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'; -join ((1..!LEN!) | ForEach-Object { $chars[(Get-Random -Maximum $chars.Length)] })"
)
if "%type_choice%"=="3" (
    powershell -Command "$chars = 'абвгдеёжзийклмнопрстуфхцчшщъыьэюяABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'; -join ((1..!LEN!) | ForEach-Object { $chars[(Get-Random -Maximum $chars.Length)] })"
)
if "%type_choice%"=="4" (
    powershell -Command "$chars = 'abcdefghijklmnopqrstuvwxyzАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ0123456789'; -join ((1..!LEN!) | ForEach-Object { $chars[(Get-Random -Maximum $chars.Length)] })"
)

echo.
echo (Скопируйте пароль выше и сохраните!)
pause
goto GENERATOR_MENU