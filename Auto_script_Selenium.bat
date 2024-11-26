@echo off
REM Set the directory where the project will be cloned
set "project_dir=%cd%\WEare-Automation-Framework"

REM Remove existing project directory if it exists
if exist "%project_dir%" (
    echo Removing existing project directory...
    rmdir /S /Q "%project_dir%"
)

REM Clone the GitHub repository
echo Cloning the repository...
git clone https://github.com/Alpha-QA-61-Team-2/WEare-Automation-Framework.git

REM Navigate to the project directory
if exist "%project_dir%" (
    cd /D "%project_dir%"
) else (
    echo Project directory does not exist. Clone may have failed.
    exit /b 1
)

REM Verify Maven is available
echo Verifying Maven installation...
mvn -version
if errorlevel 1 (
    echo Maven is not installed or not added to PATH. Please check your setup.
    exit /b 1
)

REM Run the Maven tests
echo Running tests with Maven...
mvn test
