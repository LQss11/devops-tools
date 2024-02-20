def call(String name) {
    def message = org.example.Utils.sayHello(name)
    echo message
}

// another way to import
// import static com.example.Utils.*
// def call(String name) {
//     def message = sayHello(name)
//     echo message
// }
