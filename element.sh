#!/bin/bash

# Define the PSQL command with required options
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

# If no input is provided, display a message and exit
if [[ -z $1 ]]; then
  echo Please provide an element as an argument.
  exit
fi

# Check if the argument provided is an atomic number
if [[ $1 =~ ^[1-9]+$ ]]; then
  # If it's a number, query information based on atomic number
  RESULT=$($PSQL "SELECT atomic_number, types.type, atomic_mass, melting_point_celsius, boiling_point_celsius, symbol, name FROM properties JOIN elements USING (atomic_number) JOIN types USING (type_id) WHERE atomic_number = $1")
else
  # If not a number, assume it's a string (element name or symbol) and query based on name or symbol
  RESULT=$($PSQL "SELECT atomic_number, types.type, atomic_mass, melting_point_celsius, boiling_point_celsius, symbol, name FROM properties JOIN elements USING (atomic_number) JOIN types USING (type_id) WHERE name = '$1' OR symbol = '$1'")
fi

# If element not found, display a message and exit
if [[ -z $RESULT ]]; then
  echo -e "I could not find that element in the database."
  exit
fi

# Iterate over each line of the query result
echo $RESULT | while IFS=" |" read ATOMIC_NUMBER TYPE MASS MELTING_POINT BOILING_POINT SYMBOL NAME; do
  # Display information about the element
  echo -e "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
done
