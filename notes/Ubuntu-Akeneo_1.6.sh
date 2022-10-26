##Repositorio local
sudo nano /etc/apt/sources.list

#*VER*
deb http://kambing.ui.ac.id/ubuntu/ xenial main restricted universe multiverse
deb http://kambing.ui.ac.id/ubuntu/ xenial-updates main restricted universe multiverse
deb http://kambing.ui.ac.id/ubuntu/ xenial-security main restricted universe multiverse
deb http://kambing.ui.ac.id/ubuntu/ xenial-backports main restricted universe multiverse
deb http://kambing.ui.ac.id/ubuntu/ xenial-proposed main restricted universe multiverse

##PHP, MySQL, Apache2
sudo apt-get update
sudo add-apt-repository ppa:ondrej/php
sudo apt-get update
sudo apt-get install mysql-server php7.1 php7.1-xml php7.1-zip php7.1-curl  php7.1-intl php7.1-mbstring php7.1-mysql php7.1-gd php7.1-mcrypt apache2 libapache2-mod-php7.1 php7.1-cli php7.1-apcu

##Configuracion PHP/Apache2 y CLI
sudo nano /etc/php/7.1/apache2/php.ini
	date.timezone= America/Argentina/Buenos_Aires
	memory_limit =768M # Recommended minimum memory

sudo nano /etc/php/7.1/cli/php.ini
	date.timezone= America/Argentina/Buenos_Aires
	#(Eliminar "," en timezone)

##Base de datos
sudo mysql -u root -p
	CREATE DATABASE akeneo_pim;
	CREATE USER 'akeneo_pim'@'localhost' IDENTIFIED BY 'akeneo_pim';
	GRANT ALL PRIVILEGES ON akeneo_pim.* TO 'akeneo_pim'@'localhost' IDENTIFIED BY 'akeneo_pim';
	FLUSH PRIVILEGES;
	EXIT

##Descarga Akeneo
wget http://download.akeneo.com/pim-community-standard-v1.6-latest.tar.gz
sudo mkdir /var/www/akeneo  # akeneo installation directory
sudo chown -R erwin:erwin /var/www/akeneo
tar -xvzf pim-community-standard-v1.6-latest.tar.gz -C /var/www/akeneo/
cd /var/www/akeneo/pim-community-standard
chmod +x /var/www/akeneo/composer.phar
../composer.phar install --optimize-autoloader --prefer-dist
php app/console cache:clear --env=dev 
php app/console pim:install --env=dev
sudo chown -R www-data:www-data /var/www/akeneo


##Setup VirtualHost Akeneo
sudo nano /etc/apache2/sites-available/akeneo.conf

<VirtualHost *:80>
     ServerAdmin admin@example.com
     DocumentRoot /var/www/akeneo/pim-community-standard/web
     ServerName example.com
     ServerAlias www.example.com

     <Directory /var/www/akeneo/pim-community-standard/web/>
        Options +FollowSymlinks
        AllowOverride All
        Require all granted
     </Directory>

     ErrorLog ${APACHE_LOG_DIR}/error.log
     CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>

sudo a2dissite 000-default.conf
sudo a2ensite akeneo.conf
sudo a2enmod rewrite
sudo service apache2 restart

_______________________________
#Default Login
#	Username : admin
#	Password : admin