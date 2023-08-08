import jenkins.model.*
import hudson.security.*

def instance = Jenkins.getInstance()
def strategy = new GlobalMatrixAuthorizationStrategy()
strategy.add(Jenkins.ADMINISTER, 'root')
instance.setAuthorizationStrategy(strategy)
