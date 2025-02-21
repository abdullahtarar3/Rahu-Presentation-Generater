@echo off
color 0A
echo ============================================
echo          RAHU SCRIPT EXECUTION
echo ============================================
echo Developed by Abdullah Tarar
echo.

:: Step 1: Check if Git is installed
echo [Step 1] Checking if Git is installed...
where git >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] Git is not installed.
    echo [INFO] Opening Git download page...
    start https://git-scm.com/downloads
    echo [INFO] Please install Git and then run this script again.
    pause
    exit /b
) else (
    echo [SUCCESS] Git is installed.
)
echo.

:: Step 2: Check if Python is installed
echo [Step 2] Checking if Python is installed...
where python >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] Python is not installed.
    echo [INFO] Opening Python download page...
    start https://www.python.org/downloads/
    echo [INFO] Please install Python and then run this script again.
    pause
    exit /b
) else (
    echo [SUCCESS] Python is installed.
)
echo.

:: Step 3: Change directory to C:\ and create a folder named "Rahu"
echo [Step 3] Creating folder "Rahu" in C:\...
cd C:\
if not exist "Rahu" (
    mkdir Rahu
    echo [SUCCESS] Folder "Rahu" created successfully.
) else (
    echo [INFO] Folder "Rahu" already exists.
)
echo.

:: Step 4: Clone the GitHub repository into the Rahu folder
echo [Step 4] Cloning the GitHub repository into the Rahu folder...
cd C:\Rahu
set "repo_url=https://github.com/abdullahtarar3/Rahu-Presentation-Generater.git"
set "repo_name=Rahu-Presentation-Generater"

if not exist "%repo_name%" (
    echo [INFO] Cloning repository from %repo_url%...
    git clone %repo_url% %repo_name%
    if %errorlevel% equ 0 (
        echo [SUCCESS] Repository cloned successfully.
    ) else (
        echo [ERROR] Failed to clone the repository.
        pause
        exit /b
    )
) else (
    echo [INFO] Repository "%repo_name%" already exists. Skipping clone.
)
echo.

:: Step 5: Navigate to the repository directory and install requirements
echo [Step 5] Installing required libraries from requirements.txt...
cd C:\Rahu\%repo_name%
if exist "requirements.txt" (
    echo [INFO] Checking if required libraries are already installed...
    pip install -r requirements.txt >nul 2>nul
    if %errorlevel% equ 0 (
        echo [SUCCESS] Required libraries are already installed.
    ) else (
        echo [INFO] Installing required libraries...
        pip install -r requirements.txt
        if %errorlevel% equ 0 (
            echo [SUCCESS] Required libraries installed successfully.
        ) else (
            echo [ERROR] Failed to install required libraries.
            pause
            exit /b
        )
    )
) else (
    echo [INFO] "requirements.txt" not found. Skipping installation.
)
echo.

:: Step 6: Execute the final command "python Rahu.py"
echo [Step 6] Executing the final command "python Rahu.py"...
if exist "Rahu.py" (
    python Rahu.py
    if %errorlevel% equ 0 (
        echo [SUCCESS] "Rahu.py" executed successfully.
        echo.
        echo ============================================
        echo Script executed successfully.
        echo Developed by Abdullah Tarar
        echo ============================================
        timeout /t 2 >nul
        exit /b 0
    ) else (
        echo [ERROR] Failed to execute "Rahu.py".
        pause
        exit /b
    )
) else (
    echo [ERROR] "Rahu.py" not found. Exiting script.
    pause
    exit /b
)