# Detection Script
﻿# Script Author: Sagi Dahan
# Description: This script checks if there are any domain users (excluding specified ones) in the local administrators group.

$domainName = "YOURDOMAINNAME"
$excludedUsers = @("YOURDOMAINNAME\LOCALACCOUNTTOEXCLUDE1", "YOURDOMAINNAME\LocalAdmins") #Insert here any local user to exclude

# Get local administrators group members
$admins = net localgroup administrators | ForEach-Object { $_.ToString().Trim() -replace "`r|`n|`t", "" }

$domainUsersInAdmins = @()

foreach ($admin in $admins) {
    Write-Output "Checking admin: $admin"
    
    if ($admin -match "^$domainName\\") {
        Write-Output "$admin matches domain pattern"
        
        $isExcluded = $false
        foreach ($excludedUser in $excludedUsers) {
            if ($admin -eq $excludedUser) {
                Write-Output "Skipping excluded user $admin"
                $isExcluded = $true
                break
            }
        }
        
        if (-not $isExcluded) {
            Write-Output "Found domain user $admin in local administrators group"
            $domainUsersInAdmins += $admin
        }
    }
}

if ($domainUsersInAdmins.Count -gt 0) {
    $domainUsersString = $domainUsersInAdmins -join ", "
    Write-Output "Domain users in local administrators group: $domainUsersString"
    exit 1
} else {
    Write-Output "No domain user is a member of the local administrators group."
    exit 0
}
