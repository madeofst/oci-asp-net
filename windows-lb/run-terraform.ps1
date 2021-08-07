Set-Location windows-lb
terraform init
terraform apply
plink ubuntu@140.238.102.208 -batch -m clear-existing-app-data.sh -i c:\users\user\.ssh\oci_instance.ppk
scp -i c:\users\user\.ssh\oci_instance -r C:\Users\user\dev\oci-asp-net\windows-lb\userdata ubuntu@140.238.102.208:~
plink ubuntu@140.238.102.208 -batch -m ubuntu-setup-dotnet-apache.sh -i c:\users\user\.ssh\oci_instance.ppk