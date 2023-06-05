import jenkins.model.*
import hudson.security.*

def env = System.getenv()
def instance = Jenkins.getInstance()

// Initial username and password using env variables
println '--> Initial username and password using env variables'
def hudsonRealm = new HudsonPrivateSecurityRealm(false)
hudsonRealm.createAccount(env.JENKINS_USER, env.JENKINS_PASS)
instance.setSecurityRealm(hudsonRealm)

// associate the created user to become admin
println '--> Associate the created user to become admin'
def strategy1 = new GlobalMatrixAuthorizationStrategy()
strategy1.add(Jenkins.ADMINISTER, env.JENKINS_USER)
instance.setAuthorizationStrategy(strategy1)

// logged-in users can do anything
println '--> Checking logged-in users can do anything'
def strategy2 = new hudson.security.FullControlOnceLoggedInAuthorizationStrategy()
strategy2.setAllowAnonymousRead(false)
instance.setAuthorizationStrategy(strategy2)

// save current Jenkins state to disk
println '--> Saving instance'
instance.save()

// Set the default URL
println '--> Setting default URL'
def jlc = JenkinsLocationConfiguration.get()
jlc.setUrl('http://localhost:8080/')
jlc.save()
