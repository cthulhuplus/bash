#!/bin/bash
#Developed by Bill Brooks
#Script to create database on a cPanel server
#Variables
#cPanel Account, MySQL DB Name, MySQL User Name, MySQL User Password
cPAcc=$1
MyDBN=$2
MyDBU=$3
MyDBP=$4

#Functions
#function cPTest
#{
#grep "$cPAcc" /var/cpanel/users/* |grep USER |awk -F = '{print$2}'
#grep $cPAcc /etc/trueuserdomains |awk -F ': ' '{print$2}'
#grep bbrooks /etc/trueuserdomains |awk -F ': ' '{print$2}'
#}
function cPTest {
  if ! grep $cPAcc /var/cpanel/users/*
  then
    echo "Invalid cPanel account"
    exit 0
  fi

  #Make sure account isn't blank
  if [ -z $cPAcc ]
  then
    echo "Need an account name!"

  #Else, start doing work
  else
    echo "$cPAcc is a valid cPanel account"
fi
}
#echo "$cPTest"
#function shwdb
#{
#mysql --verbose -u root -p`grep pass= /root/.my.cnf |awk -F =\" '{print$2}' |sed 's/"//'` -e 'show databases' |grep $MyDBN
#}

#cPanel Account Validation
#if [ "$cPTest = $cPAcc" ]; then
#echo "The account $cPAcc is valid."
#elif [ -z $cPTest ]; then
#echo "The account $cPAcc is not valid."
#elif [ "$cPTest -ne $cPAcc" ]; then
#echo "The account $cPAcc is not valid."
#shwdb
#fi

#Code
#mysl --verbos --user=root --password=`grep pass= /root/.my.cnf |awk -F =\" '{print$2}' |sed 's/"//'` --execute="create database testdb"

##  This does not currently function properly##
