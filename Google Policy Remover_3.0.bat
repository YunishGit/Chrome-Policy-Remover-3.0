:: Chrome Policy Remover for Windows
:: Version 3.0 - 29 March 2025
:: Created and Optimized by Yunish Chaulagain
:: Software & Security Enthusiast
:: https://productexperts.withgoogle.com

@echo off
color 0A
cls

:: Display Start Message
echo =======================================
echo        Chrome Policy Remover v3.0     
echo =======================================
echo Created with love by Yunish Chaulagain

:: Ensure Admin Privileges
net session >nul 2>&1 || (
    echo.
    echo ERROR: Please run this script as Administrator.
    echo Right-click and select "Run as administrator".
    echo.
    pause
    exit /b
)

echo.
echo Closing Google Chrome...
taskkill /F /IM chrome.exe /T > nul 2>nul

echo.
echo Removing Group Policy restrictions...
RD /S /Q "%WINDIR%\System32\GroupPolicy" 2>nul
RD /S /Q "%WINDIR%\System32\GroupPolicyUsers" 2>nul

echo.
echo Removing Google Policies...
RD /S /Q "%ProgramFiles(x86)%\Google\Policies" 2>nul
RD /S /Q "%ProgramFiles%\Google\Policies" 2>nul

echo.
echo Refreshing Group Policy...
gpupdate /force > nul

echo.
echo Removing Chrome-related Registry Policies...
(for %%K in (
    "HKEY_LOCAL_MACHINE\Software\Policies\Google\Chrome"
    "HKEY_LOCAL_MACHINE\Software\Policies\Google\Update"
    "HKEY_LOCAL_MACHINE\Software\Policies\Chromium"
    "HKEY_LOCAL_MACHINE\Software\Google\Chrome"
    "HKEY_LOCAL_MACHINE\Software\WOW6432Node\Google\Enrollment"
    "HKEY_CURRENT_USER\Software\Policies\Google\Chrome"
    "HKEY_CURRENT_USER\Software\Policies\Chromium"
    "HKEY_CURRENT_USER\Software\Google\Chrome"
) do (
    reg delete %%K /f >nul 2>nul
))

echo.
echo Removing Cloud Management Enrollment Token...
reg delete "HKEY_LOCAL_MACHINE\Software\WOW6432Node\Google\Update\ClientState\{430FD4D0-B729-4F61-AA34-91526481799D}" /v "CloudManagementEnrollmentToken" /f >nul 2>nul

echo.
echo ===============================================
echo  Chrome Policy Removal Completed Successfully!
echo ===============================================
echo.
echo  Thank you for using Chrome Policy Remover!
echo  Your system is now free from unwanted Chrome policies,
echo  ensuring a smoother and more secure browsing experience.
echo.
echo  If you found this tool useful, feel free to share it!
echo  Stay secure and in control of your device.
echo.
echo  Best regards,
echo  Yunish Chaulagain

echo.
echo Version 3.0 - 29 March 2025
echo.
echo.
powershell -c "(New-Object Media.SoundPlayer 'C:\Windows\Media\Windows Notify System Generic.wav').PlaySync()"
pause
exit
