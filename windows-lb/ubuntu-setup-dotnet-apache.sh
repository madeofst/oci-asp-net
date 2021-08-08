# Add the Microsoft package signing key to your list of trusted keys and add the package repository
wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb

#Install the runtime (ms docs version)
#sudo snap install dotnet-runtime-50 --classic
#sudo snap alias dotnet-runtime-50.dotnet dotnet
#export DOTNET_ROOT=/snap/dotnet-runtime-50/current

#not sure what this is
sudo apt-get update
sudo apt-get install -y apt-transport-https

#Install the sdk (alt version)
sudo snap install --channel=5.0/edge dotnet-sdk --classic
sudo snap alias dotnet-sdk.dotnet dotnet
export DOTNET_ROOT=/snap/dotnet-sdk/current

#install apache and mods
sudo apt-get update
sudo apt-get install apache2 -y
sudo a2enmod proxy proxy_http proxy_html proxy_wstunnel
sudo a2enmod headers
sudo a2enmod ssl
sudo a2enmod rewrite

#move prewritten config file
sudo cp userdata/apache/netcore.conf /etc/apache2/conf-enabled/

# restart and test apache
sudo service apache2 restart
sudo apachectl configtest

# This is from the Oracle page to allow http
sudo iptables -I INPUT 6 -m state --state NEW -p tcp --dport 80 -j ACCEPT
sudo netfilter-persistent save

#copy the application files into the www
sudo cp -a ~/userdata/testgit /var/www/
#sudo chown -R www-data:www-data /var/www/testgit - leave user as ubuntu

# copy the service definitition file
sudo cp ~/userdata/apache/ServiceFile.service /etc/systemd/system/

sudo systemctl enable ServiceFile.service
sudo systemctl stop ServiceFile.service
sudo systemctl start ServiceFile.service

sudo systemctl restart apache2

sudo apachectl configtest
sudo systemctl status ServiceFile.service

#exit