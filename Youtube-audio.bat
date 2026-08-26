@echo off
echo Paste the YouTube link:
set /p URL=

yt-dlp -f bestaudio --extract-audio --audio-format mp3 -o "%USERPROFILE%\Music\%%(title)s.%%(ext)s" %URL%

echo.
echo ✅ Audio extracted!
echo Saved in Music folder.
pause
