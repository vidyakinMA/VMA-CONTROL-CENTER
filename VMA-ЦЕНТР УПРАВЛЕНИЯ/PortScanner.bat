@echo off
chcp 65001 >nul
title СКАНЕР УГРОЗ ОТ ВИДЯКИНА М.А.

echo.
echo ==================================================
echo            СКАНЕР СЕТЕВЫХ ПОРТОВ
echo            ОТ ВИДЯКИНА М.А.
echo ==================================================
echo.

:: Вызов PowerShell
powershell -ExecutionPolicy Bypass -NoProfile -Command "$Host.UI.RawUI.BackgroundColor = 'Black'; $Host.UI.RawUI.ForegroundColor = 'White'; Clear-Host; Write-Host 'Анализ сетевых подключений...' -ForegroundColor White; $data = netstat -an | Select-String 'ESTABLISHED'; foreach ($line in $data) { $str = $line.ToString(); $parts = $str -split '\s+'; $local = $parts[2]; $remote = $parts[3]; if ($remote -match '127\.0\.0\.1|192\.168\.|10\.') { Write-Host ('[ЛОКАЛ]     ' + $local + ' -> ' + $remote) -ForegroundColor White; } elseif ($remote -match '87\.240\.|5\.101\.|91\.108\.|149\.154\.|162\.254\.|142\.250\.|77\.88\.|87\.250\.|104\.16\.|185\.199\.|31\.13\.|34\.117\.|52\.') { Write-Host ('[БЕЗОПАСНО] ' + $local + ' -> ' + $remote) -ForegroundColor White; } elseif ($remote -match '162\.243\.103\.246|178\.62\.3\.223|27\.133\.154\.218|34\.204\.119\.63|50\.16\.16\.211|45\.74\.7\.193|185\.212\.131\.27|185\.212\.128\.124') { Write-Host ('[ПИЗДА!]    ' + $local + ' -> ' + $remote) -ForegroundColor Red; } else { Write-Host ('[ПОДОЗРИТЕЛЬНО] ' + $local + ' -> ' + $remote) -ForegroundColor Yellow; } }"

echo.
echo ==================================================
echo            СКАНИРОВАНИЕ ЗАВЕРШЕНО
echo            ОТ ВИДЯКИНА М.А.
echo ==================================================
echo.
echo [БЕЛЫЙ]  - Локальные или известные сервисы (ВК, Телега, Дискорд, Гугл, Стим)
echo [ЖЕЛТЫЙ] - Неизвестный сервер (может быть игрой или вирусом)
echo [КРАСНЫЙ] - Реально опасный IP из базы ботнетов
echo.
pause