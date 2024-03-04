

package org.example

class Utils {
    static void main(String[] args) {
        envvars = sh(
            script: "printenv",
            returnStdout: true
        ).trim()
        println(envvars)
    }
}
