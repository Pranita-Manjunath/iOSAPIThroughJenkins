pipeline{
    agent any
    stages{
        stage('Build') {
            steps {
                load "${WORKSPACE}/Jenkinsfile-vars.groovy"
                sh 'flutter build ios --release'
                sh 'xcodebuild -quiet build -workspace $WORKSPACE/ios/Runner.xcworkspace -scheme Runner -sdk iphoneos -configuration Release clean archive -archivePath build/Runner.xcarchive'
                sh 'xcodebuild -exportArchive -archivePath build/Runner.xcarchive -exportPath build/artifacts/Runner.ipa -exportOptionsPlist ExportOptions.plist'
                }
            }
        stage('Upload to SharePoint') {
            steps {
                script {
                    sh 'cd ${WORKSPACE}/build && zip -r artifacts.zip artifacts'

                    // Define the SharePoint site URL, library name, and file path
                    def siteUrl = "https://medtronic.sharepoint.com/sites/PAACDevOps-CarelinkConnect"
                    def libraryName = "Documents"
                    def filePath = "${WORKSPACE}/build/artifacts.zip"

                    // Execute the PowerShell script
                    sh '''
                        pwsh -command "./scripts/sharepoint_upload.ps1 -siteUrl '$siteUrl' -target '$libraryName' -source '$filePath'"
                    '''
                }
            }
        }
    }
}
