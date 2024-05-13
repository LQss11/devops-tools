pipeline {
    agent any
        stages {
            stage('Parameters'){
                steps {
                    script {
                    properties([
                            parameters([
                                [$class: 'DynamicReferenceParameter', 
                                    choiceType: 'ET_FORMATTED_HTML', 
                                    description: '', 
                                    name: 'TOGGLE', 
                                    script: 
                                        [$class: 'GroovyScript', 
                                        script: 'return["error"]', 
                                        script: [
                                            script: '''
                                                return "<input name='value' type='checkbox' checked='checked'>"
                                            '''
                                            ]
                                        ]
                                ],
                                choice(name: 'PROJECT', choices: ['app1', 'app2', 'app3'], description: 'Select the project Name'),
                                [$class: 'DynamicReferenceParameter', 
                                    choiceType: 'ET_FORMATTED_HTML', 
                                    description: 'This param is toggled depending on the TOGGLE param', 
                                    name: 'PARAMEXAMPLE', 
                                    referencedParameters: 'PROJECT, TOGGLE', // Reference multiple params 
                                    script: 
                                        [$class: 'GroovyScript', 
                                        script: 'return["error"]', 
                                        script: [
                                            script: '''
                                                if (TOGGLE) {
                                                    if (PROJECT) {
                                                        def options = "curl -s -X GET http://localhost:5000/v2/projectx/${PROJECT}/tags/list".execute().text.trim()
                                                        def tagsList = new groovy.json.JsonSlurper().parseText(options).tags
                                                        def optionsHtml = "<select name='value' id='PARAMEXAMPLE'>"
                                                        tagsList.each { option ->
                                                            optionsHtml += "<option value='${option}'>${option}</option>"
                                                        }
                                                        optionsHtml += "</select>"
                                                        return """
                                                            ${optionsHtml}
                                                            <img src="force/failed/load/image" style="display: none;" onerror='document.getElementById("PARAMEXAMPLE").closest(".jenkins-form-item").style.display=""'>
                                                        """  
                                                    }
                                                } else {
                                                return """
                                                    <input name="value" id="PARAMEXAMPLE"  value="PARAMEXAMPLE">
                                                    <img src="force/failed/load/image" style="display: none;" onerror='document.getElementById("PARAMEXAMPLE").closest(".jenkins-form-item").style.display="none"'>
                                                """ 
                                                }
                                            '''
                                            ]
                                        ]
                                ]
                            ])
                        ])
                    }
                }
            }
        }   
}