@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion
title УМНЫЙ СОРТИРОВЩИК ФАЙЛОВ ОТ ВИДЯКИНА М.А.
color 07
cls

:MENU
cls
echo.
echo ==================================================
echo            УМНЫЙ СОРТИРОВЩИК ФАЙЛОВ
echo            ОТ ВИДЯКИНА М.А.
echo ==================================================
echo.
echo [1] Сортировать папку "Загрузки" (Downloads)
echo [2] Сортировать "Рабочий стол" (Desktop)
echo [3] Указать свой путь к папке
echo [4] ПРОБНЫЙ РЕЖИМ (Показать, что будет сделано, без перемещения)
echo [0] Выход
echo ==================================================
set /p "choice=Выберите действие: "

if "%choice%"=="0" exit
if "%choice%"=="1" set "TARGET=%USERPROFILE%\Downloads" & set "DRY_RUN=0" & goto SORT
if "%choice%"=="2" set "TARGET=%USERPROFILE%\Desktop" & set "DRY_RUN=0" & goto SORT
if "%choice%"=="3" goto ASK_PATH
if "%choice%"=="4" goto ASK_PATH_DRY
echo [ОШИБКА] Неверный ввод.
pause
goto MENU

:ASK_PATH
cls
echo.
echo ==================================================
echo            УКАЗАТЬ ПУТЬ
echo ==================================================
echo Пример: C:\Users\MAKAR\Documents
echo.
set /p "TARGET=Введите полный путь к папке: "
if not exist "%TARGET%" (
    echo [ОШИБКА] Папка "%TARGET%" не найдена!
    pause
    goto MENU
)
set "DRY_RUN=0"
goto SORT

:ASK_PATH_DRY
cls
echo.
echo ==================================================
echo            ПРОБНЫЙ РЕЖИМ (БЕЗ ПЕРЕМЕЩЕНИЯ)
echo ==================================================
echo Пример: C:\Users\MAKAR\Documents
echo.
set /p "TARGET=Введите полный путь к папке: "
if not exist "%TARGET%" (
    echo [ОШИБКА] Папка "%TARGET%" не найдена!
    pause
    goto MENU
)
set "DRY_RUN=1"
goto SORT

:SORT
cls
echo.
echo ==================================================
echo            НАЧАЛО СОРТИРОВКИ
echo ==================================================
echo Папка: %TARGET%
if "%DRY_RUN%"=="1" (
    echo Режим: ПРОБНЫЙ (файлы не будут перемещены)
) else (
    echo Режим: РЕАЛЬНАЯ СОРТИРОВКА
)
echo.

:: Создаем папки, если их нет (только если не Dry Run)
if "%DRY_RUN%"=="0" (
    if not exist "%TARGET%\Фотки" mkdir "%TARGET%\Фотки"
    if not exist "%TARGET%\Документы" mkdir "%TARGET%\Документы"
    if not exist "%TARGET%\Музыка" mkdir "%TARGET%\Музыка"
    if not exist "%TARGET%\Видео" mkdir "%TARGET%\Видео"
    if not exist "%TARGET%\Архивы" mkdir "%TARGET%\Архивы"
    if not exist "%TARGET%\Установщики" mkdir "%TARGET%\Установщики"
    if not exist "%TARGET%\Другое" mkdir "%TARGET%\Другое"
)

:: Счетчики для отчета
set "count_img=0"
set "count_doc=0"
set "count_mus=0"
set "count_vid=0"
set "count_arc=0"
set "count_exe=0"
set "count_oth=0"

:: Цикл по всем файлам в папке (без подпапок)
for %%f in ("%TARGET%\*.*") do (
    set "ext=%%~xf"
    set "ext=!ext:~1!"
    set "filename=%%~nxf"
    set "moved=0"

    :: Проверка на картинки
    if /I "!ext!"=="jpg" set "moved=1" & set "dest=Фотки" & set /a count_img+=1
    if /I "!ext!"=="jpeg" set "moved=1" & set "dest=Фотки" & set /a count_img+=1
    if /I "!ext!"=="png" set "moved=1" & set "dest=Фотки" & set /a count_img+=1
    if /I "!ext!"=="gif" set "moved=1" & set "dest=Фотки" & set /a count_img+=1
    if /I "!ext!"=="bmp" set "moved=1" & set "dest=Фотки" & set /a count_img+=1

    :: Проверка на документы
    if /I "!ext!"=="doc" set "moved=1" & set "dest=Документы" & set /a count_doc+=1
    if /I "!ext!"=="docx" set "moved=1" & set "dest=Документы" & set /a count_doc+=1
    if /I "!ext!"=="pdf" set "moved=1" & set "dest=Документы" & set /a count_doc+=1
    if /I "!ext!"=="txt" set "moved=1" & set "dest=Документы" & set /a count_doc+=1
    if /I "!ext!"=="xls" set "moved=1" & set "dest=Документы" & set /a count_doc+=1
    if /I "!ext!"=="xlsx" set "moved=1" & set "dest=Документы" & set /a count_doc+=1

    :: Проверка на музыку
    if /I "!ext!"=="mp3" set "moved=1" & set "dest=Музыка" & set /a count_mus+=1
    if /I "!ext!"=="wav" set "moved=1" & set "dest=Музыка" & set /a count_mus+=1
    if /I "!ext!"=="flac" set "moved=1" & set "dest=Музыка" & set /a count_mus+=1

    :: Проверка на видео
    if /I "!ext!"=="mp4" set "moved=1" & set "dest=Видео" & set /a count_vid+=1
    if /I "!ext!"=="avi" set "moved=1" & set "dest=Видео" & set /a count_vid+=1
    if /I "!ext!"=="mkv" set "moved=1" & set "dest=Видео" & set /a count_vid+=1

    :: Проверка на архивы
    if /I "!ext!"=="zip" set "moved=1" & set "dest=Архивы" & set /a count_arc+=1
    if /I "!ext!"=="rar" set "moved=1" & set "dest=Архивы" & set /a count_arc+=1
    if /I "!ext!"=="7z" set "moved=1" & set "dest=Архивы" & set /a count_arc+=1

    :: Проверка на установщики
    if /I "!ext!"=="exe" set "moved=1" & set "dest=Установщики" & set /a count_exe+=1
    if /I "!ext!"=="msi" set "moved=1" & set "dest=Установщики" & set /a count_exe+=1

    :: Если не подошло ни к чему - в "Другое"
    if "!moved!"=="0" (
        set "dest=Другое"
        set /a count_oth+=1
    )

    :: Перемещение (или вывод для Dry Run)
    if "%DRY_RUN%"=="1" (
        echo [ПРОБНЫЙ] Файл "!filename!" -> Папка "!dest!"
    ) else (
        if not exist "%TARGET%\!dest!" mkdir "%TARGET%\!dest!"
        move "%%f" "%TARGET%\!dest!\" >nul
    )
)

echo.
echo ==================================================
echo            СОРТИРОВКА ЗАВЕРШЕНА
echo ==================================================
if "%DRY_RUN%"=="1" (
    echo (Это был пробный режим. Файлы НЕ перемещены.)
) else (
    echo Файлы успешно разложены по папкам!
)
echo.
echo ОТЧЕТ:
echo Картинки: !count_img!
echo Документы: !count_doc!
echo Музыка: !count_mus!
echo Видео: !count_vid!
echo Архивы: !count_arc!
echo Установщики: !count_exe!
echo Другое: !count_oth!
echo.
pause
goto MENU