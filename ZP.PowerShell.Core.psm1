<#
Function ZP-NewObject
{
    [CmdletBinding(PositionalBinding = $False)]
    Param
    (
        [Parameter()][String]$Source,
        [Parameter()][String]$Message, 
        [Parameter()][String]$ZPObjectType,
        [Parameter()][Switch]$NoThrow
    )
    $ZPObject = [ZPObject]::new("ZP.Core", "", "ZP.Reserved")
    If ($ZPObject.ValidateZPObjectType($ZPObjectType))
    {
        Return [ZPObject]::new($Source,$Message,$ZPObjectType)
    } Else
    {
        $Exception = ZP-NewObject -Source ZP.Core -Message "Invalid ZPObject type." -ZPObjectType ZP.Exception.InvalidZPObjectTypeException
        If ($NoThrow)
        {
            Return $Exception
        } Else
        {
            Throw $Exception
        }
    }
}
Function ZP-WriteZPObject
{
    [CmdletBinding(PositionalBinding = $False)]
    Param
    (
        [Parameter(Position=0, ValueFromPipeline)][ZPObject]$ZPObject
    )
    Write-Output (Format-Table -Property Source, Message, ZPObjectType -InputObject $ZPObject)
}
#>
Function ZP-NewTempFile
{
    [CmdletBinding(PositionalBinding = $false)]
    Param (
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