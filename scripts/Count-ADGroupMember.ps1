<#
sample to use function:
Count-ADGroupMember -GroupName AnyGroupNameHere
#>


#by J.Kühnis 12.11.2019
Function Count-ADGroupMember {
    
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [string]$GroupName
    )


    #Get Data From AD-Group
    $groupname
    $groupdsn = (Get-ADGroup $groupname).DistinguishedName
    $group = [adsi]"LDAP://$groupdsn" 
    $groupmemebrs = $group.psbase.invoke("Members") | ForEach-Object { $_.GetType().InvokeMember("SamAccountName", 'GetProperty', $null, $_, $null) }
    $ADGroupMemberCount = $groupmemebrs.count
    return $ADGroupMemberCount
}
