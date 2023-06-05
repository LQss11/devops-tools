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

// define private key
def jenkinsMasterKeyParameters = [
  description:  'Jenkins Master SSH Key',
  id:           'jenkins-master-key',
  secret:       '',
  userName:     'email@domain.com',
  key:          new BasicSSHUserPrivateKey.DirectEntryPrivateKeySource('''-----BEGIN OPENSSH PRIVATE KEY-----
Put your ssh key content here
-----END OPENSSH PRIVATE KEY-----''')
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
