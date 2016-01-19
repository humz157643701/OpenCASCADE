@echo off

rem Setup environment
call "%~dp0..\..\env.bat" %1 %2 %3

if NOT DEFINED DXSDK_DIR (
  if "%VCVER%" == "vc9" (
    echo ERROR: DirectX SDK is required in order to build the sample but it is not found in your system. Please install DirectX SDK and retry.
    exit /B
  )
  if "%VCVER%" == "vc10" (
    echo ERROR: DirectX SDK is required in order to build the sample but it is not found in your system. Please install DirectX SDK and retry.
    exit /B
  )
)

rem Define path to project file
set "PRJFILE=%~dp0\CSharp_D3D.sln"

set "VisualStudioExpressName=VCExpress"

if "%VCVER%" == "vc8" (
  set "DevEnvDir=%VS80COMNTOOLS%..\IDE"
) else if "%VCVER%" == "vc9" (
  set "DevEnvDir=%VS90COMNTOOLS%..\IDE"
) else if "%VCVER%" == "vc10" (
  set "DevEnvDir=%VS100COMNTOOLS%..\IDE"
) else if "%VCVER%" == "vc11" (
  set "DevEnvDir=%VS110COMNTOOLS%..\IDE"
  rem Visual Studio Express starting from VS 2012 is called "for Windows Desktop"
  rem and has a new name for executable - WDExpress
  set "VisualStudioExpressName=WDExpress"
) else if "%VCVER%" == "vc12" (
  set "DevEnvDir=%VS120COMNTOOLS%..\IDE"
  set "VisualStudioExpressName=WDExpress"
) else (
  echo Error: wrong VS identifier
  exit /B
)

rem Launch Visual Studio - either professional (devenv) or Express, as available
if exist "%DevEnvDir%\devenv.exe"  (
  start "%DevEnvDir%\devenv.exe" "%PRJFILE%"
) else if exist "%DevEnvDir%\%VisualStudioExpressName%.exe"  (
  start "%DevEnvDir%\%VisualStudioExpressName%.exe" "%PRJFILE%"
) else (
  echo Error: Could not find MS Visual Studio ^(%VCVER%^)
  echo Check relevant environment variable ^(e.g. VS80COMNTOOLS for vc8^)
)