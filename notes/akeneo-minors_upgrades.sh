cd app/path
composer --prefer-dist update #sudo come with error, just run normal user
sudo apt-get update
composer licenses
sudo su #log as super user
/opt/bitnami/ctlscript.sh stop
sudo php bin/console cache:clear
# If error for permisons appears after cache clear > chmod -R 775 var/cache
rm -rf var/cache/* ./public/bundles/* ./public/css/* ./public/js/*
rm yarn.lock
sudo bin/console pim:installer:assets
bin/console cache:warmup
yarn install # Only on first minor upgrade if yarn is already installed, proceed
yarn run less
yarn run webpack # May show errors, to review
make upgrade-front
# May need restart the server then
shutdown –r now
sudo /opt/bitnami/ctlscript.sh start
sudo /opt/bitnami/ctlscript.sh status
# Check version with
cd app/path
nano composer.lock
# Find akeneo to see the version
