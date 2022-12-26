cd app/path
composer --prefer-dist update #sudo come with error, just run normal user
sudo apt-get update
composer licenses
sudo /opt/bitnami/ctlscript.sh stop
sudo php bin/console cache:clear
# If error for permisons appears after cache clear > chmod -R 775 var/cache
rm -rf var/cache/* ./public/bundles/* ./public/css/* ./public/js/*
rm yarn.lock
sudo bin/console pim:installer:assets
bin/console cache:warmup
yarn install
yarn run less
yarn run webpack 
# May need restart the server then
sudo /opt/bitnami/ctlscript.sh start
sudo /opt/bitnami/ctlscript.sh status
# Check version with
cd app/path
nano composer.lock
# Find akeneo to see the version
