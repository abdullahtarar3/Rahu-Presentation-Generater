@echo off
:: Step 1: Check if Git is installed
echo Step 1: Checking if Git is installed...
where git >nul 2>nul
if %errorlevel% neq 0 (
    echo Git is not installed.
    echo Opening Git download page...
    start https://git-scm.com/downloads
    echo Please install Git and then run this script again.
    pause
    exit /b
) else (
    echo Git is installed.
)

:: Step 2: Change directory to C:\ and create a folder named "Rahu"
echo Step 2: Changing directory to C:\ and creating folder "Rahu"...
cd C:\
if not exist "Rahu" (
    mkdir Rahu
    echo Folder "Rahu" created successfully.
) else (
    echo Folder "Rahu" already exists.
)

:: Step 3: Clone the GitHub repository into the Rahu folder
echo Step 3: Cloning the GitHub repository into the Rahu folder...
cd C:\Rahu
set "repo_url=https://github.com/abdullahtarar3/Rahu-Presentation-Generater.git"
set "repo_name=Rahu-Presentation-Generater"

if not exist "%repo_name%" (
    echo Cloning repository from %repo_url%...
    git clone %repo_url% %repo_name%
    if %errorlevel% equ 0 (
        echo Repository cloned successfully.
    ) else (
        echo Failed to clone the repository.
        pause
        exit /b
    )
) else (
    echo Repository "%repo_name%" already exists. Skipping clone.
)

:: Step 4: Navigate to the repository directory and install requirements
echo Step 4: Installing required libraries from requirements.txt...
cd C:\Rahu\%repo_name%
if exist "requirements.txt" (
    echo Checking if required libraries are already installed...
    pip install -r requirements.txt >nul 2>nul
    if %errorlevel% equ 0 (
        echo Required libraries are already installed.
    ) else (
        echo Installing required libraries...
        pip install -r requirements.txt
        if %errorlevel% equ 0 (
            echo Required libraries installed successfully.
        ) else (
            echo Failed to install required libraries.
            pause
            exit /b
        )
    )
) else (
    echo "requirements.txt" not found. Skipping installation.
)

:: Step 5: Execute the final command "python Rahu.py"
echo Step 5: Executing the final command "python Rahu.py"...
if exist "Rahu.py" (
    python Rahu.py
    if %errorlevel% equ 0 (
        echo "Rahu.py" executed successfully.
        exit /b 0
    ) else (
        echo Failed to execute "Rahu.py".
        pause
        exit /b
    )
) else (
    echo "Rahu.py" not found. Exiting script.
    pause
    exit /b
)