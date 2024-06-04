# Dev
## Registry reference
### NPM
using [.npmrc](https://docs.npmjs.com/cli/v10/configuring-npm/npmrc) file:
```conf
; Default registry
registry=https://registry.npmjs.org/
; Scoped registry
@thecodeinfluencer:registry=https://npm.pkg.github.com/
```
### Nuget
using [NuGet.Config](https://learn.microsoft.com/en-us/nuget/reference/nuget-config-file#packagesources) file:
- Path: /root/.nuget/NuGet/NuGet.Config
```xml
<packageSources>
    <clear />    
    <add key="nuget.org" value="https://api.nuget.org/v3/index.json" protocolVersion="3" />
    <add key="Contoso" value="https://contoso.com/packages/" />
    <add key="http-source" value="http://httpsourcetrusted/" allowInsecureConnections="true" />
    <add key="Test Source" value="c:\packages" />
</packageSources>

<?xml version="1.0" encoding="utf-8"?>
<configuration>
  <!-- <config>
    <add key="maxHttpRequestsPerSource" value="10" />
  </config> -->
  <packageSources>
    <add key="NexusRepo" value="https://nexus:8081/repository/nuget.org-proxy/" />
    <add key="http-source" value="http://httpsourcetrusted/" allowInsecureConnections="true" />
    <add key="nuget.org" value="https://api.nuget.org/v3/index.json" protocolVersion="3" />
  </packageSources>
  <config>
    <add key="allowUntrustedRoot" value="true" />
  </config>
</configuration>

```
### Maven
In maven adding a repo is a bit different we first need to set repo then pass server id username and password make sure to follow this example on how to create repository and [server](https://maven.apache.org/settings.html#servers)
```xml
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0
                              https://maven.apache.org/xsd/settings-1.0.0.xsd">

    <profiles>
        <profile>
            <id>custom-repo-profile</id>
            <repositories>
                <repository>
                    <id>sonartypeNexusRepo</id>
                    <url>http://localhost:8081/repository/maven-releases/</url>
                    <releases>
                        <enabled>true</enabled>
                    </releases>
                    <snapshots>
                        <enabled>true</enabled>
                    </snapshots>
                </repository>
            </repositories>
        </profile>
    </profiles>

    <activeProfiles>
        <activeProfile>custom-repo-profile</activeProfile>
    </activeProfiles>

    <servers>
        <server>
        <id>sonartypeNexusRepo</id>
        <username>admin</username>
        <password>admin</password>
        </server>
    </servers>
</settings>
```

here is an example of pushing a package with nexus and make sure mvn **settings.xml** is under the right dir (**e.g. /opt/maven/conf/settings.xml**)
```sh
mvn clean package -Dmaven.test.skip=true deploy:deploy-file -DgroupId=my.group.id -DartifactId=specialart -Dversion=1.0.0 -DgeneratePom=true -Dpackaging=jar  -DrepositoryId=sonartypeNexusRepo -Durl=http://localhost:8081/repository/maven-releases/ -Dfile=target/myapp-1.0.0.jar
```
