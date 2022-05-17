<#
    Script: AWS_EC2_Instances_Status_Checks.ps1
    Author: Dean Bunn
    Edited: 2022-05-17
#>

#Import AWS Module
Import-Module AWSPowerShell;

#Set Default Region
Set-DefaultAWSRegion -Region us-west-2;

#Current Date Time
$dtCrnt = (Get-Date);

#Check EC2 Instances (Listed by Instance IDs in Text File)
foreach($ec2InstID in (Get-Content -Path .\ec2_instance_ids.txt))
{

    #Check Submitted EC2 Instance ID from File
    if([string]::IsNullOrEmpty($ec2InstID) -eq $false)
    {

        #Pull Specific EC2 Instance Status
        [string]$ec2InstStatus = (Get-EC2InstanceStatus -InstanceId $ec2InstID -IncludeAllInstance $true).InstanceState.Name.Value;

        #Check Returned Status
        if([string]::IsNullOrEmpty($ec2InstStatus) -eq $false)
        {

            #Check Instance Status (possible options: pending,running,stopping,stopped,shutting-down)
            #Start Systems at Midnight. Stop Long Running Systems
            if($ec2InstStatus -eq "stopped" -and $dtCrnt.Hour -eq 0)
            {
                Start-EC2Instance -InstanceId $ec2InstID;
            }
            elseif($ec2InstStatus -eq "running")
            {

                #Check StartUp time and Compare to Current Time
                [datetime]$dtStartUp = (Get-EC2Instance -InstanceId $ec2InstID).Instances.LaunchTime
                [timespan]$tsEC2UpTime = New-TimeSpan -Start $dtStartUp -End $dtCrnt;

                #Stop Systems Running Longer that 12 Hours
                if($tsEC2UpTime.Hours -gt 12)
                {
                    Stop-EC2Instance -InstanceId $ec2InstID;
                }

            }#End of Instance Status Checks

        }#End of Null\Empty Checks on Instance Status

    }#End of Null\Empty 

}#End of EC2 Instance IDs File Foreach


