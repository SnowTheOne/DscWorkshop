Task Deploy {

    Write-Host "Starting deployment with files inside '$ProjectPath'"
    $artifactsPath = "$projectPath\$buildOutput\CompressedArtifacts"
    if (-not (Test-Path -Path $artifactsPath)) {
        mkdir -Path $artifactsPath | Out-Null
    }

    Compress-Archive -Path $buildOutput\MOF -DestinationPath "$projectPath\$buildOutput\CompressedArtifacts\MOF.zip" -Force
    Compress-Archive -Path $buildOutput\MetaMOF -DestinationPath "$projectPath\$buildOutput\CompressedArtifacts\MetaMOF.zip" -Force

    if ($env:BHBuildSystem -eq 'AppVeyor') {
        Push-AppVeyorArtifact "$projectPath\$buildOutput\CompressedArtifacts\MOF.zip" -FileName MOF.zip -DeploymentName MOF
        Push-AppVeyorArtifact "$projectPath\$buildOutput\CompressedArtifacts\MetaMOF.zip" -FileName MetaMOF.zip -DeploymentName MetaMOF
    }
    
}