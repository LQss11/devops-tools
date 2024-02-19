// Followed this https://github.com/darinpope/github-api-global-lib
// Traditional/Simple method 
// helloWorld("LQss", "Thursday")
def call(String name, String dayOfWeek) {
    sh "echo Hello ${name}. Today is ${dayOfWeek}."
}

// Another way to better implement params
// helloWorld(dayOfWeek:"Thursday", name:"LQss")
def call(Map config = [:]) {
    sh "echo Hello ${config.name}. Today is ${config.dayOfWeek}."
}