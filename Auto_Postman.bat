@echo off

:: Set Testmo API token
set TESTMO_TOKEN=testmo_api_eyJpdiI6InFST3paYWdZNHBadjB4cldwc2JDbWc9PSIsInZhbHVlIjoibk9NY29YbkRnVTFMUVNiSkgvQUt2QlZodjAwN01qakpXckErZlljVnlWOD0iLCJtYWMiOiI3NWE4ZDgwNjhkYmMwOWMyMDQ2OGI5MmY3NGFmM2M4MTk4YzJlNzQ5YWQyYzdjNTc0YTcxMGJjOTEwM2QzMjlhIiwidGFnIjoiIn0=

:: Ensure results directory exists
if not exist "results" mkdir results

:: Run Newman collection
echo Running Newman tests...
cmd /c newman run "WEare Tests.postman_collection.json" ^
  -r cli,junit ^
  --reporter-junit-export results/test-results.xml ^
  -e "WEare.postman_environment.json" ^
  --disable-unicode || (
    echo Newman tests failed, but continuing to submit results...
)

echo Finished running Newman tests. Checking for results...

:: Check if results were generated
if not exist "results/test-results.xml" (
    echo Error: Results file not found. Skipping Testmo submission.
    exit /b 1
)

echo Results file found. Proceeding with Testmo submission...

:: Submit results to Testmo
testmo automation:run:submit ^
  --instance https://alpha-61.testmo.net ^
  --project-id 1 ^
  --name "Postman test run" ^
  --source "api" ^
  --results results/test-results.xml > testmo_submit.log 2>&1

:: Check if Testmo submission was successful
if %ERRORLEVEL% neq 0 (
    echo Error: Testmo submission failed. Check testmo_submit.log for details.
    exit /b 1
)

echo Testmo submission completed successfully.
