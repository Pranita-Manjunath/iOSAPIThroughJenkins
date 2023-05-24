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

                    def siteUrl = "https://medtronic.sharepoint.com/sites/PAACDevOps-CarelinkConnect"
                    def libraryName = "Documents"
                    def filePath = "${WORKSPACE}/build/artifacts.zip"

                    // Execute the PowerShell script
                    powershell(returnStdout: true, script: '''
                        param(
                            [Parameter(Mandatory = $true)]
                            [String]$SiteUrl,
                            [Parameter(Mandatory = $true)]
                            [String]$LibraryName,
                            [Parameter(Mandatory = $true)]
                            [String]$FilePath
                        )

                        # Import the SharePoint PnP PowerShell module
                        Import-Module -Name SharePointPnPPowerShellOnline

                        # Connect to the SharePoint site
                        Connect-PnPOnline -Url $SiteUrl

                        # Get the SharePoint library
                        $library = Get-PnPList -Identity $LibraryName

                        # Create a new file in the library
                        $file = Add-PnPFile -Path $FilePath -Folder $library.RootFolder

                        # Get the uploaded file details
                        $fileDetails = Get-PnPListItem -List $library -Id $file.UniqueId -Fields "FileLeafRef", "EncodedAbsUrl"

                        # Display the uploaded file URL
                        Write-Host "File uploaded successfully. URL: $($fileDetails.EncodedAbsUrl)"

                        # Call the PowerShell function with the parameters
                        Upload-FileToSharePoint -SiteUrl $SiteUrl -LibraryName $LibraryName -FilePath $FilePath
                    ''', args: "-SiteUrl '$siteUrl' -LibraryName '$libraryName' -FilePath '$filePath'")

                }
            }
        }
    }
}
