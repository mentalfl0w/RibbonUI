[CmdletBinding()]
param (
    [string] $archiveName, [string] $APP_NAME, [string] $REPO_NAME
)

$scriptDir = $PSScriptRoot
$currentDir = Get-Location
Write-Host "currentDir" $currentDir
Write-Host "scriptDir" $scriptDir

function Main() {

    New-Item -ItemType Directory $archiveName
    # 拷贝exe
    Copy-Item D:\a\$REPO_NAME\$REPO_NAME\build\app\release\* $archiveName\ -Force -Recurse | Out-Null
    # 拷贝依赖
    windeployqt --qmldir . --plugindir $archiveName\plugins --no-translations --compiler-runtime $archiveName\$APP_NAME
    # 删除不必要的文件
    $excludeList = @("*.qmlc", "*.ilk", "*.exp", "*.lib", "*.pdb")
    Remove-Item -Path $archiveName -Include $excludeList -Recurse -Force
    # 打包zip
    Compress-Archive -Path $archiveName $archiveName'.zip'
}

if ($null -eq $archiveName || $null -eq $APP_NAME || $null -eq $REPO_NAME) {
    Write-Host "args missing, archiveName is" $archiveName ", APP_NAME is" $APP_NAME ", REPO_NAME is" $REPO_NAME
    return
}
Main
