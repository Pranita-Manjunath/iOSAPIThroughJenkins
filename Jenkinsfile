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
        stage('Upload Artifacts to SharePoint') {
              steps {
                sh '''
                    export ARTIFACT_PATH= ${WORKSPACE}/build/artifacts/Runner.ipa
                    export SHAREPOINT_URL=https:https://medtronic.sharepoint.com/sites/PAACDevOps-CarelinkConnect
                    export LIBRARY_NAME=Document/Jenkins_folder

                    # Create a folder in the SharePoint document library
                    FOLDER_URL=$(curl -X POST -u username:password -H "Content-Type: application/json" -d '{"__metadata":{"type":"SP.Folder"},"ServerRelativeUrl":"/sites/your-site/'"$LIBRARY_NAME"'/NewFolderName"}}' "$SHAREPOINT_URL/_api/web/GetFolderByServerRelativeUrl('/sites/your-site/$LIBRARY_NAME')/folders" | jq -r '.d.ServerRelativeUrl')

                    # Upload artifacts to the SharePoint folder
                    find "$ARTIFACT_PATH" -type f -exec curl -X PUT -u username:password --data-binary @{} "$SHAREPOINT_URL/_api/web/GetFileByServerRelativeUrl('$FOLDER_URL' + "/{}")" \;
                '''

              }
        }
    }
}
