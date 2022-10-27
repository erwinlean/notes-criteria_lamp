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

#make
	sudo apt update
	sudo apt install make
	

#Instalacion akeneo PIM
	sudo docker run -u www-data -v $(pwd):/srvpim -w /srv/pim --rm akeneo/pim-php-dev:master \ php -d memory_limit=4G /usr/local/bin/composer create-project --prefer-dist \ akeneo/pim-community-standard /srv/pim "dev-master@dev"
	sudo make

	#server: http://localhost:8080/
	#user: admin
	#password: admin
	#make down > turn down the server 
