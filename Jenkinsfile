pipeline{
    agent any
    stages{
        stage('Build') {
            steps {
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