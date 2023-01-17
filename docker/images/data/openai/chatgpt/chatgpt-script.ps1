# $env:APIKEY = "apikey"
# Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process
# powershell -File ./docker/images/data/openai/chatgpt/chatgpt.ps1 "What is the capital of France?"
$prompt = $args[0]
$apiKey = $env:APIKEY
$temperature = 0.5
$max_tokens = 4000
$presence_penalty = 0.0

try {
    Invoke-RestMethod -Method Post -Uri 'https://api.openai.com/v1/engines/text-davinci-003/completions' -Headers @{'Content-Type'='application/json';'Authorization'="Bearer $apiKey";} -Body (ConvertTo-Json @{'prompt'=$prompt;'temperature'=$temperature;'max_tokens'=$max_tokens;'presence_penalty'=$presence_penalty;}) -OutFile response.json -UseBasicParsing
    $response = Get-Content response.json | ConvertFrom-Json
    $response.choices[0].text
}
catch {
    Write-Error "Error Occured: $_"
    Write-Error "API call failed at $(Get-Date)" | Out-File error.log -Append
}