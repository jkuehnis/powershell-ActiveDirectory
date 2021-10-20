#by J.Kühnis 25.11.2019

Import-Module ActiveDirectory

$OU1 = Get-ACl -Path 'AD:\OU=Sales,OU=UserAccounts,DC=FABRIKAM,DC=COM' |  Select-Object -ExpandProperty Access | select IdentityReference
$OU2 = Get-ACl -Path 'AD:\OU=Marketing,OU=UserAccounts,DC=FABRIKAM,DC=COM' |  Select-Object -ExpandProperty Access | select IdentityReference

Compare-Object $OU1 $OU2 -IncludeEqual
