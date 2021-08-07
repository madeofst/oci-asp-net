dotnet restore
dotnet build --no-restore
dotnet test --no-build --verbosity normal
publish -c Release -o testgit
mv testgit windows-lb/userdata/
powershell.exe -ExecutionPolicy Bypass -File C:\Users\user\dev\oci-asp-net\windows-lb\run-terraform.ps1
