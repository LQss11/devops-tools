def call(String name) {
    def message = org.example.Utils.sayHello(name)
    echo message
}
