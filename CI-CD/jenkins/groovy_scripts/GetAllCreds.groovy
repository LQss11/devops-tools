import com.cloudbees.plugins.credentials.Credentials


Set<Credentials> allCredentials = new HashSet<Credentials>();


def creds = com.cloudbees.plugins.credentials.CredentialsProvider.lookupCredentials(
      com.cloudbees.plugins.credentials.Credentials.class
);


allCredentials.addAll(creds)


Jenkins.instance.getAllItems(com.cloudbees.hudson.plugins.folder.Folder.class).each{ f ->
 creds = com.cloudbees.plugins.credentials.CredentialsProvider.lookupCredentials(
      com.cloudbees.plugins.credentials.Credentials.class, f)
  allCredentials.addAll(creds)

}


for (c in allCredentials) {
  println(c.id)
  //   println(c.getProperties().toString())
  if (c.properties.content) {
    println("   Content: " + c.getContent())
  }       
  if (c.properties.username) {
    println("   description: " + c.description)
  }
  if (c.properties.username) {
    println("   username: " + c.username)
  }
  if (c.properties.password) {
    println("   password: " + c.password)
  }
  if (c.properties.passphrase) {
    println("   passphrase: " + c.passphrase)
  }
  if (c.properties.secret) {
    println("   secret: " + c.secret)
  }
  if (c.properties.privateKeySource) {
    println("   privateKey: " + c.getPrivateKey())
  }
  println("")
}
