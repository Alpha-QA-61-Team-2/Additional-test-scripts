
# Workflow Execution Guide

## Introduction

This guide provides step-by-step instructions to set up the necessary tools and execute the workflow for the specified directory. It covers running Postman collections with Newman, performing pre-run setup, and submitting results to Testmo.

---

## 1. Prerequisites

Before starting, ensure the following prerequisites are met:

- **Operating System**: Windows  
- **Tools**:
  - Node.js and npm installed (required for Newman and Testmo CLI)
  - Postman installed (optional, but useful for debugging)  
- **Installations**:
  - Newman
  - Testmo CLI  

**Download all files into a local folder.**

---

## 2. Installation Steps

### 2.1 Install Node.js

1. Download Node.js from the official website: [https://nodejs.org/](https://nodejs.org/).  
2. Install Node.js, ensuring you check the option to add it to your system's PATH.  
3. Verify the installation by running the following commands in the terminal:

   ```bash
   node -v
   npm -v
   ```

### 2.2 Install Newman

Install Newman globally by running:

```bash
npm install -g newman
```

Verify the installation:

```bash
newman -v
```

### 2.3 Install Testmo CLI

Install the Testmo CLI using npm:

```bash
npm install -g testmo-cli
```

Verify the installation:

```bash
testmo -h
```

---

## 3. Workflow Execution Steps

### 3.1 Prepare Postman Collections

Ensure the required Postman collection and environment files are present in the directory:

- **Pre-run.postman_collection.json**: Used for pre-run setup tasks.  
- **WEare Tests.postman_collection.json**: Contains the main test cases.  
- **WEare.postman_environment.json**: Defines environment variables for the tests.  

---

### 3.2 Run the Pre-run Collection

The pre-run collection sets up necessary data or configurations for your tests. Run it using the `pre-run_colection_script.bat` file.

**Steps**:  

1. Open Command Prompt.  
2. Navigate to the directory:  

   ```bash
   cd <path_to_directory>
   ```

3. Execute the batch file:  

   ```bash
   pre-run_colection_script.bat
   ```

---

### 3.3 Execute the Main Workflow

Run the `Auto_Postman.bat` script to execute the main tests and submit results to Testmo.

**Steps**:

1. Open Command Prompt.  
2. Navigate to the directory:  

   ```bash
   cd <path_to_directory>
   ```

3. Run the script:  

   ```bash
   Auto_Postman.bat
   ```

---

## 4. Expected Workflow

The workflow involves the following phases:

1. **Pre-run Phase**: Ensures all preconditions are met using `Pre-run.postman_collection.json`.  
2. **Main Test Phase**: Executes the primary Postman tests using `WEare Tests.postman_collection.json`.  
3. **Testmo Integration**: Submits test results (`results/test-results.xml`) to Testmo.  

---

## 5. Debugging Common Issues

### 5.1 Newman Errors

If Newman fails to execute the test cases, check the following:

- Ensure the collection and environment files are correct.  
- Verify internet connectivity for API calls.  
- Ensure permissions are configured correctly.  

### 5.2 Testmo Submission Issues

If Testmo submission fails:

- Ensure the `TESTMO_TOKEN` environment variable is set correctly.  
- Confirm the project ID and instance URL in the `Auto_Postman.bat` script.  

---

## 6. Example `Auto_Postman.bat` Script

Below is an example `Auto_Postman.bat` script for executing tests and submitting results to Testmo:

```batch
@echo off

:: Set Testmo API token
set TESTMO_TOKEN=your_testmo_api_token_here

:: Ensure results directory exists
if not exist "results" mkdir results

:: Run Newman collection
newman run "WEare Tests.postman_collection.json" ^
  -r cli,junit ^
  --reporter-junit-export results/test-results.xml ^
  -e "WEare.postman_environment.json" ^
  --disable-unicode || (
    echo Newman tests failed, but continuing to submit results...
)

:: Check if results were generated
if not exist "results/test-results.xml" (
    echo Error: Results file not found. Skipping Testmo submission.
    exit /b 1
)

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

:: Final message
echo Script completed successfully.
```

---

This guide provides a comprehensive workflow for executing tests with Postman, Newman, and Testmo, ensuring a seamless integration and troubleshooting process.
