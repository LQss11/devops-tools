import groovy.yaml.YamlSlurper

/**
 * A class to read YAML files and display variables based on the specified application name.
 */
class YamlReader {
    /**
     * Main method to execute the YAML reading and variable display.
     * @param displayEnvVars Boolean indicating whether to display OS environment variables.
     */
    static void main(String[] args) {
        // Load YAML data from file
        def yaml = loadYamlFromFile("resources/data.yaml")

        // Get the application name from the environment variables
        def appName = System.getenv("APP_NAME")

        // Check if the APP_NAME environment variable exists
        if (!appName) {
            throw new IllegalArgumentException("❌ APP_NAME environment variable is required.")
        }

        // Check if the application name is valid
        if (yaml."$appName") {
            def app = yaml."$appName"
            // Check if the 'name' attribute exists for the specified application
            if (app && app.name) {
                println "========================================"
                println "  🚀 Variables for ${appName.capitalize()}:"
                println "========================================"
                // Display application variables
                app.each { key, value ->
                    println "  ⭐️ ${key.capitalize()}: ${value}"
                }
                println "========================================"
                println "  🌐 Environment Variables (${args.displayEnvVars}):"
                println "========================================"
                // Check if to display OS environment variables
                if (args.displayEnvVars) {
                    // Display all OS environment variables
                    System.getenv().each { key, value ->
                        println "  🌟 $key: $value"
                    }
                }
            } else {
                throw new IllegalArgumentException("❌ Required attributes 'app' and 'name' are missing for $appName.")
            }
        } else {
            throw new IllegalArgumentException("❌ Invalid value for APP_NAME: '$appName'.")
        }
    }

    /**
     * Loads YAML data from a file.
     * @param filePath The path to the YAML file.
     * @return Parsed YAML data.
     */
    static def loadYamlFromFile(String filePath) {
        def yamlString = new File(filePath).text
        new YamlSlurper().parseText(yamlString)
    }
}
