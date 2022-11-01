#Log en http mediante ip:
#Credentials for app:
sudo cat /home/bitnami/bitnami_credentials

#Utility notes:
sudo php bin/magento module:status #status check
sudo find / -iname "whatever"  
#General Search file/archive if needed

#Steps to connect
sudo apt-get -y install nano
sudo apt update
sudo apt-get upgrade
#Press ctrl+D
cd /bitnami/magento
sudo php bin/magento maintenance:enable
sudo composer require akeneo/module-magento2-connector-community
#o
sudo composer require --ignore-platform-reqs akeneo/module-magento2-connector-community
#	credetials:
#		user=Public key: 82286d1010893d033a934c6422b66806
#		password=private key: cfb3bb40f484158deb84783e63a19d32 
sudo php bin/magento module:enable Akeneo_Connector
sudo php bin/magento module:status Akeneo_Connector
sudo php bin/magento setup:db:status
sudo php bin/magento setup:upgrade
sudo php bin/magento cache:flush

#Permissions
#To modify
cd /
sudo chown -R daemon:daemon /opt/bitnami/magento/
sudo find /opt/bitnami/magento -type f -exec chmod 644 {} \;
sudo find /opt/bitnami/magento -type d -exec chmod 777 {} \; 

#modificar este ultimo y si lo siguientes son realmente necesarios, no deberia de darse permisos 777 a toda la carpeta*revisar
#posiblemente sudo find /opt/bitnami/magento -type d -exec chmod 755 {} \; 
sudo chown -R daemon:daemon /opt/bitnami/apache/htdocs/
sudo find /opt/bitnami/apache/htdocs/ -type d -exec chmod 755 {} \;
sudo find /opt/bitnami/apache/htdocs/ -type f -exec chmod 644 {} \;
sudo chown -R daemon:daemon /home/bitnami/htdocs/
sudo find /home/bitnami/htdocs/ -type d -exec chmod 755 {} \;
sudo find /home/bitnami/htdocs/ -type f -exec chmod 644 {} \;

#Configure memory/ip just in case
sudo /opt/bitnami/configure_app_domain --domain IP_OR_DOMAIN #(eje:192.162.100.51)
free -m
sudo dd if=/dev/zero of=/mnt/swap.0 bs=1M count=4096
sudo mkswap /mnt/swap.0
sudo su
echo "/mnt/swap.0 swap swap defaults 0 0" >> /etc/fstab
swapon /mnt/swap.0
sudo swapon -s
free -m

#End resstart server
sudo php bin/magento maintenance:disable
sudo /opt/bitnami/ctlscript.sh restart varnish
sudo /opt/bitnami/ctlscript.sh restart apache