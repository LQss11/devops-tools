# Enable angular on an ASP.NET app
You can enable apm agent on an asp.net core app by adding it from nuget repo then adding the code to enable it.

**Web.csproj**
```xml
  <ItemGroup>
    <PackageReference Include="Elastic.Apm.NetCoreAll" Version="1.11.0" />
  </ItemGroup>
```
**Startup.cs**
```cs
using Elastic.Apm.AspNetCore;
using Elastic.Apm.DiagnosticSource;
using Elastic.Apm.EntityFrameworkCore;

public class Startup
{
  public void Configure(IApplicationBuilder app, IHostingEnvironment env)
  {
    app.UseElasticApm(Configuration,
      new HttpDiagnosticsSubscriber(),  /* Enable tracing of outgoing HTTP requests */
      new EfCoreDiagnosticsSubscriber()); /* Enable tracing of database calls through EF Core*/
    //…rest of the method
  }
  //…rest of the class
}
```
For further configuration you can add this to your appsettings to toggle agent or more..

**Appsettings.json**
```json
{
  "Logging": {
    "LogLevel": {
      "Default": "Warning"
    }
  },
  "AllowedHosts": "*",
  "ElasticApm":
    {
      "LogLevel":  "Debug",
      "ServerUrl":  "http://myapmserver:8200",
      "SecretToken":  "apm-server-secret-token",
      "TransactionSampleRate": 1.0
    }
}
```
- Find more in the [official documentation.](https://www.elastic.co/guide/en/apm/agent/dotnet/current/setup-asp-net-core.html)
- [Elastic apm NUGET package](https://www.nuget.org/packages/Elastic.Apm.NetCoreAll)
- [Appsettings configuration](https://www.elastic.co/guide/en/apm/agent/dotnet/current/configuration-on-asp-net-core.html)
- [Additional configuration information](https://www.elastic.co/guide/en/apm/agent/dotnet/current/config-core.html)