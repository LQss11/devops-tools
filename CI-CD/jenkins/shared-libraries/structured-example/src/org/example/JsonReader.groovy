import groovy.json.JsonSlurper

class JsonReader {
    static void main(String[] args) {
        def json = loadJsonFromFile("resources/data.json")
        // Access the JSON data as needed
        println "JSON content:"
        println json
    }

    static def loadJsonFromFile(String filePath) {
        def jsonString = new File(filePath).text
        new JsonSlurper().parseText(jsonString)
        
    }
}
