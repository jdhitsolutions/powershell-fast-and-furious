#demo auto completion

return "This is a walk through demo"

get-command Register-ArgumentCompleter
help Register-ArgumentCompleter -full

#add completion to a command

Register-ArgumentCompleter -CommandName Get-WinEvent -ParameterName Logname -ScriptBlock {
 param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

 (Get-Winevent -listlog "$wordtoComplete*").logname | Sort-Object |
 foreach-object {
                                                    # completion text,listitem text,result type,Tooltip
  [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
 }
}

# Get-WinEvent -Logname <tab>

Register-ArgumentCompleter -CommandName Get-Command -ParameterName Verb -ScriptBlock {
param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)
    
Get-Verb "$wordToComplete*" |
    ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($_.Verb, $_.Verb, 'ParameterValue', ("Group: $($_.Group)"))
    }
}


Function Get-ServiceStatus {
[cmdletbinding()]
Param([string]$Computername = $env:COMPUTERNAME)

$p = @{
Computername = $computername 
ClassName = "Win32_service"
Filter = "StartMode ='Auto' AND State<>'Running'" 

}
Get-Ciminstance @p
}

# Get-ServiceStatus -computername [tab]

Register-ArgumentCompleter -CommandName Get-ServiceStatus -ParameterName Computername -ScriptBlock {
param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)
    
Get-content c:\scripts\company.txt | where {$_ -like "*$wordtocomplete*"}  |
    ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($_.Trim(), $_.Trim(), 'ParameterValue', $_.trim())
    }
}

# Get-ServiceStatus -computername