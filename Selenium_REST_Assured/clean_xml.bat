@echo off
set "reports_dir=target\surefire-reports"

echo Cleaning XML files in %reports_dir%...

for %%f in ("%reports_dir%\*.xml") do (
    echo Processing %%f...
    powershell -Command "(Get-Content %%f) -replace ' xmlns:xsi[^>]*', '' -replace ' xsi:noNamespaceSchemaLocation[^>]*', '' | Set-Content %%f"
)

echo Cleaning completed!
