#!/bin/bash

# Generate Random Number
random_number=$((RANDOM % 100))
# Generate Random String
random_string=$(tr -dc a-z0-9 </dev/urandom | head -c 13 ; echo=)
# Display random value and script file name
echo "Random number: $random_number"
echo "Random string: $random_string"
