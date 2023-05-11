pipeline{
    agent any
    stages{
        stage('Build') {
            steps {
                dir('./ios') {
                    sh "pod install"
                }
            }
        }
    }
}