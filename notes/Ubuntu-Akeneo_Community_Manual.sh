### Instalacion de packetes necesarios (requisitos) segun https://apps.akeneo.com/extension/akeneo-connector-magento-2-community-edition
# Sistema operativo : 
#	Debian, Ubuntu , CentOS



## dependencias extras *VER*
# Image magick ≥ 6.8
# aspell ≥ 0.60.7
# MagickCore extra codecs ≥ libmagickcore-6.q16-2-extra Image magick extra codecs to handle SVG
# JQuery 3.4

# nodejs ≥ 14
	sudo apt-get install curl
	sudo curl -sL https://deb.nodesource.com/setup_14.x -o nodesource_setup.sh
	sudo bash nodesource_setup.sh
	sudo apt-get install -y nodejs
	nodejs -v

# yarn ≥ 1.22
	sudo -i
	sudo curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
	sudo echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
	sudo apt update && apt-get install yarn

## MySQL (SQL) 8.0.23
#mysql-server
#php8.0-mysql
	wget https://dev.mysql.com/get/mysql-apt-config_0.8.23-1_all.deb
	sudo dpkg -i mysql-apt-config_0.8.23-1_all.deb
#	O
	wget https://downloads.mysql.com/archives/get/p/23/file/mysql-server_8.0.23-1debian10_amd64.deb-bundle.tar
	sudo dpkg -i mysql-apt-mysql-server_8.0.23-1debian10_amd64.deb-bundle.tar
#	O
	sudo dpkg -i mysql-server_8.0.23-1debian10_amd64.deb-bundle.tar
#	"ok"
	sudo apt update
	sudo apt install mysql-client mysql-server

## Elasticsearch 7.16
#**Necesita ser usuario root**
	sudo -i #sudo su
	sudo apt-get install apt-transport-https
	sudo wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add - 
	sudo echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | tee -a /etc/apt/sources.list.d/elastic-7.x.list
	sudo apt update && apt-get install elasticsearch
	sudo service elasticsearch start
	sudo sysctl -w vm.max_map_count=262144
	sudo echo "vm.max_map_count=262144" | tee /etc/sysctl.d/elasticsearch.conf
	sudo service elasticsearch restart

# make
	sudo apt update
	sudo apt install make

#Docker-Composer
	sudo apt-get update
	sudo curl -L "https://github.com/docker/compose/releases/download/1.25.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
	sudo chmod +x /usr/local/bin/docker-compose

#Docker install
	sudo apt update
	sudo apt install apt-transport-https ca-certificates curl software-properties-common
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
	sudo apt update
	apt-cache policy docker-ce
	sudo apt install docker-ce
	sudo systemctl status docker

# PHP 8.0 + modulos: 
	sudo apt-get install software-properties-common
	sudo add-apt-repository ppa:ondrej/php 
	sudo apt update
	sudo LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php
#**en caaso de error gpg key: ONDREJ REPOSITORY puede tener problemas segun servidor de internet que se utilice >> ejemplo: claro**
	sudo apt update
	sudo apt-get install php8.0-cli php8.0-apcu php8.0-bcmath php8.0-curl php8.0-opcache php8.0-fpm php8.0-gd php8.0-intl php8.0-memcached php8.0-mysql php8.0-xml php8.0-zip php8.0-mbstring php8.0-imagick

#**NOTAS de instalacion php ultima parte en caso de instalacion de apache antes de php:
#	Not anabling PHP 8.0 FPM by default.
#	To anable php 8.0 FPM in Apache2 do:
		a2enmod proxy_fcgi setenvif
		a2enconf php8.0-fpm
#	you are seeing this message because you have apache2 package installed.

#composer >= 2
	cd ~
	curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php
	HASH=`curl -sS https://composer.github.io/installer.sig`
	echo $HASH
	e0012edf3e80b6978849f5eff0d4b4e4c79ff1609dd1e613307e16318854d24ae64f26d17af3ef0bf7cfb710ca74755a
	php -r "if (hash_file('SHA384', '/tmp/composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
		Installer verified
	sudo php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer
	composer

# Web server: Apache web server: ≥ 2.4
	sudo apt-get install apache2
	sudo a2enmod rewrite proxy_fcgi
	sudo service apache2 restart
	mod rewrite Required
		sudo a2enmod rewrite
	mod-fastcgi Required (no CGI nor libmod-php)
		apachectl -t -D DUMP_MODULES > para ver modulos activos, debe estar fastCGI




#setear en: Setup CLI php.ini file /etc/php/8.0/cli/php.ini
	sudo nano /etc/php/8.0/cli/php.ini
	memory_limit = 1024M
	date.timezone = UTC #(poner hora segun UTC ejemplo: America/Argentina/Buenos_Aires)
#Setear en: /etc/php/8.0/fpm/php.ini
	sudo nano /etc/php/8.0/fpm/php.ini
	memory_limit = 512M
	date.timezone = UTC #(poner hora segun UTC ejemplo: America/Argentina/Buenos_Aires)

#Obtener identificadores: 
	sudo id
#Parar FPM
	sudo service php8.0-fpm stop

#Abrir /etc/php/8.0/fpm/pool.d/www.conf:
	sudo nano /etc/php/8.0/fpm/pool.d/www.conf
#Reemplazar variables >
	user = my_user
	group = my_group
	listen = /run/php/php8.0-fpm.sock
	listen.owner = www-data
	listen.group = www-data
sudo service php8.0-fpm restart



#___________________________________________________________________
### System installation on Ubuntu 18.04 (Bionic Beaver)
configuracion:

#MySQL
sudo -i #(entrar en modo root, no deja alterar MySQL sino)
	mysql -u root -p
		CREATE DATABASE akeneo_pim;
		CREATE USER akeneo_pim@localhost IDENTIFIED WITH mysql_native_password BY 'akeneo_pim';
		GRANT ALL PRIVILEGES ON akeneo_pim.* TO akeneo_pim@localhost;
		EXIT


#APACHE - Creating the virtual host file
	sudo nano /etc/apache2/sites-available/akeneo-pim.local.conf
#* copiar * >
<VirtualHost *:80>
    ServerName akeneo-pim.local

    DocumentRoot /path/to/installation/pim-community-standard/public
    <Directory /path/to/installation/pim-community-standard/public>
        AllowOverride None
        Require all granted

        Options -MultiViews
        RewriteEngine On
        RewriteCond %{REQUEST_FILENAME} !-f
        RewriteRule ^(.*)$ index.php [QSA,L]
    </Directory>

    <Directory /path/to/installation/pim-community-standard/public/bundles>
        RewriteEngine Off
    </Directory>

    <FilesMatch \.php$>
        SetHandler "proxy:unix:/run/php/php8.0-fpm.sock|fcgi://localhost/"
    </FilesMatch>

    SetEnvIf Authorization .+ HTTP_AUTHORIZATION=$0

    ErrorLog ${APACHE_LOG_DIR}/akeneo-pim_error.log
    LogLevel warn
    CustomLog ${APACHE_LOG_DIR}/akeneo-pim_access.log combined
</VirtualHost>

#**Replace /path/to/installation by the path to the directory where you want to install the PIM. ** > reemplazar path/to/installation por la carpeta donde los instalaremos eje: /home/erwin/pim/pim-community-standard/public
#Replace pim-community-standard by pim-enterprise-standard for enterprise edition.
/run/php/php8.0-fpm.sock is the default socket path. If you changed it in /etc/php/8.0/fpm/pool.d/www.conf, change it in the virtual host too.**

# The Apache configuration is done, you need to enable it:
	sudo apache2ctl configtest
	sudo a2ensite akeneo-pim.local
	sudo service apache2 reload

#Edit: /etc/hosts con: 
	sudo nano /etc/hosts
	127.0.0.1    akeneo-pim.local


#___________________________________________________________________
### Instalacion Akeneo PIM community:

#Obtener Akeneo > 
	composer create-project akeneo/pim-community-standard /srv/pim "6.0.*@stable
#	O
	wget https://download.akeneo.com/pim-community-standard-v6.0-latest-icecat.tar.gz
	tar -xvf pim-community-standard-v6.0-latest-icecat.tar.gz
#inicializar Akeneo > 
#Copiar el .env en un .env local, para configuracion de forma local (Copy the .env into a local .env and make the configuration in the local .env)
	APP_ENV=prod
	APP_DATABASE_HOST=localhost
	APP_DATABASE_PORT=null
	APP_DATABASE_NAME=akeneo_pim
	APP_DATABASE_USER=akeneo_pim
	APP_DATABASE_PASSWORD=akeneo_pim
	APP_INDEX_HOSTS='localhost:9200'

# Lanzar PIM en dev mode: 
	sudo NO_DOCKER=true make dev
#Finalizado el servidor PIM deberia ser accesible en http://localhost:8080/

# Lanzar PIM en prod mode:
	sudo NO_DOCKER=true make prod
#Finalizado el servidor PIM deberia ser accesible en http://localhost:8080/

-------------

#**Dar permiso chmod 777 a carpeta si tira error de permisos denied**
#**crear .env en /usr/local y por las dudas en usr, en home, 
# Modificar el .env de la carpeta akeneo, crear .env en 
# Etc/environment y en en la carpeta bin (total no hace daño)**