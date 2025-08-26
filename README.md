# Linux User Management & Backup Automation Script

A comprehensive shell script designed to simplify and automate common Linux administrative tasks, including user management, group management, and directory backups. This project demonstrates proficiency in shell scripting, Linux system administration, and version control with Git.

---

## Table of Contents
1.  [Features](#features)
2.  [Prerequisites](#prerequisites)
3.  [Installation & Usage](#installation--usage)
4.  [Script Functions in Detail](#script-functions-in-detail)
    -   [User Management](#user-management)
    -   [Group Management](#group-management)
    -   [Backup Management](#backup-management)

---

## Features
-   **Interactive Menu:** A user-friendly, command-line menu for easy navigation.
-   **User Management:** Add, delete, and modify user accounts.
-   **Group Management:** Create new groups and add existing users to them.
-   **Automated Backups:** Create compressed backups (`.tar.gz`) of any specified directory with a timestamp.
-   **Error Handling:** Includes checks to prevent common errors, such as creating a user that already exists or backing up a non-existent directory.
-   **Security:** Designed to be run with `sudo` for proper administrative permissions.

---


## Prerequisites
-   A Linux-based operating system (tested on Ubuntu 24.04).
-   Root or `sudo` privileges to execute administrative commands.
-   `openssl` package (used for password hashing, typically installed by default).

---


## Installation & Usage

### 1. Clone the Repository
Clone this repository to your Linux server or local machine.
```bash
git clone https://github.com/graj902/linux-admin-script.git
cd linux-admin-script

2. Make the Script Executable
You only need to do this once. This command gives the script permission to be run as a program.
code
Bash
chmod +x manage.sh
3. Run the Script

Execute the script with sudo to ensure it has the necessary permissions for all administrative tasks.
code
Bash
sudo ./manage.sh
You will be presented with the main menu. Follow the on-screen prompts to select an option.
Script Functions in Detail

User Management
Add a new user: Prompts for a username and password. Creates the user along with their home directory.
Delete a user: Prompts for a username and asks for confirmation before permanently deleting the user and their home directory.
Modify a user: Allows you to change the password for an existing user.

Group Management
Create a group: Prompts for a new group name and creates it on the system.
Add a user to a group: Prompts for an existing username and an existing group name, then adds the user to that group.

Backup Management
Create a backup of a directory:
Prompts for the full path of the source directory you want to back up.
Prompts for the full path of the destination where the backup file will be saved.
Creates a compressed archive with a timestamp (e.g., etc_backup_20250826_193000.tar.gz).
