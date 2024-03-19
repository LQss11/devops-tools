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
                                [$class: 'DynamicReferenceParameter', 
                                    choiceType: 'ET_FORMATTED_HTML', 
                                    description: 'This param is toggled depending on the TOGGLE param', 
                                    name: 'PARAMEXAMPLE', 
                                    referencedParameters: 'TOGGLE', 
                                    script: 
                                        [$class: 'GroovyScript', 
                                        script: 'return["error"]', 
                                        script: [
                                            // Example Select
                                            // <select name="value" id="RELEASE_TYPE">
                                            // <option value="patch">patch</option>
                                            // <option value="minor">minor</option>
                                            // <option value="major">major</option>
                                            // </select>
                                            script: '''
                                                if (TOGGLE) {
                                                    return """
                                                <input name="value" id="PARAMEXAMPLE"  value="PARAMEXAMPLE">
                                                <img src="force/failed/load/image" style="display: none;" onerror='document.getElementById("PARAMEXAMPLE").closest(".jenkins-form-item").style.display=""'>
                                                """  
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