@echo off
setlocal enabledelayedexpansion

REM --- Get current date and time (yyyy-mm-dd hh:mm:ss) ---
for /f "tokens=1-3 delims=/.- " %%a in ("%date%") do (
    set d1=%%a
    set d2=%%b
    set d3=%%c
)

REM Windows has weird date formats depending on locale, fix it:
REM Detect which part is year:
if %d1% GTR 31 (
    set year=%d1%
    set month=%d2%
    set day=%d3%
) else if %d3% GTR 31 (
    set year=%d3%
    set month=%d1%
    set day=%d2%
) else (
    REM fallback
    set year=%d3%
    set month=%d1%
    set day=%d2%
)

set hour=%time:~0,2%
set minute=%time:~3,2%
set second=%time:~6,2%

REM remove leading space in hour (Windows does " 9:03")
if "%hour:~0,1%"==" " set hour=0%hour:~1,1%

set timestamp=%year%-%month%-%day%_%hour%-%minute%-%second%

echo Commit message timestamp: %timestamp%

REM --- Git commands ---
git add .
git commit -m "Auto commit %timestamp%"
git push

pause

endlocal
