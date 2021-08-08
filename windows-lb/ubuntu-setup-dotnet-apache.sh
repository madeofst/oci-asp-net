# Add the Microsoft package signing key to your list of trusted keys and add the package repository
wget https://packages.microsoft.com/config/ubuntu/21.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb

#Install the runtime
sudo snap install --channel=5.0/edge dotnet-sdk --classic
sudo snap alias dotnet-sdk.dotnet dotnet
export DOTNET_ROOT=/snap/dotnet-sdk/current

sudo apt-get update
sudo apt-get install apache2 -y

sudo a2enmod proxy proxy_http proxy_html proxy_wstunnel
sudo a2enmod rewrite
sudo cp userdata/apache/netcore.conf /etc/apache2/conf-enabled/

sudo service apache2 restart
sudo apachectl configtest

# This is from the Oracle page to allow http
sudo iptables -I INPUT 6 -m state --state NEW -p tcp --dport 80 -j ACCEPT
sudo netfilter-persistent save

sudo cp -a ~/userdata/testgit /var/netcore/

sudo cp ~/userdata/apache/ServiceFile.service /etc/systemd/system/

sudo systemctl enable ServiceFile.service
sudo systemctl stop ServiceFile.service
sudo systemctl start ServiceFile.service

sudo systemctl restart apache2
exit