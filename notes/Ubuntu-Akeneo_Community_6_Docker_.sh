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
	docker -v

#Instalacion akeneo PIM
	mkdir pim
	cd pim
	#error de usuario, eliminar -u www-data en caso de error:
	#Could not delete /srv/pim:
	docker run -ti -u www-data --rm \
    -e COMPOSER_MEMORY_LIMIT=4G \
    -v $(pwd):/srv/pim -v ~/.composer:/var/www/.composer -w /srv/pim \
    akeneo/pim-php-dev:6.0 php /usr/local/bin/composer create-project \
    akeneo/pim-community-standard /srv/pim "6.0.*@stable"
    	sudo chmod 777 /home/usuario_EJEMPLO/pim 
	#VER PERMISOS ESPECIFICOS en ca
	sudo make #dev o prod

	#server: http://localhost:8080/
	#user: admin
	#password: admin
	#make down > turn down the server 
