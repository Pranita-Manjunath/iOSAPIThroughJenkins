pipeline{
    agent any
    stages{
        stage('Build') {
            steps {
                load "${WORKSPACE}/Jenkinsfile-vars.groovy"
                sh 'flutter build ios --release'
                sh 'xcodebuild -quiet build -workspace Runner.xcworkspace -scheme development -configuration Release-development archive -archivePath build/Runner.xcarchive'
                sh 'xcodebuild -exportArchive -archivePath build/Runner.xcarchive -exportPath build/Runner.ipa -exportOptionsPlist ExportOptions.plist -exportPath build//Users/zmo-mac-testlab-02/Desktop’
                }
            }
        }
}