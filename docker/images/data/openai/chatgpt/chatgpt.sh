# API_KEY="YOURTOKEN" ./docker/images/data/openai/chatgpt/chatgpt.sh "hello"
openai_prompt="$1"
openai_api_key="$API_KEY"
openai_model_engine="text-davinci-003"
openai_temperature=0.5
openai_max_tokens=4000
openai_presence_penalty=0.0

response=$(curl -s -X POST \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $openai_api_key" \
  -d "{\"prompt\": \"$openai_prompt\", \"temperature\": $openai_temperature, \"max_tokens\": $openai_max_tokens, \"presence_penalty\": $openai_presence_penalty}" \
  https://api.openai.com/v1/engines/$openai_model_engine/completions) 

echo -e $(echo "$response" | grep -Po '"choices":\[\K[^\]]*' | awk -F '{' '{print $2}' | awk -F '"' '{print $4}')