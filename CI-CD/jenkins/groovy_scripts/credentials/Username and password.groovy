#!groovy

import com.cloudbees.plugins.credentials.impl.*
import com.cloudbees.plugins.credentials.*
import com.cloudbees.plugins.credentials.domains.*

// to reference environment variables uncomment the next two lines:
// def env = System.getenv()
// String username = env.YOUR_ENV_VAR

String id = 'user-key'
String description = 'Description'
String username = 'username'
String password = 'password'

Credentials cred = (Credentials) new UsernamePasswordCredentialsImpl(CredentialsScope.GLOBAL, id, description, username, password)
SystemCredentialsProvider.getInstance().getStore().addCredentials(Domain.global(), cred)