# Remediation Script
﻿# Script Author: Sagi Dahan
# Description: This script removes domain users (excluding specified ones) from the local administrators group.

$domainName = "YOURDOMAINNAME"  # Replace with your domain name
$excludedUsers = @("YOURDOMAINNAME\LOCALACCOUNTTOEXCLUDE1", "YOURDOMAINNAME\LocalAdmins") #Insert here any local user to exclude

# Get local administrators group members
$admins = net localgroup administrators | ForEach-Object { $_.ToString().Trim() -replace "`r|`n|`t", "" }

foreach ($admin in $admins) {
    if ($admin -match "^$domainName\\") {
        # Check if the user is in the exclusion list
        $isExcluded = $false
        foreach ($excludedUser in $excludedUsers) {
            if ($admin -eq $excludedUser) {
                Write-Output "Skipping excluded user $admin"
                $isExcluded = $true
                break
            }
        }
        
        if (-not $isExcluded) {
            Write-Output "Attempting to remove $admin from local administrators group"
            try {
                $arguments = "localgroup administrators `"$admin`" /delete"
                Write-Output "Executing command: net $arguments"
                Start-Process net -ArgumentList $arguments -NoNewWindow -Wait
                Write-Output "Successfully removed $admin"
            } catch {
                Write-Output "Failed to remove $admin : $($_.Exception.Message)"
            }
        }
    }
}

# Verify remediation
$admins = net localgroup administrators | ForEach-Object { $_.ToString().Trim() -replace "`r|`n|`t", "" }
$isDomainUserAdmin = $false

foreach ($admin in $admins) {
    if ($admin -match "^$domainName\\") {
        # Check if the user is in the exclusion list
        $isExcluded = $false
        foreach ($excludedUser in $excludedUsers) {
            if ($admin -eq $excludedUser) {
                $isExcluded = $true
                break
            }
        }
        
        if (-not $isExcluded) {
            Write-Output "$admin is still in the administrators group"
            $isDomainUserAdmin = $true
        }
    }
}

if ($isDomainUserAdmin) {
    Write-Output "Remediation failed. Domain user is still a member of the local administrators group."
    exit 1  # Non-zero exit code if remediation failed
} else {
    Write-Output "Remediation successful. Domain user has been removed from the local administrators group."
    exit 0  # Zero exit code if remediation was successful
}
