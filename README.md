# Detect-And-Remove-Domain-Local-Admin-User

## Overview

This repository contains two PowerShell scripts designed for managing domain users in the local administrators group on Windows machines. These scripts designed to be implemented through Microsoft Intune as Detection and Remediation scripts.

## Detection Script

The detection script checks if there are any domain users (excluding specified ones) in the local administrators group.

## Remediation Script
The remediation script removes domain users (excluding specified ones) from the local administrators group.

### Usage

1. Replace `YOURDOMAINNAME` with your actual domain name.
2. Update the `$excludedUsers` array with the users you want to exclude from the check.
3. Deploy the script through Intune as a detection script.

```powershell
# Detection & Remediation Scripts
$domainName = "YOURDOMAINNAME"
$excludedUsers = @("YOURDOMAINNAME\LOCALACCOUNTTOEXCLUDE1", "YOURDOMAINNAME\LocalAdmins")
```

## Deployment through Intune

1. **Save the Script:**
   - Save the PowerShell scripts as `DetectionScript.ps1` & `RemediationScript.ps1`.

2. **Log in to the Intune Admin Center:**
   - Go to the Microsoft Endpoint Manager admin center.

3. **Create a New Script:**
   - Navigate to `Devices` > `Scripts and remediations` > `Create`.

4. **Upload the Script:**
   - Select `Create` and choose `Windows 10 and later` as the platform.
   - Give the script a name and description.
   - Upload the `DetectionScript.ps1` script file to 'Detection script file'.
   - Upload the `RemediationScript.ps1` script file to 'Remediation script file'.

5. **Configure Script Settings:**
   - Set the `Script settings` as per your requirements.
   - Ensure `Run this script using the logged on credentials` is set to `No`.

6. **Assign the Script:**
   - Assign the script to the appropriate device groups.

7. **Monitor Script Deployment:**
   - Monitor the deployment status through the Intune admin center.

## Notes

- Ensure the scripts are tested in a controlled environment before deployment.
- Review the exclusion list periodically to ensure it is up to date.

## Disclaimer

This script is provided "as is" without any warranty of any kind, either express or implied, including but not limited to the implied warranties of merchantability and fitness for a particular purpose. The author is not responsible for any damage or issues that may arise from using this script. Use at your own risk.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.


## Author

**Sagi Dahan**

- GitHub: [github.com/sagid654](https://github.com/sagid654)
- LinkedIn: [linkedin.com/in/sagidahan](https://www.linkedin.com/in/sagidahan/)

For any inquiries or further information, please contact me through GitHub or LinkedIn.

Thank you for using this project. Your feedback and contributions are highly appreciated!
