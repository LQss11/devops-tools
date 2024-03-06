# Shared Libraries
# TEST
```sh
docker run -it --rm -v ${pwd}:/app -w /app groovy:alpine sh -c "groovy script.groovy"
```
# Create shared library
Based on the [jenkins shared libraries documentation](https://www.jenkins.io/doc/book/pipeline/shared-libraries/) in order to create and reference shared libraries you have to do the following steps:
1. go to <JENKINS_URL>/manage/configure
2. in the **Global Pipeline Libraries** section you must set the right parameters when adding shared libraries
3. The directory path of the library must contain either **src**, **vars** or both directories

The difference between scripts in **vars** and **src** is:
- **vars:** define reusable functions or steps that can be directly called from pipelines, and are automatically made available without requiring explicit imports or references.
- **src:** used to organize additional source code or resources for the shared library's implementation, but not meant to be directly called from pipelines.

# Reference shared library in a pipeline
once shared library has been created under **vars** you can reference it like this:
```groovy
// Shared library with utils name must be defined
@Library('utils') _

pipeline {
    agent any
    stages {
        stage('Stage 1') {
            steps {
                script{
                    // filePathDotSeperated.filename.methodName()
                    log.info 'Starting'
                    log.warning 'Nothing to do!'
                }

            }
        }
    }
}
```

# Support packages
If you want to use Grape to import a library like XMLSlurper, which is typically included with Groovy, you can do so with the following @Grab annotation:
```groovy
@Grab(group='org.codehaus.groovy', module='groovy', version='3.0.9')
```