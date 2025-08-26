#!/bin/bash

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
            echo "You chose to add a user."
            # We will add the function call here later
            ;;
        2)
            echo "You chose to delete a user."
            # We will add the function call here later
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
