#!groovy

import com.cloudbees.plugins.credentials.*
import com.cloudbees.plugins.credentials.domains.Domain
import org.jenkinsci.plugins.plaincredentials.impl.FileCredentialsImpl
import java.nio.file.*

// Make sure the file exist
String filePath = '/root/.kube/config'
Path fileLocation = Paths.get(filePath)

String credId = 'kube'
String credDescription = 'description to the secret file'
String credName = 'kubeconfigfile'

def secretBytes = SecretBytes.fromBytes(Files.readAllBytes(fileLocation))
def credentials = new FileCredentialsImpl(CredentialsScope.GLOBAL, credId, credDescription, credName, secretBytes)

SystemCredentialsProvider.instance.store.addCredentials(Domain.global(), credentials)

// Uncomment if you want to delete the file
// boolean fileSuccessfullyDeleted =  new File(filePath).delete()