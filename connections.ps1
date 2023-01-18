$trip = 0
$a = netstat -ano 
$a[6..$a.count] | ConvertFrom-String | select p4 |Out-File -FilePath .\temp.txt
gc .\temp.txt | sort | get-unique > .\temp1.txt
$regexIPAddress = '\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b.'
echo "******************************** BRAND NEW CONNECTIONS ********************************"
foreach($line in Get-Content .\temp1.txt) {
		if($line -match $regexIPAddress){
			if($line -ne ""){
				if($line -like "*4444*"){
					$trip++
				}
				if($trip -eq 1){
					[System.Windows.Forms.MessageBox]::Show('Malicious connection suspected!')
				}
				$SEL = Select-String -Path .\current.txt -Pattern $line

				if ($SEL -eq $null)
				{
					echo $line
				}
			}
		}
}
echo "******************************** OTHER NEW CONNECTIONS ********************************"
foreach($line in Get-Content .\current.txt) {
		if($line -match $regexIPAddress){
			if($line -ne ""){
				$SEL = Select-String -Path .\baseline1.txt -Pattern $line

				if ($SEL -eq $null)
				{
					echo $line
				}
			}
		}
}
Copy-Item ".\temp1.txt" -Destination ".\current.txt"