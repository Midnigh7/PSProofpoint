if($ENV:BHProjectName)
{
    Deploy Module {
        By PSGalleryModule {
            FromSource $ENV:BHProjectName
            To PSGallery
            WithOptions @{
                ApiKey = $ENV:NugetApiKey
            }
        }
    }
}else{
    "Skipping deployment: To deploy, ensure that...`n" +
    "`t* ProjectName $ENV:BHProjectName`n" ##+
<#    "`t* ENV:BHModulePath is set (Current [$([bool]$env:BHPSModulePath)]: $ENV:BHPSModulePath)`n" +
    "`t* You are in a known build system (Current [$($env:BHBuildSystem -ne 'Unknown')]: $ENV:BHBuildSystem)`n" +
    "`t* You are committing to the master branch (Current [$($env:BHBranchName -eq "master")]: $ENV:BHBranchName) `n" +
    "`t* Your commit message includes !deploy (Current [$($env:BHCommitMessage -match '!deploy')]: $ENV:BHCommitMessage)" |
 #>
    #Write-Host

    }