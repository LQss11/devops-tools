@Grab('org.yaml:snakeyaml:1.29')
import org.yaml.snakeyaml.Yaml

class YamlReader {
    static void main(String[] args) {
        def yaml = loadYamlFromFile("resources/data.yaml")

        def appName = System.getenv("APP_NAME")

        if (!appName) {
            throw new IllegalArgumentException("❌ APP_NAME environment variable is required.")
        }

        if (yaml."$appName") {
            def app = yaml."$appName"
            if (app && app.name) {
                println "========================================"
                println "  🚀 Variables for ${appName.capitalize()}:"
                println "========================================"
                app.each { key, value ->
                    println "  ⭐️ ${key.capitalize()}: ${value}"
                }
                println "========================================"
                println "  🌐 Environment Variables:"
                println "========================================"
                System.getenv().each { key, value ->
                    println "  🌟 $key: $value"
                }
            } else {
                throw new IllegalArgumentException("❌ Required attributes 'app' and 'name' are missing for $appName.")
            }
        } else {
            throw new IllegalArgumentException("❌ Invalid value for APP_NAME.")
        }
    }

    static def loadYamlFromFile(String filePath) {
        def yamlString = new File(filePath).text
        new Yaml().load(yamlString)
    }
}
