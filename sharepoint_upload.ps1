param (
    [string]$siteUrl,
    [string]$target,
    [string]$source
)

Connect-PnPOnline -Url $siteUrl -ClientId 07fcde64-8964-4a76-9c00-e18825bf79ff -ClientSecret BZcTtNmCeO0RId+efXzNkljzhbP0Ak3fcQALdK6zOcY=

# Specify the path to the folder you want to upload
$SourcefolderPath = "$source"

$target="Documents/Jenkins_folder"

# Upload the zip file to SharePoint
Add-PnPFile -Path $SourcefolderPath -Folder $target
