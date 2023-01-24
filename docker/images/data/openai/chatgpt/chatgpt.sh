#!/bin/bash

# API_KEY="YOURTOKEN" ./docker/images/data/openai/chatgpt/chatgpt.sh "hello"
# API_KEY="YOURTOKEN" bash <(curl -s https://raw.githubusercontent.com/LQss11/devops-tools/main/docker/images/data/openai/chatgpt/chatgpt.sh)
#!/bin/bash

# Set the OpenAI API key
API_KEY="$API_KEY"

# Set the prompt for the completion
# Set the model engine to use
model_engine="text-davinci-003"

# Set the temperature, max tokens, and presence penalty
temperature=0.5
max_tokens=4000
presence_penalty=0.0

while true; do
    # get the user input
    read -p "User:" userInput
    # Create the JSON data for the API request
    data=$(jq -n \
        --arg prompt "$userInput" \
        --argjson temperature "$temperature" \
        --argjson max_tokens "$max_tokens" \
        --argjson presence_penalty "$presence_penalty" \
        '{prompt: $prompt, temperature: $temperature, max_tokens: $max_tokens, presence_penalty: $presence_penalty}')

    # Send the API request and store the response
    response=$(curl -s -X POST \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer $API_KEY" \
        -d "$data" \
        "https://api.openai.com/v1/engines/$model_engine/completions")

    # Extract the choice from the response and print it
    echo "########################"
    echo "$response" | jq -r '.choices[0].text'
    echo "########################"
done

