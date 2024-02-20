import org.example

def call() {
    String name = JsonReader.loadName("foo")
    echo "Hello, ${name}!"
}