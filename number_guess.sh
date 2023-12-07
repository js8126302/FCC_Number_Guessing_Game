#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

# generate random number
RANDOM_NUMBER=$RANDOM
# prompting user for username
echo "Enter your username:"
read USERNAME
RESULT=$($PSQL "SELECT user_id, username, games_played, best_game FROM users WHERE username='$USERNAME'")
# extracting values from result
IFS='|' read USER_ID PSQL_USERNAME PSQL_GAMES_PLAYED PSQL_BEST_GAME <<< "$RESULT"

# checking if query is empty
if
[[ -z "$PSQL_USERNAME" ]];
  then
     echo -e "Welcome, $USERNAME! It looks like this is your first time here."
  else
     echo -e "Welcome back, $USERNAME! You have played $PSQL_GAMES_PLAYED games, and your best game took $PSQL_BEST_GAME guesses."
fi
