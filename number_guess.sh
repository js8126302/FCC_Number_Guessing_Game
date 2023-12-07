#!/bin/bash




PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

# generate random number
RANDOM_NUMBER=$((RANDOM % 1001))
echo $RANDOM_NUMBER
# prompting user for username
echo "Enter your username:"
read USERNAME
RESULT=$($PSQL "SELECT username, games_played, best_game FROM users WHERE username='$USERNAME'") 
# extracting values from result
IFS='|' read PSQL_USERNAME PSQL_GAMES_PLAYED PSQL_BEST_GAME <<< "$RESULT"

if [[ -z "$USERNAME" ]]; then
  echo "Please provide a username."
  exit 1
fi

# checking if query is empty
if
[[ -z "$PSQL_USERNAME" ]];
  then
     echo -e "Welcome, $USERNAME! It looks like this is your first time here."
     $PSQL "INSERT INTO users(username, games_played, best_game) VALUES('$USERNAME', 0, 0)" > /dev/null
  else
     echo -e "Welcome back, $PSQL_USERNAME! You have played $PSQL_GAMES_PLAYED games, and your best game took $PSQL_BEST_GAME guesses."
fi
# User input for guessing number
echo "Guess the secret number between 1 and 1000: " 
read USER_GUESS


NUMBER_OF_GUESSES=1

# main loop to check if user guess is correct
while [[ $USER_GUESS -ne $RANDOM_NUMBER ]]
do
# input validation for user input
  if ! [[ $USER_GUESS =~ ^[0-9]+$ && $USER_GUESS -ge 1 && $USER_GUESS -le 1000 ]]; then
    echo -e "\nThat is not an integer, guess again:"
  else
# checking if user guess is greater than random number
     if [[ $USER_GUESS -gt $RANDOM_NUMBER ]]; then
        echo -e "It's lower than that, guess again:"
     else # checking if user guess is smaller  than random number
        echo -e "It's higher than that, guess again:"
     fi
  fi
  ((NUMBER_OF_GUESSES++)) 
  read USER_GUESS

done
echo -e "You guessed it in $NUMBER_OF_GUESSES tries. The secret number was $RANDOM_NUMBER. Nice job!"

# finding minimum for number of guesses
MINIMUM=$((PSQL_BEST_GAME == 0 || NUMBER_OF_GUESSES < PSQL_BEST_GAME ? NUMBER_OF_GUESSES : PSQL_BEST_GAME))

$PSQL "UPDATE users SET games_played=($PSQL_GAMES_PLAYED + 1),  best_game = $MINIMUM WHERE username='$USERNAME'" >/dev/null
exit
# comment one
# commit two
# commit three
# commit four



