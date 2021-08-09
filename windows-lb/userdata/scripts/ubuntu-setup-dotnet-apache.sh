# Add the Microsoft package signing key to your list of trusted keys and add the package repository

FILE=packages-microsoft-prod.deb
if [ -f "$FILE" ]; then
    echo "$FILE exists."
else
    wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
    sudo dpkg -i packages-microsoft-prod.deb
fi

#Install the runtime (ms docs version)
#sudo snap install dotnet-runtime-50 --classic
#sudo snap alias dotnet-runtime-50.dotnet dotnet
#export DOTNET_ROOT=/snap/dotnet-runtime-50/current

#not sure what this is
sudo apt-get update
sudo apt-get install -y apt-transport-https

#Install the sdk (alt version)
#sudo snap install --channel=5.0/edge dotnet-sdk --classic
#sudo snap alias dotnet-sdk.dotnet dotnet
#export DOTNET_ROOT=/snap/dotnet-sdk/79

#install the sdk manual binary
#FILE=dotnet-sdk-5.0.100-linux-arm64.tar.gz
#if [ -f "$FILE" ]; then
#    echo "$FILE exists."
#else
#    wget -q https://download.visualstudio.microsoft.com/download/pr/27840e8b-d61c-472d-8e11-c16784d40091/ae9780ccda4499405cf6f0924f6f036a/dotnet-sdk-5.0.100-linux-arm64.tar.gz
#fi

#DIRECTORY=dotnet-64
#if [ -d "$DIRECTORY" ]; then
#    echo "$DIRECTORY exists."
#else
#    mkdir dotnet-64
#    tar zxf dotnet-sdk-5.0.100-linux-arm64.tar.gz -C $HOME/dotnet-64
#    export DOTNET_ROOT=$HOME/dotnet-64
#    export PATH=$HOME/dotnet-64:$PATH
#fi

#install the runtime only
FILE=aspnetcore-runtime-5.0.8-linux-arm64.tar.gz
if [ -f "$FILE" ]; then
    echo "$FILE exists."
else
    wget -q https://download.visualstudio.microsoft.com/download/pr/36c6210a-5b28-4598-81f7-2cef1a0bd1d5/296782726e68368c8ddf87ba828b5fc7/aspnetcore-runtime-5.0.8-linux-arm64.tar.gz
fi

mkdir dotnet-64
tar zxf aspnetcore-runtime-5.0.8-linux-arm64.tar.gz -C /home/ubuntu/dotnet-64
export DOTNET_ROOT=/home/ubuntu/dotnet-64
export PATH=/home/ubuntu/dotnet-64:$PATH

#install dependencies
sudo apt-get install libc6-dev
sudo apt-get install libgcc1
sudo apt-get install libgssapi-krb5-2
sudo apt-get install libicu66
sudo apt-get install libssl1.1
sudo apt-get install libstdc++6
sudo apt-get install zlib1g

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
sudo cp -a /home/ubuntu/userdata/webapp /var/www/
#sudo chown -R www-data:www-data /var/www/webapp - leave user as ubuntu

# copy the service definitition file
sudo cp /home/ubuntu/userdata/apache/ServiceFile.service /etc/systemd/system/

sudo systemctl enable ServiceFile.service
sudo systemctl stop ServiceFile.service
sudo systemctl start ServiceFile.service

sudo systemctl restart apache2

sudo apachectl configtest
sudo systemctl status ServiceFile.service

#exit