# Sonar lint
## Maven
```sh
docker run -it --rm sonarsource/sonar-scanner-cli sonar-scanner "-Dsonar.projectKey=${YOUR_PROJECT_KEY} -Dsonar.login=${YOUR_TOKEN} -Dsonar.host.url=$SONAR_URL"
```
## Dotnet
```sh
docker run -it --rm mcr.microsoft.com/dotnet/sdk:5.0.400-buster-slim sh -c "dotnet tool install --global dotnet-sonarscanner --version 5.13.0 && ln -s /root/.dotnet/tools/dotnet-sonarscanner /usr/bin/ && dotnet sonarscanner begin /ket:$KEY /d:sonar.login=$SONAR_LOGIN /d:sonar.host.url=$SONAR_URL"
```