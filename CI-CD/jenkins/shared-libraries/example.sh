#!/bin/bash

# Create directory
mkdir -p structured-example/src/org/example
mkdir -p structured-example/test/groovy/org/example
mkdir -p structured-example/vars
mkdir -p structured-example/resources

# Create source files
cat <<EOF > structured-example/src/org/example/Utils.groovy
package org.example

class Utils {
    static String sayHello(String name) {
        "Hello, \${name}!"
    }
}
EOF

cat <<EOF > structured-example/test/groovy/org/example/UtilsTest.groovy
package org.example

import spock.lang.Specification

class UtilsTest extends Specification {
    def "test sayHello method"() {
        given:
        def utils = new Utils()

        expect:
        utils.sayHello("Alice") == "Hello, Alice!"
    }
}
EOF

cat <<EOF > structured-example/vars/greeting.groovy
def call(String name) {
    def message = org.example.Utils.sayHello(name)
    echo message
}
EOF

# Create resource file
cat <<EOF > structured-example/resources/messages.properties
greeting.message=Hello, {0}!
EOF

echo "Directory structure and files created successfully in structured-example directory."
