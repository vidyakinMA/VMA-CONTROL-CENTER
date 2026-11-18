@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion
title ПИНГ-ТЕСТЕР ОТ ВИДЯКИНА М.А.
color 07
cls

echo.
echo ==================================================
echo            ПИНГ-ТЕСТЕР СЕТИ
echo            ОТ ВИДЯКИНА М.А.
echo ==================================================
echo.

set "total_ping=0"
set "count=0"

echo [1] ПРОВЕРКА РОУТЕРА (192.168.1.1)...
for /f "tokens=5" %%a in ('ping 192.168.1.1 -n 2 ^| findstr "TTL"') do (
    set "ping_val=%%a"
    set "ping_val=!ping_val:ms=!"
    set "ping_val=!ping_val:=!"
    echo    Пинг: !ping_val! мс
    set /a total_ping+=!ping_val!
    set /a count+=1
)
echo.

echo [2] ПРОВЕРКА GOOGLE (google.com)...
for /f "tokens=5" %%a in ('ping google.com -n 2 ^| findstr "TTL"') do (
    set "ping_val=%%a"
    set "ping_val=!ping_val:ms=!"
    set "ping_val=!ping_val:=!"
    echo    Пинг: !ping_val! мс
    set /a total_ping+=!ping_val!
    set /a count+=1
)
echo.

echo [3] ПРОВЕРКА YOUTUBE (youtube.com)...
for /f "tokens=5" %%a in ('ping youtube.com -n 2 ^| findstr "TTL"') do (
    set "ping_val=%%a"
    set "ping_val=!ping_val:ms=!"
    set "ping_val=!ping_val:=!"
    echo    Пинг: !ping_val! мс
    set /a total_ping+=!ping_val!
    set /a count+=1
)
echo.

echo [4] ПРОВЕРКА DISCORD (discord.com)...
for /f "tokens=5" %%a in ('ping discord.com -n 2 ^| findstr "TTL"') do (
    set "ping_val=%%a"
    set "ping_val=!ping_val:ms=!"
    set "ping_val=!ping_val:=!"
    echo    Пинг: !ping_val! мс
    set /a total_ping+=!ping_val!
    set /a count+=1
)
echo.

echo [5] ПРОВЕРКА YANDEX (yandex.ru)...
for /f "tokens=5" %%a in ('ping yandex.ru -n 2 ^| findstr "TTL"') do (
    set "ping_val=%%a"
    set "ping_val=!ping_val:ms=!"
    set "ping_val=!ping_val:=!"
    echo    Пинг: !ping_val! мс
    set /a total_ping+=!ping_val!
    set /a count+=1
)
echo.

if %count% gtr 0 (
    set /a avg_ping=total_ping/count
) else (
    set /a avg_ping=999
)

set /a quality=100 - (avg_ping * 100 / 200)
if !quality! lss 0 set /a quality=0
if !quality! gtr 100 set /a quality=100

echo ==================================================
echo            ОБЩИЙ ВЕРДИКТ
echo            ОТ ВИДЯКИНА М.А.
echo ==================================================
echo Средний пинг: !avg_ping! мс

:: --- ВЫВОД ПРОЦЕНТА ---
echo|set /p="Качество интернета: "
:: Меняем цвет только для процента
if !quality! geq 70 color 0A
if !quality! geq 50 if !quality! lss 70 color 0E
if !quality! lss 50 color 0C
:: Выводим процент
echo|set /p="!quality!%%"
:: СРАЗУ возвращаем белый цвет, чтобы остальной текст был белым
color 07
echo.

echo.
if !avg_ping! lss 30 (
    echo [АХУЕНЫЙ ИНТЕРНЕТ] Ты можешь летать в играх!
) else if !avg_ping! lss 80 (
    echo [НАИЛУЧШИЙ ИНТЕРНЕТ] Отличный пинг, играть одно удовольствие!
) else if !avg_ping! lss 150 (
    echo [НОРМ ИНТЕРНЕТ] Можно играть, но иногда будут лаги.
) else (
    echo [ХУЙНЯ ИНТЕРНЕТ] Пинг высокий, готовься к лагам и телепортам!
)

echo.
echo ==================================================
echo            ТЕСТ ЗАВЕРШЕН
echo ==================================================
echo.
echo [ЛЕГЕНДА ЦВЕТОВ]
echo.
echo [ЗЕЛЕНЫЙ]  - Отличное качество (70-100%%) - Идеально для игр и видео.
echo [ЖЕЛТЫЙ]   - Нормальное качество (50-69%%) - Бывают лаги, но играть можно.
echo [КРАСНЫЙ]  - Плохое качество (0-49%%) - Тормоза, высокий пинг, лаги.
echo.
pause