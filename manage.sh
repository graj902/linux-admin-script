#!/bin/bash

# A shell script to automate Linux user management and backups.

# --- Function Definitions ---

# A simple function to pause the script and wait for user input
pause() {
    read -p "Press [Enter] to continue..."
}

# Function to add a new user
add_user() {
    echo "--- Add New User ---"
    read -p "Enter the username to create: " username
    
    if id "$username" &>/dev/null; then
        echo "Error: User '$username' already exists."
    else
        read -s -p "Enter password for $username: " password
        echo
        useradd -m -p "$(openssl passwd -1 "$password")" "$username"
        if [ $? -eq 0 ]; then
            echo "User '$username' has been created successfully."
        else
            echo "Error: Failed to create user '$username'."
        fi
    fi
    pause
}

# Function to delete an existing user
delete_user() {
    echo "--- Delete User ---"
    read -p "Enter the username to delete: " username
    
    if id "$username" &>/dev/null; then
        read -p "Are you sure you want to delete user '$username' and their home directory? [y/N]: " confirm
        if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
            userdel -r "$username"
            if [ $? -eq 0 ]; then
                echo "User '$username' has been deleted successfully."
            else
                echo "Error: Failed to delete user '$username'."
            fi
        else
            echo "User deletion cancelled."
        fi
    else
        echo "Error: User '$username' does not exist."
    fi
    pause
}

# Function to modify a user's password
modify_user() {
    echo "--- Modify User (Change Password) ---"
    read -p "Enter the username to modify: " username

    if id "$username" &>/dev/null; then
        read -s -p "Enter new password for $username: " password
        echo
        echo "$username:$password" | chpasswd
        if [ $? -eq 0 ]; then
            echo "Password for user '$username' has been changed successfully."
        else
            echo "Error: Failed to change password for user '$username'."
        fi
    else
        echo "Error: User '$username' does not exist."
    fi
    pause
}

# Function to create a new group
create_group() {
    echo "--- Create New Group ---"
    read -p "Enter the group name to create: " groupname

    if grep -q "^$groupname:" /etc/group; then
        echo "Error: Group '$groupname' already exists."
    else
        groupadd "$groupname"
        if [ $? -eq 0 ]; then
            echo "Group '$groupname' has been created successfully."
        else
            echo "Error: Failed to create group '$groupname'."
        fi
    fi
    pause
}

# Function to add a user to a group
add_user_to_group() {
    echo "--- Add User to Group ---"
    read -p "Enter the username: " username
    read -p "Enter the group name: " groupname

    if ! id "$username" &>/dev/null; then
        echo "Error: User '$username' does not exist."
    elif ! grep -q "^$groupname:" /etc/group; then
        echo "Error: Group '$groupname' does not exist."
    else
        usermod -aG "$groupname" "$username"
        if [ $? -eq 0 ]; then
            echo "User '$username' has been successfully added to group '$groupname'."
        else
            echo "Error: Failed to add user to group."
        fi
    fi
    pause
}

# Function to create a backup of a directory
create_backup() {
    echo "--- Create Directory Backup ---"
    read -p "Enter the full path of the directory to back up: " source_dir

    if [ ! -d "$source_dir" ]; then
        echo "Error: Directory '$source_dir' does not exist."
    else
        read -p "Enter the full path for the backup destination: " dest_dir
        # Create destination directory if it doesn't exist
        mkdir -p "$dest_dir"
        
        # Create a timestamped backup filename
        timestamp=$(date +"%Y%m%d_%H%M%S")
        backup_file="$dest_dir/$(basename "$source_dir")_backup_$timestamp.tar.gz"
        
        echo "Creating backup of '$source_dir'..."
        # Create a compressed tarball of the source directory
        tar -czf "$backup_file" -C "$(dirname "$source_dir")" "$(basename "$source_dir")"
        
        if [ $? -eq 0 ]; then
            echo "Backup created successfully: $backup_file"
        else
            echo "Error: Backup failed."
        fi
    fi
    pause
}

# --- Main Script Body ---

# Infinite loop to display the menu until the user exits
while true; do
    clear
    echo "--------------------------------------"
    echo "  Linux User Management & Backup Menu "
    echo "--------------------------------------"
    echo "1. Add a new user"
    echo "2. Delete a user"
    echo "3. Modify a user (change password)"
    echo "4. Create a group"
    echo "5. Add a user to a group"
    echo "6. Create a backup of a directory"
    echo "0. Exit"
    echo "--------------------------------------"
    
    read -p "Enter your choice [0-6]: " choice
    
    case $choice in
        1) add_user ;;
        2) delete_user ;;
        3) modify_user ;;
        4) create_group ;;
        5) add_user_to_group ;;
        6) create_backup ;;
        0)
            echo "Exiting the script. Goodbye!"
            exit 0
            ;;
        *)
            echo "Invalid choice. Please enter a number between 0 and 6."
            pause
            ;;
    esac
done
