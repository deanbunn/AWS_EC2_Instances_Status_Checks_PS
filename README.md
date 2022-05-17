## AWS EC2 Instances Status Checks 

A quick PowerShell script to check the status of AWS EC2 instances. 

### Scenario:

You have an EC2 instances that need to start once a day and perform some data processing tasks and then shutdown.

Designed to be run periodically through out the day, this script will check the current hour and start the system if it's powered off. If running it will make sure it doesn't run longer than 12 hours. 

### Required Setup

The AWS Tools for PowerShell on Windows module must be installed on the system.
```powershell
# Make sure the AWS PowerShell module is located in one of the module paths
# View Module Paths
$Env:PSModulePath
```

Check Version of AWS PowerShell Module
```powershell
# Check AWS PowerShell Version
Get-AWSPowerShellVerion
```

Configure the AWS credentials
```powershell
# Setup the default profie credentials to be used during calls. Only run if not already configured 
Set-AWSCredential -AccessKey NnNnNnNn -SecretKey NnNnNnNn -StoreAs default
```

Check AWS credentials
```powershell
# Check credentials
Get-AWSCredential-ListProfileDetail
```






