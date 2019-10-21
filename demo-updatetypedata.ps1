return "This is a demo script file"

#region viewing type data

#member types
Get-ChildItem -file | get-member -MemberType Properties

help get-typedata

#view the xml configuration file
psedit $pshome\types.ps1xml

$t = Get-TypeData system.io.fileinfo
$t
$t.DefaultDisplayPropertySet
$t.members
$t.members["versioninfo"]

#endregion

#region Extending the file object

help Update-TypeData

$p = @{
    TypeName = "system.io.fileinfo"
    MemberType = "ScriptProperty"
    MemberName = "Owner"
    Value = { (get-acl $this.fullname).owner } 
    Force = $True
}

Update-TypeData @p

#update the hash
$p.MemberName = "IsScript"
$p.value = { 
    $extensions=".ps1",".bat",".vbs",".cmd"
    if ($this.extension -in $extensions) {$True} else {$False}
 }

Update-TypeData @p

$p.MemberType = "AliasProperty"
$p.memberName = "Size"
$p.value = "length"

Update-TypeData @p

(Get-typedata system.io.fileinfo).members

Get-ChildItem -file | Select-Object -property name,owner,IsScript,size

#endregion

#region Using a module

Get-Module PSTypeExtensiontools -ListAvailable
# Find-module pstypeextensiontools
# Install-Module pstypeextensiontools

get-command -Module PSTypeExtensionTools

Get-PSTypeExtension system.io.fileinfo

help Add-PSTypeExtension

get-process | get-pstype | 
Add-PSTypeExtension -MemberType ScriptProperty -MemberName RunTime -Value {(Get-Date) - $this.starttime}

get-process | sort runtime -Descending | select -first 5 name,id,starttime,runtime 

#endregion

#or you can create ps1xml file to use
Help Export-PSTypeExtension -Examples