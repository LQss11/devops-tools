package org.example

@Grab('org.yaml:snakeyaml:1.29')
import org.yaml.snakeyaml.Yaml

class YamlReader {
    static void readYamlFromString(String yamlString, def dsl) {
        try {
            def yaml = new Yaml().load(yamlString)

            def appName = dsl.env.MODULE // Default to "app1" if MODULE is not set
            // def appName = System.getenv("MODULE") ?: "app1" // Default to "app1" if MODULE is not set

            if (!yaml) {
                throw new Exception("YAML file is empty or invalid.")
            }

            if (!yaml.containsKey(appName)) {
                throw new Exception("Application '$appName' not found in YAML.")
            }

            def app = yaml[appName]
            def output = ""
            output += "========================================\n"
            output += "  🚀 Variables for ${appName.capitalize()}:\n"
            output += "========================================\n"
            app.each { key, value ->
                output += "  ⭐️ ${key.capitalize()}: ${value}\n"
            }
            output += "========================================\n"
            output += "  🌐 Environment Variables:\n"
            output += "========================================\n"
            System.getenv().each { key, value ->
                output += "  🌟 $key: $value\n"
            }
            dsl.echo(output)
        } catch (Exception e) {
            dsl.error("❌ Error: ${e.message}")
        }
    }
}