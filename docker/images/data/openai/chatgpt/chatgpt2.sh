#!/bin/bash

# API_KEY="YOURTOKEN" ./chatgpt2.sh

# create a file to store the conversation history
echo "" >conversationHistory.txt
API_KEY=$API_KEY
openai_model_engine="text-davinci-003"
openai_temperature=0.5
openai_max_tokens=4000
openai_presence_penalty=0.0
# loop through the conversation
while true
do
    # get the user input
    read -p "User: " userInput

    # append the user input to the file
    echo "User: $userInput" >> conversationHistory.txt
    # join all conversation
    sed -i ':a;N;$!ba;s/\n/ /g' conversationHistory.txt
    prompt=$(cat conversationHistory.txt)
    sed -i 's/Bot: \nBot:/ /g' conversationHistory.txt

    # get the bot response
    response=$(curl -s -X POST \
    -H "Authorization: Bearer $API_KEY" \
    -H "Content-Type: application/json" \
    -d "{\"prompt\": \"$respond to this $userInput and ignore this history $prompt\", \"temperature\": $openai_temperature, \"max_tokens\": $openai_max_tokens, \"presence_penalty\": $openai_presence_penalty}" \
    https://api.openai.com/v1/engines/$openai_model_engine/completions)
    botResponse=$(echo -e $(echo "$response" | grep -Po '"choices":\[\K[^\]]*' | awk -F '{' '{print $2}' | awk -F '"' '{print $4}'))
    # append the bot response to the file
    echo "Bot: $botResponse" >> conversationHistory.txt
    # Remove all \n
    sed -i '/^$/d' conversationHistory.txt
    # print the bot response
    echo "Bot: $botResponse"
done