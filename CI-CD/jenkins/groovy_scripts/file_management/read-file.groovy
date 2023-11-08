String filePath = '/root/.ssh/id_rsa'

File propertiesFile = new File(filePath)
println(propertiesFile.getText())