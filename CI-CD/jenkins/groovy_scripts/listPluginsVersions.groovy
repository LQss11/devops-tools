//def plugins = jenkins.model.Jenkins.instance.getPluginManager().getPlugins()
//plugins.each {println "${it.getShortName()}: ${it.getVersion()}"}

println "Jenkins Instance : " + Jenkins.getInstance().getComputer('').getHostName() + " - " + Jenkins.getInstance().getRootUrl() 
println "Installed Plugins: "
println "=================="
Jenkins.instance.pluginManager.plugins.sort(false) { a, b -> a.getShortName().toLowerCase() <=> b.getShortName().toLowerCase()}.each { plugin ->
   println "${plugin.getShortName()}:${plugin.getVersion()} | ${plugin.getDisplayName()} "
}

println""
println "Plugins Dependency tree (...: dependencies; +++: dependants) :"
println "======================="
Jenkins.instance.pluginManager.plugins.sort(false) { a, b -> a.getShortName().toLowerCase() <=> b.getShortName().toLowerCase()}.each { plugin ->
   println "${plugin.getShortName()}:${plugin.getVersion()} | ${plugin.getDisplayName()} "
   println "+++ ${plugin.getDependants()}"
   println "... ${plugin.getDependencies()}"
   println ''
}
