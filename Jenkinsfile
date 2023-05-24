pipeline{
    agent any
     parameters {
                string(name: 'SITE_URL', description: 'SharePoint Site URL')
                string(name: 'LIBRARY_NAME', description: 'Library Name')
                string(name: 'FILE_PATH', description: 'File Path')
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
                    sh 'cd ${WORKSPACE}/build && zip -r artifacts.zip artifacts'

                    // Define the SharePoint site URL, library name, and file path
                    def siteUrl = params.SITE_URL
                    def libraryName = params.LIBRARY_NAME
                    def filePath = params.FILE_PATH

                    // Execute the PowerShell script
                    sh '''
                        pwsh -Command "& {
                            $ErrorActionPreference = 'Stop'
                            $SiteUrl = '${siteUrl}'
                            $LibraryName = '${libraryName}'
                            $FilePath = '${filePath}'

                            Import-Module -Name SharePointPnPPowerShellOnline

                            # Connect to SharePoint Online
                            Connect-PnPOnline -Url $SiteUrl

                            # Upload the file to SharePoint
                            Add-PnPFile -Path $FilePath -Folder $LibraryName

                            Write-Host 'File uploaded successfully. URL:'
                            $List = Get-PnPList -Identity $LibraryName
                            $Item = Get-PnPListItem -List $List -Id $List.ItemCount
                            $Item.File.ServerRelativeUrl
                        }"
                    '''
                }
            }
        }
    }
}
