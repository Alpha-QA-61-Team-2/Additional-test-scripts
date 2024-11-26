@echo off
REM Set the directory where the project will be cloned
set "project_dir=%cd%\WEare-Automation-Framework"

REM Clone the GitHub repository
if exist "%project_dir%" (
    echo Removing existing project directory...
    rmdir /S /Q "%project_dir%"
)
echo Cloning the repository...
git clone https://github.com/Alpha-QA-61-Team-2/WEare-Automation-Framework.git

REM Navigate to the project directory
cd "%project_dir%"

REM Run the Maven tests
echo Running tests with Maven...
mvn test