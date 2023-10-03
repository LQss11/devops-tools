# Sonar lint
Run server:
```sh
docker run -it --rm -p 9002:9000 -e USER_LOGIN="admin" -e USER_NAME="admin" -e USER_PASSWORD="admin" sonarqube:lts-community
```
For ldap config you can check [this](https://docs.sonarsource.com/sonarqube/9.9/instance-administration/authentication/ldap/#:~:text=You%20can%20configure%20SonarQube%20authentication,against%20the%20external%20authentication%20engine.) 
# Scanning
Each application has its own scanning method you can find out more [here](https://docs.sonarsource.com/sonarqube/9.9/analyzing-source-code/scanners/sonarscanner/)
## Maven
```sh
docker run -it --rm sonarsource/sonar-scanner-cli sonar-scanner "-Dsonar.projectKey=${YOUR_PROJECT_KEY} -Dsonar.login=${YOUR_TOKEN} -Dsonar.host.url=$SONAR_URL"
```
## Dotnet
```sh
docker run -it --rm mcr.microsoft.com/dotnet/sdk:5.0.400-buster-slim sh -c "dotnet tool install --global dotnet-sonarscanner --version 5.13.0 && ln -s /root/.dotnet/tools/dotnet-sonarscanner /usr/bin/ && dotnet sonarscanner begin /ket:$KEY /d:sonar.login=$SONAR_LOGIN /d:sonar.host.url=$SONAR_URL && dotnet publish && sonarscanner end /d:sonar.login=$SONAR_LOGIN"
```