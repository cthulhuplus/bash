#!/bin/bash
#Developed by Bill Brooks
echo "Welcome to Linux!"
echo "What is your name?"
read name
echo "Nice to meet you $name!"
read -p "Press enter when you are ready to continue."
echo " " ###Blank Line
echo "$name, the first thing you want to do is learn where you are!"
echo "You can do this by typing 'pwd' and pressing enter."
echo " " ###Blank Line
read -p "Do this now! " pwd
pwd
read -p "Press enter to continue."
echo " " ###Blank line
echo "`pwd` is where you are in the file system."
echo "The file system is how Linux organizes EVERYTHING!"
echo "The start of the file system is \/, or root"
