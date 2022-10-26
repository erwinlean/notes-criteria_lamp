#Log en http mediante ip:
#user:user
#pass:VNS8iUIvPf4C

#Pasos:
sudo apt-get -y install nano
cd /bitnami/magento
sudo composer require --ignore-platform-reqs akeneo/module-magento2-connector-community
#	credeciales:
#		user=Public key: 82286d1010893d033a934c6422b66806
#		password=private key: cfb3bb40f484158deb84783e63a19d32 
sudo php bin/magento module:enable Akeneo_Connector
sudo chmod 777 /bitnami/magento/var/page_cache
sudo chmod 777 /bitnami/magento
sudo php bin/magento setup:db:status
sudo php bin/magento setup:upgrade
sudo php bin/magento cache:flush

#Error backend varnish > error comun, modificar el varnish, varia localizacion segun linux(ver donde se ubica en bitnami al ser un linux "diferente")
sudo /opt/bitnami/configure_app_domain --domain IP_OR_DOMAIN 
#(example domain:192.162.100.51)
free -m
#swap count should be equal or higher than default m (memory) so...
sudo dd if=/dev/zero of=/mnt/swap.0 bs=1M count=4096
sudo mkswap /mnt/swap.0
sudo su
echo "/mnt/swap.0 swap swap defaults 0 0" >> /etc/fstab
swapon /mnt/swap.0
sudo swapon -s
sudo /opt/bitnami/ctlscript.sh restart varnish
sudo /opt/bitnami/ctlscript.sh restart apache