# SonarQube Local Setup for Python Projects

**SonarQube** is an open-source platform for continuous code inspection, enabling automatic code reviews through static analysis. It helps detect bugs, code smells, and security vulnerabilities in code, ensuring high-quality software development.

This guide will help you set up a local **SonarQube server** and use **SonarScanner** to analyze a Python project’s code quality.

## Table of Contents

- [SonarQube Local Setup for Python Projects](#sonarqube-local-setup-for-python-projects)
  - [Table of Contents](#table-of-contents)
  - [1. Installation and Set up](#1-installation-and-set-up)
    - [Running SonarQube with Docker](#running-sonarqube-with-docker)
    - [Manual Installation](#manual-installation)
  - [2. Installing and Configuring SonarScanner CLI (for Python)](#2-installing-and-configuring-sonarscanner-cli-for-python)
    - [Installation steps:](#installation-steps)
  - [3. Running Code Analysis with SonarScanner](#3-running-code-analysis-with-sonarscanner)
  - [4. SonarQube Quality Gates and Rules](#4-sonarqube-quality-gates-and-rules)
  - [Sources](#sources)
  - [References](#references)

## 1. Installation and Set up

### Running SonarQube with Docker

Using **Docker** is the quickest way to get **SonarQube** running locally. Follow these steps:

1. **Install Docker**: Ensure Docker is installed on your system.
2. **Pull and run the SonarQube image**: Use the official SonarQube Community Edition image. For example:

   ```bash
   docker run -d --name sonarqube -p 9000:9000 sonarqube:latest
   ```

   This command runs SonarQube in detached mode (`-d`), naming the container "sonarqube", and binding port 9000 of the container to port 9000 on your host. After a minute or two, you can browse to http://localhost:9000 to access SonarQube. The default administrator login is **admin / admin** (you’ll be prompted to change the password on first login).

3. **Wait for SonarQube to start**: It may take a minute for the server to initialize. You can check logs with `docker logs -f sonarqube` if needed. Once the container is running, go to http://localhost:9000 and log in with **admin/admin**.

### Manual Installation

If you prefer not to use **Docker**, you can install SonarQube manually on your local machine:

1. **Install Java**: SonarQube requires Java 17 (or 21) to run.
2. **Download SonarQube**: Go to the official [SonarSource website](https://www.sonarsource.com/products/sonarqube/downloads/?s_campaign=SQ-EMEA-South-South-Brand&s_content=SonarQubeServer&s_term=sonarqube%20download&s_category=Paid&s_source=Paid%20Search&s_origin=Google&cq_src=google_ads&cq_cmp=21283128645&cq_con=164767820560&cq_term=sonarqube%20download&cq_med=&cq_plac=&cq_net=g&cq_pos=&cq_plt=gp&gad_source=1&gad_campaignid=21283128645&gclid=CjwKCAjwravBBhBjEiwAIr30VLqphilBIxzbNk76qu3bdIzezyeWjGG3IIMudRo_AabDMqThd1QzZRoCXHcQAvD_BwE) and download the latest SonarQube Community Edition distribution (a ZIP file) for your platform. Then unzip it to a desired install directory.
3. **Start the SonarQube server**: In the unzipped SonarQube directory (`SONARQUBE_HOME`), find the startup script for your OS and run it. For Linux for example, Run the script at `bin/linux-x86-64/sonar.sh start`:

   ```bash
   cd <SONARQUBE_HOME>/bin/linux-x86-64
   ./sonar.sh start
   ```

   After running the script, wait until you see logs indicating SonarQube has started and is listening on port 9000.

_____
At this point, whether you used *Docker* or *manual installation*, you should have a **SonarQube server** running locally on port **9000**.

## 2. Installing and Configuring SonarScanner CLI (for Python)

To analyze code with **SonarQube**, you need the **SonarScanner CLI** – *a command-line tool that sends your code to the SonarQube server for analysis*. The scanner is language-agnostic and will detect Python code using SonarQube’s Python analyzer.

### Installation steps:

1. **Download SonarScanner CLI**: Visit the official [SonarScanner download page](https://docs.sonarsource.com/sonarqube-server/latest/analyzing-source-code/scanners/sonarscanner/) and get the latest SonarScanner CLI ZIP for your operating system.
2. **Extract the archive**: Unzip the SonarScanner package to a directory of your choice, such as `~/sonar-scanner/`.
3. **Add to PATH (optional but recommended)**: For convenience, add the SonarScanner bin directory to your system PATH or to your `.bashrc` so that the sonar-scanner command is recognized globally:
   ```bash
   export PATH="$PATH:$HOME/sonar-scanner-<version>/bin"
   ```

## 3. Running Code Analysis with SonarScanner

With SonarQube running and the scanner installed, you can analyze your Python project. Below are the steps:

1. **Prepare a SonarQube project**: In the SonarQube web interface, create a new project (give it a name and a unique project key). For local analysis, you can do this manually in the **UI**:
   - Log in to SonarQube and click **“Create new project”** (or **“Projects” > “Create Project”**).
   - Provide a **Project Name** (e.g., **“My Python Project”**) and a **Project Key** (a unique identifier, e.g., `my-python-project`). The project key will be used by the scanner.
   - For analysis method, choose **“Locally”** when prompted (since we will run the scanner ourselves).
   - Generate a SonarQube **authentication token** for this project. In the UI, SonarQube will prompt you to generate a token (or you can generate one via **User > My Account > Security**). Copy this token – you’ll use it instead of a password for the scanner. _(If you skip the UI steps, you can also just use the default admin credentials, but using a token is recommended for security.)_
2. **Add a project configuration file**: In your Python project’s root directory, create a file named `sonar-project.properties`. This file defines project-specific settings for the scanner. Add the following basic properties to the file:

   ```properties
   sonar.projectKey=my-python-project       # use the project key you chose
   sonar.projectName=My Python Project      # an optional display name
   sonar.sources=.                          # scan all files in the current directory (and subfolders)
   sonar.exclusions=tests/**                # exclude the tests/ directory from analysis
   ```

   - The `sonar.projectKey` value **must match** the key you entered in the SonarQube UI when creating the project. This identifies the project on the server.
   - `sonar.sources` defines the directories to scan for source code. Here we use `.` to include all files in the project. You could specify a `src/` folder or specific paths if needed.
   - The `sonar.exclusions` property excludes certain files from analysis. In this example, we exclude everything under a `tests/` folder so that unit test code is not analyzed.
   - You can add other settings as needed (like `sonar.python.version` if required, or coverage report paths, etc.), but the above is enough for a basic analysis.

3. **Run the SonarScanner**: Execute the scanner from your project directory. You need to provide the authentication token (or login credentials) and ensure the scanner knows how to reach the SonarQube server. You can specify these via command-line arguments:

   ```bash
   sonar-scanner -Dsonar.host.url=http://localhost:9000 -Dsonar.login=<YOUR_TOKEN>
   ```

   Replace `<YOUR_TOKEN>` with the token you generated (a long alphanumeric string). The `sonar.host.url` should point to your SonarQube server (default is http://localhost:9000). We specify it here to be explicit, but if you didn’t change it, the default URL is already `localhost:9000`. The `sonar.login property` is used to pass your token for authentication this is more secure than using username/password. (If you didn’t create a token, you can use `-Dsonar.login=admin -Dsonar.password=admin` with the admin credentials, but using a token is the preferred method.)

   **Tip**: *If you added the scanner to your PATH (or to your `.bashrc`), you can run sonar-scanner from anywhere. If not, you might need to specify the full path to the sonar-scanner executable.*

4. **Observe the analysis output**: The scanner will run through your files, upload data to the SonarQube server, and print progress to the console.
5. **View results in SonarQube**: Go back to the SonarQube web UI (Projects page) and find your project. You should see the new analysis with various code metrics, issues, code smells, etc. The dashboard will show overall quality status, and you can drill down into specific issues in your Python code.

## 4. SonarQube Quality Gates and Rules

After an analysis, **SonarQube** determines whether your project passes or fails the **quality gate**. It also reports on various issues found by applying coding rules. Here’s a basic overview of these concepts:

- **Quality Gates**: A quality gate is a set of conditions that answers the question ***“Is my project ready for release?”***. Each condition is typically a threshold on a metric or issue count. For example, the default **Sonar Way** quality gate (provided by **SonarQube**) might require:
  - **No issues** (no bugs or code smells)
  - **All security hotspots are reviewed** (any security-sensitive pieces of code are acknowledged)
  - **Code coverage ≥ 80%** (at least 80% of code is covered by tests)
  - **Duplication on code ≤ 3%** (low duplication in code)

If the project fails any one of the gate conditions, the quality gate status is **Failed**, indicating the code may not be ready to release. You can customize quality gates in **SonarQube’s Quality Gates settings**.

You can view the rules by navigating to **Rules** in the SonarQube UI, or see the active rules via **Quality Profiles**. If needed, an administrator can customize the quality profile – *for instance, to disable certain rules or add new ones* – and even create **custom profiles** for different projects. During analysis, any violation of an active rule will be reported as an issue in SonarQube.

## Sources

- [SonarQube Server](https://docs.sonarsource.com/sonarqube-server/latest/?_gl=1*bwumiy*_gcl_aw*R0NMLjE3NDc2NTQ0MTEuQ2p3S0NBandyYXZCQmhCakVpd0FJcjMwVlA1UW9EVTFKUWpJRGRmaVljaGpIZ3B1M25RZnQxeUlZRDNPUE9qRWpfZFhDN01fWXB3WXF4b0NIVDRRQXZEX0J3RQ..*_gcl_au*NTUxNjYwMDIwLjE3NDc2NTEyNDI.*_up*MQ..*_gs*MQ..*_ga*NTczMDMwMDE2LjE3MzY4NzAxMzI.*_ga_9JZ0GZ5TC6*czE3NDc2NTEyNDAkbzI3JGcxJHQxNzQ3NjU0NDExJGo1NSRsMCRoMCRkQm9QRkZMN1ZtUi0ybHh4SmNwTnBNQUo1YmZDc0VZSkFzdw..&gclid=CjwKCAjwravBBhBjEiwAIr30VP5QoDU1JQjIDdfiYchjHgpu3nQft1yIYD3OPOjEj_dXC7M_YpwYqxoCHT4QAvD_BwE)
- [SonarQube Documentations](https://docs.sonarsource.com)
- [SonarQube Community](https://community.sonarsource.com)

## References 

- Davide Scarpetta