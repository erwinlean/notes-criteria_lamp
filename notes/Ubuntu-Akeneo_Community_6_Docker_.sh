# make
	sudo apt update
	sudo apt install make

# Docker install
	sudo apt update
	sudo apt install apt-transport-https ca-certificates curl software-properties-common
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
	sudo apt update
	apt-cache policy docker-ce
	sudo apt install docker-ce
	sudo systemctl status docker
	docker -v
	
# Docker-Composer
	sudo apt-get update
	sudo curl -L "https://github.com/docker/compose/releases/download/1.25.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
	sudo chmod +x /usr/local/bin/docker-compose

# Instalacion akeneo PIM
	mkdir pim
	cd pim
	#error de usuario, eliminar -u www-data en caso de error:
	#Could not delete /srv/pim:
	docker run -ti -u www-data --rm \
    -e COMPOSER_MEMORY_LIMIT=4G \
    -v $(pwd):/srv/pim -v ~/.composer:/var/www/.composer -w /srv/pim \
    akeneo/pim-php-dev:6.0 php /usr/local/bin/composer create-project \
    akeneo/pim-community-standard /srv/pim "6.0.*@stable"
	sudo make #dev o prod
	
	sudo chmod 777 /home/usuario_EJEMPLO/pim 
	sudo find / -iname ".cache" #o yarn
	sudo find / iname "cypress"
	sudo chmod 777 #carpetas con .cache/cypress
	#verificar los permisos de .cache/yarn, etc y ejecutar segun corresponda
	#sudo chown usuario posicion/de/la/carpeta/que/se/encontro
	#sudo chmod 777 posicion/de/la/carpeta/que/se/encontro
	#VER PERMISOS ESPECIFICOS en cada caso
	#En caso de "failed to register layer: Error processing tar file(exit status 1) no space left on device"
	free -m
	vgdisplay
	lvextend -l +100% /dev/ubuntu-vg/ubuntu-lv
	resize /dev/mapper/ubuntu--vg-ubuntu-lg
	sudo make #dev/prod

	#server: http://localhost:8080/
	#user: admin
	#password: admin
	#make down > turn down the server 
