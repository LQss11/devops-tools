import hudson.util.Secret

def secret = Secret.fromString("{AQAAABAAAAAQtldezykWOcFH9FHPNMAQ1B+Jr4AhGlo1BZrSTEafcC8=}")
println(secret.getPlainText())