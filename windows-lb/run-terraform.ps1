Set-Location windows-lb
terraform init
terraform apply -auto-approve
$hostuserip =("ubuntu@" + $(terraform output --raw public_ip))
ssh -i ..\..\..\.ssh\oci_instance $hostuserip 'sudo rm -r userdata'
scp -i ..\..\..\.ssh\oci_instance -r ..\..\..\dev\oci-asp-net\windows-lb\userdata ($hostuserip + ":~")
ssh -i ..\..\..\.ssh\oci_instance $hostuserip 'sudo chmod +x ./userdata/scripts/ubuntu-setup-dotnet-apache.sh'
ssh -i ..\..\..\.ssh\oci_instance $hostuserip 'sudo ./userdata/scripts/ubuntu-setup-dotnet-apache.sh'
