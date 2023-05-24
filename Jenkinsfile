pipeline{
    agent any
    environment {
            siteUrl = "https://medtronic.sharepoint.com/sites/PAACDevOps-CarelinkConnect"
            libraryName = "Documents"
            filePath = "${WORKSPACE}/build/artifacts/Runner.ipa"
            ZipfilePath = "${WORKSPACE}/zip/artifacts.zip"
    }
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

                    // Execute the PowerShell script
                    sh '''
                        echo "siteUrl: $siteUrl"
                        echo "libraryName: $libraryName"
                        echo "filePath: $filePath"
                        pwsh -command "./scripts/sharepoint_upload.ps1 -siteUrl '$siteUrl' -target '$libraryName' -source '$filePath' -zipPath 'ZipfilePath'"
                    '''
                }
            }
        }
    }
}
