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
#grep $cPAcc /etc/trueuserdomains |awk -F : '{print$1}'
#}

function shwdb
{
mysql --verbose -u root -p`grep pass= /root/.my.cnf |awk -F =\" '{print$2}' |sed 's/"//'` -e 'show databases' |grep $MyDBN
#grep pass= /root/.my.cnf |awk -F =\" '{print$2}' |sed 's/"//'
}

#echo "cPanel Account"
#echo "$cPAcc"
#echo "Database Name"
#echo "$shwdb"

shwdb

#cPanel Account Validation
#if [ "$cPAcc = $cPTest" ]; then
#echo "The account $cPAcc is valid."
#else
#echo "The account $cPAcc is not valid."
#fi

#Verify that MySQL does not already exist
#mysql -u root -p$rtSQL -e 'show databases' |grep $MyDBN
