cd app/path
composer --prefer-dist update #sudo come with error, just run normal user
composer licenses
# Or check composer.lock version
sudo /opt/bitnami/ctlscript.sh stop # For Bitnami
service php8.0-fpm restart # For Akeneo manually installed
# Or simple restart
# If error for permisons appears after cache clear > chmod -R 775 var/cache
rm -rf var/cache/* ./public/bundles/* ./public/css/* ./public/js/*
rm yarn.lock # May not be necessary
sudo bin/console pim:installer:assets
bin/console cache:warmup
yarn install
yarn run less
yarn run webpack
# In case of error with "yarn run webpack":
#yarn --cwd=vendor/akeneo/pim-community-dev/akeneo-design-system install --frozen-lockfile
#yarn --cwd=vendor/akeneo/pim-community-dev/akeneo-design-system run lib:build
#make upgrade-front NO_DOCKER=true
#make upgrade-front
sudo php bin/console cache:clear
# The last 4 lines, to check if that make the webpack errors go away
# May need restart the server then
# In case ctlscript.sh stopped
sudo /opt/bitnami/ctlscript.sh status
shutdown –r now
# If not started automatically
sudo /opt/bitnami/ctlscript.sh start
# Re check the version
cd app/path
nano composer.lock
