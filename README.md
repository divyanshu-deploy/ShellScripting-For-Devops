# My First DevOps Project: Linux Administration & Backup Automation Tool

## What is this?
This is my very first hands-on DevOps project! I built an interactive Bash shell script designed to automate core system administration and housekeeping tasks on a Linux server. 

Instead of typing repetitive commands manually, I wrapped everything into a clean, looping command-line menu that lets me manage users, handle group permissions, and run backups instantly.

## The Architecture & My Workflow
I didn't just write this code locally—I simulated a real-world production environment:
1. **Cloud Infrastructure:** I launched and configured an Ubuntu Linux virtual machine using an AWS EC2 instance.
2. **Remote Management:** I managed the entire project from my Mac Terminal, connecting to the AWS instance securely via SSH using key pairs (`.pem`).
3. **Version Control:** I initialized Git on the cloud server and pushed this code repository securely up to my GitHub profile (`divyanshu-deploy`) using Personal Access Tokens (PAT).

## Features Built
* **User Provisioning (Option 1 & 2):** Dynamically creates or destroys Linux user accounts. It includes safety checks to prevent blank inputs or duplicate accounts, and automatically provisions home directories (`useradd -m`).
* **Group Management (Option 3):** Automatically creates a user-specified group if it doesn't exist and safely appends the user to it (`usermod -aG`).
* **Automated Archiving (Option 4):** Compresses and archives any specified directory into a timestamped `.tar.gz` backup file and deposits it safely into a destination folder.

## How to Run It
To run this tool, the script requires administrative privileges because it updates system-level security configuration files:

```bash
chmod +x sys_admin_tool.sh
sudo ./sys_admin_tool.sh
