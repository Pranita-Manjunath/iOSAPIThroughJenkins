pipeline{
    agent any
    stages{
        stage('Build') {
            steps {
                sh "flutter clean"
                sh "flutter pub get"
                dir('./ios') {
                    sh "pod install"
                }
            }
        }
    }
}