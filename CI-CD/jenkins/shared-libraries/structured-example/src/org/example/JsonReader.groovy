package org.exampke

import groovy.json.JsonSlurper

class Bar {

    static String loadName(String key) {
        def json = new JsonSlurper().parse(Bar.getResourceAsStream("data.json"))
        return json.names[key]
    }

}