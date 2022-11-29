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
	sudo docker-compose version

# Instalacion akeneo PIM
	
	mkdir pim
	cd pim
	#Evitar problemas de accesos/usuarios y permisos:
	chown -R root /home/erwin/Desktop/pim
	chmod -R 755 /home/erwin/Desktop/pim #o -R 777
	sudo docker run -ti -u www-data --rm \
    -e COMPOSER_MEMORY_LIMIT=4G \
    -v $(pwd):/srv/pim -v ~/.composer:/var/www/.composer -w /srv/pim \
    akeneo/pim-php-dev:6.0 php /usr/local/bin/composer create-project \
    akeneo/pim-community-standard /srv/pim "6.0.*@stable"
	sudo make #dev o prod
	
	#Connect via tunnel
	#install https://ngrok.com/ for the operative system/processor (CPU - bits)
	#Install https://ngrok.com/ segun systema operativo (CPU - bits)
	#Unzip/extraer archivo descargado
	#En la carpeta/path donde se descomprimio o ingresandole el path exacto ejecuta ngrok > en caso de realizar otras operaciones ./ngrok help
	./ngrok config add-authtoken my_token_from_ngrok_website
	./ngrok http 8080
	#Servidor online para testear: Forwarding       https://example-181-117-15-25.sa.ngrok.io
	#Click en "visit site"
	cd /root/.config/ngrok
	nano ngrok.yml
	#Agregar Tunnel, para que este sea estatico
	
	
	###Errores:
	#En caso de error de usuario, eliminar -u www-data en caso de error: Could not delete /srv/pim:
	#Eliminar en docker: -u www.-data
	sudo docker run -ti --rm \
    -e COMPOSER_MEMORY_LIMIT=4G \
    -v $(pwd):/srv/pim -v ~/.composer:/var/www/.composer -w /srv/pim \
    akeneo/pim-php-dev:6.0 php /usr/local/bin/composer create-project \
    akeneo/pim-community-standard /srv/pim "6.0.*@stable"
	
	#De persistir error de permisos:
	sudo find / -iname ".cache" #o yarn .yarn
	sudo find / -iname "cypress"
	#Ejecutar permisos necesario, analizando respuestas y carpetas especificas, ejemplos:
	chmod -R 777 /root/.cache/
	chmod -R 755 /home/.cache
	
	#En caso de "failed to register layer: Error processing tar file(exit status 1) no space left on device"
	#Ampliar el espacio de uso al 100%
	free -m
	#o
	sudp vgdisplay
	#o
	sudo pvdisplay 
	sudo lvextend -l +100%FREE /dev/ubuntu-vg/ubuntu-lv
	sudo resize2fs /dev/mapper/ubuntu--vg-ubuntu--lv
	sudp vgdisplay
	#o
	sudo pvdisplay 

	#server: http://localhost:8080/
	#user: admin
	#password: admin
	#make down > turn down the server 
