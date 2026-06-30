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

if [[ $EUID -ne 0 ]]; then
   echo "Please run this script as root"
   exit 1
fi

while true; do
    show_menu
    read choice
    
    case $choice in
        1)
            read -p "Enter new username: " username
            useradd -m "$username"
            if [[ $? -eq 0 ]]; then
                echo "User created successfully"
                passwd "$username"
            else
                echo "Failed to create user"
            fi
            ;;
        
        2)
            read -p "Enter username to delete: " username
            userdel -r "$username"
            if [[ $? -eq 0 ]]; then
                echo "User deleted successfully"
            else
                echo "Failed to delete user"
            fi
            ;;
        
        3)
            echo "1. Add user to group"
            echo "2. Remove user from group"
            read -p "Choose option: " opt
            
            case $opt in
                1)
                    read -p "Enter username: " user
                    read -p "Enter group: " group
                    usermod -aG "$group" "$user"
                    echo "User added to group"
                    ;;
                2)
                    read -p "Enter username: " user
                    read -p "Enter group: " group
                    gpasswd -d "$user" "$group"
                    echo "User removed from group"
                    ;;
                *)
                    echo "Invalid option"
                    ;;
            esac
            ;;
        
        4)
            read -p "Enter directory to backup: " dir
            read -p "Enter backup file name: " name
            
            if [[ -d "$dir" ]]; then
                tar -czvf "${name}.tar.gz" "$dir"
                echo "Backup created"
            else
                echo "Directory does not exist"
            fi
            ;;
        
        5)
            echo "Exiting"
            exit 0
            ;;
        
        *)
            echo "Invalid option"
            ;;
    esac
    
    echo -n "Press Enter to continue..."
    read
    clear
done
