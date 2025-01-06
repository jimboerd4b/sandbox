$Environment = "https://org4b81e74d.crm4.dynamics.com"
$SolutionName = "TestPipelines"
$AppName = "jb_testpipeline_54716"
$Version= "1.2"
$Path = "C:\Temp\"
$SourcePathGit = "C:\Source\sandbox\TestPipelines\"

#$FileManaged = $Path + $SolutionName + "_Managed.zip"
$FileUnManaged = $Path + $SolutionName + "_Unmanaged.zip"
$Folder = $Path + $SolutionName + "_Unpacked"

Remove-Item $Folder -Recurse

pac auth select --name Prominent

#pac solution online-version --solution-name $SolutionName --solution-version $Version -env $Environment
#pac solution export --path $FileManaged --name $SolutionName --managed -env $Environment -ow
pac solution export --path $FileUnManaged --name $SolutionName  -env $Environment -ow
pac solution unpack --zipfile $FileUnManaged --folder $Folder -p Unmanaged

pac canvas unpack --msapp $Folder'\CanvasApps\'$AppName'_DocumentUri.msapp' --sources $SourcePathGit

#Copy-Item -Path $Folder\CanvasApps\$AppName\ -Destination $SourcePath -Recurse

Set-Location -Path $SourcePathGit
git add --all
git commit -m "Version: $Version"
git push -q