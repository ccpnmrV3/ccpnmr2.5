@echo off
setlocal
call "%~dp0\paths"

set ENTRYMODULE=%CCPNMR_TOP_DIR%\%VERSIONPATH%\python\ccp\format\spectra\params\XeasyData.py
"%ANACONDA3%"\python -i -O -W ignore "%ENTRYMODULE%" %*
endlocal
