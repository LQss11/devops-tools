for (aSlave in hudson.model.Hudson.instance.slaves) 
{ println aSlave.name + "," + aSlave.getComputer().getJnlpMac() }