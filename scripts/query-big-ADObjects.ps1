<#
The Powershell AD-Modules have certain restrictions when it comes to querying large objects, this can be bypassed by ADSI Query.
Here an example how to read them and how to iterate on users of a group.
#>

#by J.Kühnis 13.03.2019
#example ADSI Query Powershell
$BigGroup = "someADGroupName"
$ADGroup1 = "someADGroup1"
$ADGroup2 = "someADGroup2"


$groupname = $BigGroup
$groupdsn = (Get-ADGroup $groupname).DistinguishedName
$group =&#91;adsi]”LDAP://$groupdsn” 
$groupmemebrs = $group.psbase.invoke("Members") | % {$_.GetType().InvokeMember("SamAccountName",'GetProperty',$null,$_,$null)}

$groupmemebrs | foreach {
    
    $usradgroups = GET-ADUser -Identity $_ –Properties MemberOf | Select-Object -ExpandProperty MemberOf | Get-ADGroup -Properties name | Select-Object name
    IF ($usradgroups.name -notContains $ADGroup1 -and $usradgroups.name -notContains $ADGroup2) {

        #User is not a Member of ADGroup1 &amp; ADGroup2

        }
        Else{
          #User is MemberOf ADGroup1 &amp; ADGroup2
        }
}
