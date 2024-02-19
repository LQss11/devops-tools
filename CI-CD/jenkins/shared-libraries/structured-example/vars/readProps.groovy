def call(String name) {
    def message = readProperties('default.properties')['jenkins.url']
    echo message
}