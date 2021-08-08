Set-Location windows-lb
terraform init
terraform apply -auto-approve
$hostuserip =("ubuntu@" + $(terraform output --raw public_ip))
plink -hostkey SHA256:XxOv63rB3dzZENxDgsTCU3PvQ4GEywUMKyKBF2qo0JE $hostuserip -batch -m clear-existing-app-data.sh -i ..\..\..\.ssh\oci_instance.ppk
scp -i ..\..\..\.ssh\oci_instance -r ..\..\..\dev\oci-asp-net\windows-lb\userdata ($hostuserip + ":~")
plink -hostkey SHA256:XxOv63rB3dzZENxDgsTCU3PvQ4GEywUMKyKBF2qo0JE $hostuserip -batch -m ubuntu-setup-dotnet-apache.sh -i ..\..\..\.ssh\oci_instance.ppk