@ECHO OFF

::Backups up %Source% to %Destination% with logging and verbose output::
::Louis Scianni 12/13/2017::

SET Source=%1
SET Destination=%2
SET Backup_Date="%DATE:~-4%"
SET Log_Dir="C:\_backups\log"
SET Log_File="%Log_Dir%\robo_backup%Backup_Date%.txt"

:main
::Copy over the network to the server with verbose output and logging::

IF NOT EXIST %Log_Dir% echo Creating Log Directory && mkdir %Log_Dir%

IF /I %Source% == "m" goto menu
IF %Source% == "?" goto info
IF /I %Source% == "help" goto info
ELSE (
    robocopy  %Source% %Destination% /V /E /LOG+:%Log_File% /MOVE /TEE
    goto eof
)

:menu
cls
echo ROBOBACKUP: Enter Source 
echo.
set /i /p sel_src=Source: 
cls
echo ROBOBACKUP: Enter Destination
echo.
set /p sel_dest=Destination:

if /I %sel_src% == "exit" goto eof
if /I %sel_src% == "quit" goto eof
ELSE (
    robocopy %sel_src% %sel_dest%  /V /E /LOG+:%Log_File% /MOVE /TEE
)

goto menu 

:info
echo Backup file to another location
echo robo_backup [m ] [source destination]


:eof