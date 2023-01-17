# $env:APIKEY = "YOURTOKENHERE"
# powershell -File ./docker/images/data/openai/chatgpt/chatgpt.ps1 "hello"
Invoke-RestMethod -Method Post -Uri 'https://api.openai.com/v1/engines/text-davinci-003/completions' -Headers @{'Content-Type'='application/json';'Authorization'="Bearer $env:APIKEY";} -Body (ConvertTo-Json @{'prompt'="$args[0]";'temperature'=0.5;'max_tokens'=4000;'presence_penalty'=0.0;}) | Select-Object -ExpandProperty choices | Select-Object -First 1 | Select-Object -ExpandProperty text


# Or simply run
# $env:APIKEY = "YOUTTOKENHERE"
# $env:PROMPT = "hello world"
# Invoke-RestMethod -Method Post -Uri 'https://api.openai.com/v1/engines/text-davinci-003/completions' -Headers @{'Content-Type'='application/json';'Authorization'="Bearer $env:APIKEY";} -Body (ConvertTo-Json @{'prompt'="$env:PROMPT";'temperature'=0.5;'max_tokens'=4000;'presence_penalty'=0.0;}) | Select-Object -ExpandProperty choices | Select-Object -First 1 | Select-Object -ExpandProperty text
