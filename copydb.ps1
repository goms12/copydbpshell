# Create log file for tracing or documentation if not exist
if (!(test-path \\192.168.XX.XX\log_backup_$(get-date -Format "yyyy_MM").log -PathType Leaf))
{
  New-Item -Path \\192.168.XX.XX\Database$\log_backup_$(get-date -Format "yyyy_MM").log
}

#Copy database function
function SetCopyDatabase
{
param
(
  [String]$source,
  [String]$destination
)

ForEach ($p_file in Get-ChildItem $source) 
{
    # Check for the backup file is exist or not
    if (!(Test-Path -path ($destination + $p_file.name) -PathType Leaf))
    {
        # If file not exist, do copy and write the log
        Add-Content \\192.168.XX.XX\Database$\log_backup_$(get-date -Format "yyyy_MM").log -Value "`n $(Get-Date -Format yyyy-MM-dd)|$(Get-Date -UFormat %T)|Copy|$($p_file.FullName)"
        Copy-Item $p_file.fullname -Destination $destination -Confirm:$false -Force:$true -Recurse
    }
    else
    {
        #bypass
    }
}
  # End Function
}



#Example to run the function

SetCopyDatabase "\\192\168\\XX\\XX" "D:\Backup\XXX"
