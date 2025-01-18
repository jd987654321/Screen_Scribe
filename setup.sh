#!/bin/bash

#check if brew is installed
brew --version 

brewIsInstalled=1

if [ $? -eq 0 ]; then
    echo "Brew is installed"
    brewIsInstalled=0
else 
    echo "Brew is not installed"
    echo -e "Would you like to install homebrew? (y/n)" 
    read answer

    if [ "$answer" == "y" ] || [ "$answer" == "Y" ]; then
        echo "Awesome just gonna run a command to install brew for ya"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        brewIsInstalled=0
    elif [ "$answer" == "n" ] || [ "$answer" == "N" ]; then
        echo "Well ya need brew to have this run"
    else
        echo "Enter 'y' for yes and 'n' for no"
    fi
fi

if [ $brewIsInstalled -eq 0 ]; then
    echo -e "Would you like to install tesseract and hammerspoon, these are required for the screen scribe to work. (y/n)" 
    read answer
    if [ "$answer" == "y" ] || [ "$answer" == "Y" ]; then
        echo "Awesome just install those for ya"
        brew install tesseract hammerspoon
        touch ~/.hammerspoon/init.lua
        cat init.lua >> ~/.hammerspoon/init.lua
    elif [ "$answer" == "n" ] || [ "$answer" == "N" ]; then
        echo "Well ya need these for screen scribe to work"
    else
        echo "Enter 'y' for yes and 'n' for no"
    fi
fi








