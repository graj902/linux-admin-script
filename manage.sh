#!/bin/bash
# --- Function Definitions ---

# Function to add a new user
add_user() {
    echo "--- Add New User ---"
    read -p "Enter the username to create: " username
    
    # Check if the user already exists
    if id "$username" &>/dev/null; then
        echo "Error: User '$username' already exists."
    else
        # Ask for a password for the new user
        read -s -p "Enter password for $username: " password
        echo
        
        # Create the user with the specified password
        # -m creates the user's home directory
        # -p uses openssl to create a compatible password hash
        useradd -m -p "$(openssl passwd -1 "$password")" "$username"
        
        # Check if the user was created successfully
        if [ $? -eq 0 ]; then
            echo "User '$username' has been created successfully."
        else
            echo "Error: Failed to create user '$username'."
        fi
    fi
}
# Function to delete an existing user
delete_user() {
    echo "--- Delete User ---"
    read -p "Enter the username to delete: " username
    
    # Check if the user exists before trying to delete
    if id "$username" &>/dev/null; then
        # Ask for confirmation before deleting
        read -p "Are you sure you want to delete the user '$username' and their home directory? [y/N]: " confirm
        
        # Check the confirmation, default to No
        if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
            # Delete the user and their home directory (-r flag)
            userdel -r "$username"
            
            # Check if the user was deleted successfully
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
}
# --- Main Script Body ---
# (Your 'while true' loop and menu are below this)
# A simple script for user management and backups.

# Infinite loop to display the menu until the user exits
while true; do
    # Clear the screen for a clean menu display
    clear
    
    # Display the menu options
    echo "--------------------------------------"
    echo "  Linux User Management & Backup Menu "
    echo "--------------------------------------"
    echo "1. Add a new user"
    echo "2. Delete a user"
    echo "3. Modify a user"
    echo "4. Create a group"
    echo "5. Add a user to a group"
    echo "6. Create a backup of a directory"
    echo "0. Exit"
    echo "--------------------------------------"
    
    # Prompt the user to enter their choice
    read -p "Enter your choice [0-6]: " choice
    
    # Use a case statement to act on the user's choice
    case $choice in
        1)
            
            # We will add the function call here later
            add_user
            ;;
        2)
            # We will add the function call here later
            delete_user
            ;;
        3)
            echo "You chose to modify a user."
            # We will add the function call here later
            ;;
        4)
            echo "You chose to create a group."
            # We will add the function call here later
            ;;
        5)
            echo "You chose to add a user to a group."
            # We will add the function call here later
            ;;
        6)
            echo "You chose to create a backup."
            # We will add the function call here later
            ;;
        0)
            echo "Exiting the script. Goodbye!"
            exit 0
            ;;
        *)
            # Handle invalid input
            echo "Invalid choice. Please enter a number between 0 and 6."
            ;;
    esac
    
    # Pause to allow the user to see the output before the menu redisplays
    read -p "Press [Enter] to continue..."
done
