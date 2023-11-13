# Enable angular on an angular app
You can simply follow these steps:

Run the following `npm install @elastic/apm-rum-angular --save`

**app.modules.ts**
```ts
import { NgModule, ErrorHandler  } from '@angular/core'
import { BrowserModule } from '@angular/platform-browser'
import { Routes, RouterModule } from '@angular/router'
import { ApmModule, ApmService, ApmErrorHandler  } from '@elastic/apm-rum-angular'

const routes: Routes = [
  { path: 'contact', component: ContactListComponent },
  { path: 'contact/:id', component: ContactDetailComponent }
]

@NgModule({
  imports: [ApmModule, BrowserModule, RouterModule.forRoot(routes)],
  declarations: [AppComponent, ContactListComponent, ContactDetailComponent],
  providers: [ApmService],
  bootstrap: [AppComponent]
})
export class AppModule {
  constructor(service: ApmService) {
    // Agent API is exposed through this apm instance
    const apm = service.init({
      serviceName: 'angular-app',
      serverUrl: 'http://host.docker.internal:8200'
    })

    apm.setUserContext({
      'username': 'foo',
      'id': 'bar'
    })
  }
}

```

- Find more in the [official documentation.](https://www.elastic.co/guide/en/apm/agent/rum-js/current/angular-integration.html)
- [Elastic apm rum angular NPM](https://www.npmjs.com/package/@elastic/apm-rum-angular)