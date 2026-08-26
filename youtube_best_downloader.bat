@echo off
title YouTube Video & Audio Downloader
color 0A
setlocal enabledelayedexpansion

REM ==========================================================
REM   YouTube Downloader (Video or Audio)
REM   Requires yt-dlp.exe and ffmpeg.exe
REM   Place both in the same folder as this .bat file.
REM ==========================================================

REM ----- Check yt-dlp -----
if exist "%~dp0yt-dlp.exe" (
    set "YTDLP=%~dp0yt-dlp.exe"
) else (
    where yt-dlp >nul 2>&1
    if errorlevel 1 (
        echo [ERROR] yt-dlp not found!
        echo Download from: https://github.com/yt-dlp/yt-dlp/releases/latest
        echo Place yt-dlp.exe in the same folder as this .bat.
        pause
        exit /b
    ) else (
        set "YTDLP=yt-dlp"
    )
)

REM ----- Check ffmpeg -----
if exist "%~dp0ffmpeg.exe" (
    set "FFMPEG=%~dp0ffmpeg.exe"
) else (
    where ffmpeg >nul 2>&1
    if errorlevel 1 (
        echo [ERROR] ffmpeg not found!
        echo Download from: https://github.com/BtbN/FFmpeg-Builds/releases
        echo Place ffmpeg.exe in the same folder as this .bat.
        pause
        exit /b
    ) else (
        set "FFMPEG=ffmpeg"
    )
)

REM ----- Output Folder -----
set "OUTDIR=%~dp0Downloads"
if not exist "%OUTDIR%" mkdir "%OUTDIR%"

:menu
cls
echo ==========================================================
echo 🔹 YOUTUBE DOWNLOADER
echo ==========================================================
echo.
echo [1] 🎬 Download Video (MP4 - Best Quality)
echo [2] 🎵 Download Audio Only (MP3 - Best Quality)
echo [3] ❌ Exit
echo.
set /p CHOICE=👉 Enter your choice (1/2/3): 

if "%CHOICE%"=="1" goto video
if "%CHOICE%"=="2" goto audio
if "%CHOICE%"=="3" goto exit
goto menu

:video
cls
echo ==========================================================
echo 🎬 BEST QUALITY VIDEO DOWNLOAD
echo ==========================================================
echo.
set /p URL=👉 Paste YouTube video link: 
if "%URL%"=="" (
    echo ❌ No URL entered.
    pause
    goto menu
)

echo.
echo 🚀 Downloading BEST video + audio...
echo.

"%YTDLP%" -f "bv*+ba/b" --merge-output-format mp4 ^
--embed-thumbnail --add-metadata ^
-o "%OUTDIR%\%%(title)s.%%(ext)s" "%URL%"

if errorlevel 1 (
    echo ❌ Download failed!
) else (
    echo ✅ Video download complete!
    echo 📁 Saved to: %OUTDIR%
)
pause
goto menu

:audio
cls
echo ==========================================================
echo 🎵 BEST QUALITY AUDIO DOWNLOAD (MP3)
echo ==========================================================
echo.
set /p URL=👉 Paste YouTube video link: 
if "%URL%"=="" (
    echo ❌ No URL entered.
    pause
    goto menu
)

echo.
echo 🚀 Downloading and converting to MP3...
echo.

"%YTDLP%" -f bestaudio --extract-audio --audio-format mp3 --audio-quality 0 ^
--embed-thumbnail --add-metadata ^
-o "%OUTDIR%\%%(title)s.%%(ext)s" "%URL%"

if errorlevel 1 (
    echo ❌ Download failed!
) else (
    echo ✅ Audio download complete!
    echo 📁 Saved to: %OUTDIR%
)
pause
goto menu

:exit
echo.
echo 👋 Exiting YouTube Downloader...
timeout /t 2 >nul
exit /b


	