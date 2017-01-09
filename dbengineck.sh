#!/bin/bash
#Developed by Bill Brooks
#This script is designed to check the table engine for a specific database.

#Prompts users to request database to check table status
read -p "Database Engine Checker Alpha - Check database: " dbck

mysql -v -u root -p`grep password= /root/.my.cnf |awk -F =\" '{print$2}' |sed 's/"//'` -e "show table status from $dbck" |awk '{print$1,"- "$2}' |sed '1,/Name - Engine/d'
