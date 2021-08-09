dotnet restore
dotnet build --no-restore
:: dotnet test --no-build --verbosity normal
dotnet publish -c Release -o webapp
rmdir /Q /S windows-lb\userdata\webapp
mv webapp windows-lb\userdata\
powershell.exe -ExecutionPolicy Bypass -File windows-lb\run-terraform.ps1
