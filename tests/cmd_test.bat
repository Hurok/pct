rem Tests extractheaders when invoked with the --input option.
rem Requires the environment variable %CONFIGURATION% to be set

@echo off

del readmeexample_test\pct_test\stdafx.h 2>NUL
..\extractheaderscmd\%CONFIGURATION%\extractheaders --input readmeexample_test\pct_test\file.cpp --def "WIN32;WIN32;_M_X64" --sysinclude "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\include" --sysinclude "C:\Qt\5.6\msvc2015_64\include" -o readmeexample_test\pct_test\stdafx.h

IF %errorlevel% neq 0 (
   echo extractheaders failed with error code: %errorlevel% 
   exit /B %errorlevel%  
)

echo Comparing output with reference...
diffutils\bin\diff readmeexample_test\pct_test\stdafx.h readmeexample_test\pct_test\expected.h
echo.

IF %errorlevel% equ 0 (
   echo No differences found.
   exit /B 0
) ELSE (
   echo Differences found, diff returned: %errorlevel%
   exit /B %errorlevel%   
)
