#!/bin/bash

#check if brew is installed
brew --version 

brewIsInstalled=1

if [ $? -eq 0 ]; then
    echo "Brew is installed"
    brewIsInstalled=0
else 
    while true; do 
        echo "Brew is not installed"
        read -p "Would you like to install homebrew? (y/n): " answer

        if [ "$answer" == "y" ] || [ "$answer" == "Y" ]; then
            echo "Awesome just gonna run a command to install brew for ya"
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            brewIsInstalled=0
            break
        elif [ "$answer" == "n" ] || [ "$answer" == "N" ]; then
            echo "Well ya need brew to have this run"
            break
        else
            echo "Enter 'y' for yes and 'n' for no"
        fi
    done
fi

if [ $brewIsInstalled -eq 0 ]; then
    read -p "Would you like to install tesseract and hammerspoon, these are required for the screen scribe to work. (y/n)" answer

    while true; do
        if [ "$answer" == "y" ] || [ "$answer" == "Y" ]; then
            echo "Awesome just install those for ya"
            brew install tesseract hammerspoon
            init_lua_file=$(realpath init.lua)
            cat init.lua >> "$init_lua_file"
            break
        elif [ "$answer" == "n" ] || [ "$answer" == "N" ]; then
            echo "Well ya need these for screen scribe to work"
            break
        else
            echo "Enter 'y' for yes and 'n' for no"
        fi
    done
fi








