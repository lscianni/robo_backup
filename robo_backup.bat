@ECHO OFF
::    
:: ----------------------------------------------------------------------------
::Copyright (c) 2019, Louis Scianni
::All rights reserved.
::
:: Redistribution and use in source and binary forms, with or without
:: modification, are permitted provided that the following conditions are met:
::
:: 1. Redistributions of source code must retain the above copyright notice, 
::    this list of conditions and the following disclaimer.
:: 2. Redistributions in binary form must reproduce the above copyright notice,
::    this list of conditions and the following disclaimer in the documentation
::    and/or other materials provided with the distribution.
::
::THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
::AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
::IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
::AREDISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABL
::FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL 
::DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR 
::SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER 
::CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT 
::LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT
::OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH 
::DAMAGE.
::
::The views and conclusions contained in the software and documentation are 
::those of the authors and should not be interpreted as representing official 
::policies, either expressed or implied, of the robo_backup project. 
:: ---------------------------------------------------------------------------
::Backups up %Source% to %Destination% with logging and verbose output::
::12/13/2017::

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
