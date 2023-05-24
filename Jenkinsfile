pipeline{
    agent any
    stages{
        stage('Build') {
            steps {
                load "${WORKSPACE}/Jenkinsfile-vars.groovy"
                sh 'flutter build ios --release'
                sh 'xcodebuild -quiet build -workspace $WORKSPACE/ios/Runner.xcworkspace -scheme Runner -sdk iphoneos -configuration Release clean archive -archivePath build/Runner.xcarchive'
                sh 'xcodebuild -exportArchive -archivePath build/Runner.xcarchive -exportPath build/Users/zmo-mac-testlab-02/Desktop/Runner.ipa -exportOptionsPlist ExportOptions.plist'
                }
            }
        stage('Upload Artifacts to SharePoint') {
              steps {
                sh 'cp /Users/zmo-mac-testlab-02/Downloads/Desktop Documents/Jenkins Folder'
              }
        }
    }
}
