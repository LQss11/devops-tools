def call() {
    def envvars = sh(
        script: "printenv",
        returnStdout: true
    )
    envvars.trim().split('\n').each { line ->
        def keyValue = line.split('=')
        if (keyValue.size() == 2) {
            def key = keyValue[0]
            def value = keyValue[1]
            println("key=${key} and value=${value}")
        }
    }    
}