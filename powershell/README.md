# Powershell
Set environment variables
```sh
# Command argument level
$env:ENV1='Test'; $env:VAR2='variable'; echo "This is a $env:ENV1 $env:VAR2 example"
# System level
[System.Environment]::SetEnvironmentVariable('FOO', 'bar',[System.EnvironmentVariableTarget]::Machine)
```
