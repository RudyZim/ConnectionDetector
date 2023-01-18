netstat -ano |Out-File -FilePath .\baseline.txt
Copy-Item ".\baseline.txt" -Destination ".\current.txt"