#!groovy

import com.cloudbees.jenkins.plugins.sshcredentials.impl.*
import com.cloudbees.plugins.credentials.*
import com.cloudbees.plugins.credentials.common.*
import com.cloudbees.plugins.credentials.domains.Domain
import com.cloudbees.plugins.credentials.impl.*
import hudson.util.Secret
import java.nio.file.Files
import jenkins.model.Jenkins
import net.sf.json.JSONObject
import org.jenkinsci.plugins.plaincredentials.impl.*

String filePath = '/root/.ssh/id_rsa'
String fileContents = new File(filePath).text

// define private key
def jenkinsMasterKeyParameters = [
  description:  'Jenkins Master SSH Key',
  id:           'jenkins-master-key',
  secret:       '',
  userName:     'email@domain.com',
  key:          new BasicSSHUserPrivateKey.DirectEntryPrivateKeySource(fileContents)
]

def privateKey = new BasicSSHUserPrivateKey(
  CredentialsScope.GLOBAL,
  jenkinsMasterKeyParameters.id,
  jenkinsMasterKeyParameters.userName,
  jenkinsMasterKeyParameters.key,
  jenkinsMasterKeyParameters.secret,
  jenkinsMasterKeyParameters.description
)

SystemCredentialsProvider.getInstance().getStore().addCredentials(Domain.global(), privateKey)

// Uncomment if you want to delete the file
// boolean fileSuccessfullyDeleted =  new File(filePath).delete()