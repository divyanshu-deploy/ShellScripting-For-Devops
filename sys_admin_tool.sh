#!/bin/bash

show_menu() {
    echo "========================================"
    echo "    Linux System Administration Tool    "
    echo "========================================"
    echo "1. Add a User Account"
    echo "2. Delete a User Account"
    echo "3. Modify User/Group Settings"
    echo "4. Backup a Directory"
    echo "5. Exit"
    echo "========================================"
    echo -n "Please enter your choice [1-5]: "
}

while true; do
    show_menu
    read choice
    
    case $choice in
        1)
            echo -e "\n--- Add a New User Account ---"
            read -p "Enter the username to create: " username

            if [ -z "$username" ]; then
                echo "Error: Username cannot be blank."
            elif id "$username" &>/dev/null; then
                echo "Error: User '$username' already exists!"
            else
                sudo useradd -m "$username"
                if [ $? -eq 0 ]; then
                    echo "Success: User '$username' has been created successfully."
                    echo "$username:$username" | sudo chpasswd
                    echo "Temporary password set to: $username"
                else
                    echo "Failed to create user '$username'."
                fi
            fi
            echo "--------------------------------"
            ;;
        2)
            echo -e "\n--- Delete a User Account ---"
            read -p "Enter the username to delete: " username

            if [ -z "$username" ]; then
                echo "Error: Username cannot be blank."
            elif ! id "$username" &>/dev/null; then
                echo "Error: User '$username' does not exist!"
            else
                sudo userdel -r "$username"
                if [ $? -eq 0 ]; then
                    echo "Success: User '$username' and their home directory have been deleted."
                else
                    echo "Failed to delete user '$username'."
                fi
            fi
            echo "--------------------------------"
            ;;
        3)
            echo -e "\n--- Modify User/Group Settings ---"
            read -p "Enter username: " username
            read -p "Enter group name to add user to: " groupname

            if [ -z "$username" ] || [ -z "$groupname" ]; then
                echo "Error: Username and Group name cannot be blank."
            elif ! id "$username" &>/dev/null; then
                echo "Error: User '$username' does not exist!"
            else
                if ! getent group "$groupname" &>/dev/null; then
                    sudo groupadd "$groupname"
                fi
                sudo usermod -aG "$groupname" "$username"
                if [ $? -eq 0 ]; then
                    echo "Success: User '$username' added to group '$groupname'."
                else
                    echo "Failed to modify settings."
                fi
            fi
            echo "--------------------------------"
            ;;
        4)
            echo -e "\n--- Backup a Directory ---"
            read -p "Enter the absolute path of the directory to backup: " src_dir
            read -p "Enter the absolute path of destination folder: " dest_dir

            if [ ! -d "$src_dir" ]; then
                echo "Error: Source directory does not exist!"
            elif [ ! -d "$dest_dir" ]; then
                echo "Error: Destination directory does not exist!"
            else
                backup_file="${dest_dir}/backup_$(basename "$src_dir")_$(date +%F_%H%M%S).tar.gz"
                sudo tar -czf "$backup_file" "$src_dir" 2>/dev/null
                if [ $? -eq 0 ]; then
                    echo "Success: Backup created at $backup_file"
                else
                    echo "Failed to create backup."
                fi
            fi
            echo "--------------------------------"
            ;;
        5)
            echo -e "\nExiting tool. Goodbye!\n"
            exit 0
            ;;
        *)
            echo -e "\nInvalid option! Please choose a number between 1 and 5.\n"
            ;;
    esac
    
    echo -n "Press Enter to return to the menu..."
    read
    clear
done
