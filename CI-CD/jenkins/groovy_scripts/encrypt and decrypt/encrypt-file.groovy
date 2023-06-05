import hudson.util.Secret
String filePath = '/root/.ssh/id_rsa'
File propertiesFile = new File(filePath)

def secret = Secret.fromString(propertiesFile.getText())
println(secret.getEncryptedValue())