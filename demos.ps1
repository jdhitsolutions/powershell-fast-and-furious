return "This is a guided demo."

<#
these tricks and techniques are intended to be used 
in an interactive PowerShell sessions, not necessarily
in PowerShell scripts and modules.
#>

#region Push/Pop paths

help pushd
help popd

pushd
cd \
popd

cd \work
pushd -StackName a 
cd c:\scripts
pushd -StackName b
popd -s a
popd -StackName b

#or use set-location

cd -StackName a
#stacks are not persistent
get-location -StackName a

cd ~
pushd -StackName c
get-location -StackName c
cd windows
pushd -StackName c

#but only the last one can really be used
cd \

get-location -StackName c
popd -s c
get-location -StackName c

#endregion

#region Console aliases

gcm -noun alias

#make PowerShell easier for yourself
set-alias aka get-alias
aka

#works for any command line executable
get-alias np
np

get-alias ff | select *

#endregion

#region parenthetical expressions

#read cmdlet help and keep it updated
help get-service -param computername

#explicit but extra typing
$c = get-content .\computers.txt
get-service bits -ComputerName $c | select name,status,machinename

#implicit
#assumes a clean text file
get-service bits -Comp (cat .\computers.txt) | select name,status,machinename

#endregion


#region Custom type extensions

psedit .\demo-updatetypedata.ps1

#endregion

#region Autocompleters
psedit .\Demo-AutoCompleter.ps1

#endregion

#region Using PSReadline

#You made need to update the module and be sure to read help
find-module psreadline
#this works best in the console
get-command -module psreadline
Get-PSReadLineOption

#demo history searching

#demo key handlers
Get-PSReadLineKeyHandler

#define your own
Set-PSReadlineKeyHandler -key F12 -Function CaptureScreen

#define custom commands
$p = @{
key = "Ctrl+h" 
BriefDescription = "Open PSReadlineHistory" 
Description = "View PSReadline history file with the associated application. [$($env:username)]" 
ScriptBlock = {
#open the history file with the associated application for .txt files, probably Notepad.
Invoke-Item -Path $(Get-PSReadlineOption).HistorySavePath
 }
}

Set-PSReadlineKeyHandler @p


#some of my handles
psedit .\mypsreadeline.ps1 
#endregion