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
                /* script{
                    archiveArtifacts artifacts: 'artifacts', fingerprint: true, allowEmptyArchive: true
                    withCredentials([usernamePassword(credentialsId: 'https://medtronic.sharepoint.com/sites/PAACDevOps-CarelinkConnect', usernameVariable: '07fcde64-8964-4a76-9c00-e18825bf79ff', passwordVariable: 'BZcTtNmCeO0RId+efXzNkljzhbP0Ak3fcQALdK6zOcY=')]) {
                                    sh '''
                                        export UPLOAD_TYPE=multiple
                                        export FOLDER_PATH=${WORKSPACE}/artifacts

                                    '''
                                    env.LOG_FILES_URL="Pipeline Logs: ${SP_URL}/${UPLOAD_PATH.replaceAll(' ', '%20')}${BRANCH_NAME_NORMALIZED}/${BUILD_ID} <br>"
                                }
                } */
                    sh '''
                        export ARTIFACT_PATH=${WORKSPACE}/build/artifacts
                        export SHAREPOINT_URL=https:https://medtronic.sharepoint.com/sites/PAACDevOps-CarelinkConnect
                        export LIBRARY_NAME=Document/Jenkins_folder

                        # Create a folder in the SharePoint document library
                            FOLDER_NAME="NewFolderName"
                            FOLDER_URL=$(curl -X POST -u username:password -H "Content-Type: application/json" -d '{"__metadata":{"type":"SP.Folder"},"ServerRelativeUrl":"/sites/your-site/'"$LIBRARY_NAME"'/'"$FOLDER_NAME"'"}}' "$SHAREPOINT_URL/_api/web/GetFolderByServerRelativeUrl('/sites/your-site/$LIBRARY_NAME')/folders" | jq -r '.d.ServerRelativeUrl')

                            # Upload artifacts to the SharePoint folder
                            find /Users/zmo-mac-testlab-02/.jenkins/workspace/iOS_BUILD_THROUGH_PIPELINE/build/artifacts -type f -exec curl -X PUT -u manjup2@medtronic.com:BlackBerry-16 --data-binary "@{}" "https://medtronic.sharepoint.com/sites/PAACDevOps-CarelinkConnect/_api/web/GetFolderByServerRelativeUrl('$FOLDER_URL')/Files/add?url={}&overwrite=true";                '''

              }
        }
    }
}
