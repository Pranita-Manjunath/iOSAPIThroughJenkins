pipeline{
    agent any
    stages{
        stage('Build') {
            steps {
                checkout scm
                echo "Build stage"
                sh "flutter clean"
                sh "flutter pub get"
                dir('./ios') {
                    sh "pod install"
                }
            }
        }
    }
}