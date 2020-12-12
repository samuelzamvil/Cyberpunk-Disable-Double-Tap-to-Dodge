param (
    [parameter(Mandatory=$true)]
    $InstallPath,
    $DodgeKey = 'Alt'
)
# Set file paths
$inputContexts = "$InstallPath\r6\config\inputContexts.xml"
$inputUserMappings = "$InstallPath\r6\config\inputUserMappings.xml"
Write-Host "Cyberpunk install path set to ""$InstallPath""" -ForegroundColor Yellow -BackgroundColor Black
Write-Host "DodgeKey set to $DodgeKey" -ForegroundColor Yellow -BackgroundColor Black
# Create backups
if (!(Test-Path "$inputUserMappings.bak")) {
    Copy-Item "$inputUserMappings" "$inputUserMappings.bak"
}
if (!(Test-Path "$inputContexts.bak")) {
    Copy-Item "$inputContexts" "$inputContexts.bak"
}

$NewinputUserMappings = ""
$NewinputContexts = ""

# Read in inputUserMappings.xml and enumerate the file line by line
Get-Content "$inputUserMappings.bak" | ForEach-Object {
    # Set a counter so we can Ignore a couple of the lines with 'button id="IK_LControl"' and 'button id="IK_C"'
    # but not all of them.
    $PassCounter++
    if ($_ -cmatch '<mapping name="Dodge_Button" type="Button" >' ) {
        $NewinputUserMappings += "$_`n"
        $NewinputUserMappings += "		<button id=`"IK_$DodgeKey`" />`n"
        $PassCounter = -5
    }
    elseif ($PassCounter -eq -3 -or $PassCounter -eq -2 ) {
    }
    else {
        $NewinputUserMappings += "$_`n"
    }

}
Out-File -FilePath $inputUserMappings -InputObject $NewinputUserMappings -Force -Verbose

Get-Content "$inputContexts.bak" | ForEach-Object { 
    if ($_ -cmatch 'action="Dodge" count="2"' ) {
        $NewinputContexts += $_ -replace 'action="Dodge" count="2"','action="Dodge" count="1"'
        $NewinputContexts += "`n"
    }
    else {
        $NewinputContexts += "$_`n"
    }
}
Out-File -FilePath $inputContexts -InputObject $NewinputContexts -Force -Verbose