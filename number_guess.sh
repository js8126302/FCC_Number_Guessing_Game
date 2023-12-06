#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=<database_name> -t --no-align -c"

# generate random number
RANDOM_NUMBER=$RANDOM
# prompting user for username
echo "Enter your username:"
read USERNAME
RESULT=$($PSQL SELECT * FROM )