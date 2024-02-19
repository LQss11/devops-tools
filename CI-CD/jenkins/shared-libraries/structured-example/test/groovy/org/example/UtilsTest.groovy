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
