import hudson.util.Secret

def secret = Secret.fromString("Your Password")
println(secret.getEncryptedValue())