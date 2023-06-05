#!groovy

// imports
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

String filePath = "/root/.ssh/id_rsa"
String fileContents = new File(filePath).text

// parameters
def jenkinsMasterKeyParameters = [
  description:  'Jenkins Master SSH Key',
  id:           'jenkins-master-key',
  secret:       '',
  userName:     'saffes@spark-it.fr',
  key:          new BasicSSHUserPrivateKey.DirectEntryPrivateKeySource(fileContents)  
  //key: new BasicSSHUserPrivateKey.FileOnMasterPrivateKeySource(keyfile)
//   key:          new BasicSSHUserPrivateKey.DirectEntryPrivateKeySource('''-----BEGIN OPENSSH PRIVATE KEY-----
// b3BlbnN
// -----END OPENSSH PRIVATE KEY-----''')
]

// get Jenkins instance
Jenkins jenkins = Jenkins.getInstance()

// get credentials domain
def domain = Domain.global()

// get credentials store
def store = jenkins.getExtensionList('com.cloudbees.plugins.credentials.SystemCredentialsProvider')[0].getStore()

// define private key
def privateKey = new BasicSSHUserPrivateKey(
  CredentialsScope.GLOBAL,
  jenkinsMasterKeyParameters.id,
  jenkinsMasterKeyParameters.userName,
  jenkinsMasterKeyParameters.key,
  jenkinsMasterKeyParameters.secret,
  jenkinsMasterKeyParameters.description
)

// add credential to store
store.addCredentials(domain, privateKey)
// remove ssh key from container
boolean fileSuccessfullyDeleted =  new File(filePath).delete()  

// save to disk
jenkins.save()