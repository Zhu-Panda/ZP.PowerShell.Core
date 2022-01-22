Function ZP-NewTempFile
{
    [CmdletBinding(PositionalBinding = $false)]
    Param
    (
        [Parameter()][String]$Name,
        [Parameter()][String]$Identifier
    )
    $UnixTimestamp = Get-Date -UFormat "%s"
    $Guid = (New-Guid) -Replace "-", ""
    $TempFileName = -Join ([IO.Path]::GetTempPath(), $Name, "-", $Identifier, "-", $UnixTimestamp, "-", $Guid, ".tmp")
    Return [IO.FileInfo]::new($TempFileName)
}
Function ZP-RemoveTempFile
{
    [CmdletBinding(PositionalBinding = $False)]
    Param
    (
        [Parameter(ValueFromPipeline)][IO.FileInfo]$TempFile
    )
    $TempFile.Delete()
}
