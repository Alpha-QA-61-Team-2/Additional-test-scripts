@echo off

REM Set Testmo token
set TESTMO_TOKEN=testmo_api_eyJpdiI6InFST3paYWdZNHBadjB4cldwc2JDbWc9PSIsInZhbHVlIjoibk9NY29YbkRnVTFMUVNiSkgvQUt2QlZodjAwN01qakpXckErZlljVnlWOD0iLCJtYWMiOiI3NWE4ZDgwNjhkYmMwOWMyMDQ2OGI5MmY3NGFmM2M4MTk4YzJlNzQ5YWQyYzdjNTc0YTcxMGJjOTEwM2QzMjlhIiwidGFnIjoiIn0=

REM Submit test results to Testmo
echo Submitting test results to Testmo...
testmo automation:run:submit --instance https://alpha-61.testmo.net --project-id 1 --name "Automation run" --source "Selenium" --results "WEare-Automation-Framework/target/surefire-reports/*.xml"

REM Notify completion
echo Tests executed and results submitted to Testmo.
pause
