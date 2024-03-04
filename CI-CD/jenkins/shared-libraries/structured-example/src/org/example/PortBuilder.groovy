package org.example

class Utils {
    static String PortBuilder(String environment, String moduleName, String projectName) {
        // Define the projects map
        def projectMap = [
            "project1": "2",
            "project2": "1",
        ]
        // Define the module/service map
        def moduleMap = [
            "module1": "00",
            "module2": "01",
            // Add more modules as needed
        ]
        
        // Determine the first char for project
        def firstChar = projectMap[projectName] ?: "9"
        // Determine the second character based on the environment
        def secondChar = environment == "dev" ? '0' :
                         environment == "uat" ? '1' :
                         environment == "prod" ? '2' :
                         environment == "local" ? '3' : '4'
        
        // Get the third and fourth characters based on the selected module
        def thirdAndFourthChars = moduleMap[moduleName] ?: "99" // Default to "99" if module not found
        // Construct and return the port
        return "2${secondChar}${thirdAndFourthChars}"
    }
}

// Example usage:
// def port = Utils.PortBuilder("uat", "module2")
// println port // Output: 2000 (assuming "module1" maps to '00')
