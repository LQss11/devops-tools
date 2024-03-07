import static org.example.YamlReader.*

def call() {
    def yamlContent = libraryResource("data.yaml")
    readYamlFromString(yamlContent, this)
}