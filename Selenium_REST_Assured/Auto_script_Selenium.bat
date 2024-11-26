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

REM Verify if the project directory was created
if not exist "%project_dir%" (
    echo Cloning failed. Project directory does not exist.
    exit /b 1
)

REM Navigate to the project directory
cd /D "%project_dir%"
if not "%cd%"=="%project_dir%" (
    echo Failed to navigate to project directory.
    exit /b 1
)


REM Check if pom.xml exists
if not exist "pom.xml" (
    echo pom.xml not found in project directory. Ensure the repository is cloned correctly.
    exit /b 1
)

REM Run the Maven tests
echo Running tests with Maven...
mvn test


echo Maven tests completed successfully.
