#!/bin/bash
sudo apt update -y && sudo apt upgrade -y && sudo apt-get remove apache2
sudo apt-get update
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo mkdir -p /home/admin
sudo docker network create collectandverything
sudo docker run -d -p 9001:9001 --name portainer_agent --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/docker/volumes:/var/lib/docker/volumes portainer/agent:latest
cd /home/admin && sudo git clone -b staging http://deployment:glpat-nPomzpGxXBzPsxjZvhVH@51.178.182.214/collect-verything/back/docker.collect.verything.git
wget https://gitlab-runner-downloads.s3.amazonaws.com/latest/deb/gitlab-runner_amd64.deb
sudo dpkg -i gitlab-runner_amd64.deb
sudo rm gitlab-runner_amd64.deb
sudo gitlab-runner register
#> http://gitlab.collectandverything.fr
#> GR1348941B7QjcuEcPnF776Px9stm
#> staging
#> staging
#> leave blank
#> shell
sudo gitlab-runner register
#> http://gitlab.collectandverything.fr
#> GR1348941PfWepo7REJ5SN_KvYPtN
#> staging
#> staging
#> leave blank
#> shell
sudo nano /etc/sudoers
#> gitlab-runner ALL=(ALL) NOPASSWD: ALL
sudo gitlab-runner install -u gitlab-runner
sudo gitlab-runner start

# shellcheck disable=SC2164
cd /home/admin/docker.collect.verything/images/nginx-alpine && sudo docker build -t collectandverything-nginx . && cd /home/admin/docker.collect.verything
cd /home/admin/docker.collect.verything/images/react && sudo docker build -t collectandverything-react . && cd /home/admin/docker.collect.verything
cd /home/admin/docker.collect.verything/images/php8.1-fpm && sudo docker build -t collectandverything-php . && cd /home/admin/docker.collect.verything
cd /home/admin/docker.collect.verything/db-pgsql && sudo docker compose build && sudo docker compose up -d
cd /home/admin/docker.collect.verything/memcached && sudo docker compose build && sudo docker compose up -d
cd /home/admin/docker.collect.verything/rabbitmq && sudo docker compose build && sudo docker compose up -d
cd /home/admin/docker.collect.verything/proxy-staging && sudo docker compose build && sudo docker compose up -d
cd /home/admin/docker.collect.verything/proxy && sudo docker compose build && sudo docker compose up -d

create database addresses;
create database admins;
create database api;
create database carts;
create database employees;
create database images;
create database mails;
create database orders;
create database products;
create database stores;
create database users;
create database bills;
create database payments;

php artisan migrate --force

sudo docker exec address-php /bin/bash -c 'php artisan migrate --force'
sudo docker exec admin-php /bin/bash -c 'php artisan migrate --force'
sudo docker exec api-php /bin/bash -c 'php artisan migrate --force'
sudo docker exec image-php /bin/bash -c 'php artisan migrate --force'
sudo docker exec mail-php /bin/bash -c 'php artisan migrate --force'
sudo docker exec order-php /bin/bash -c 'php artisan migrate --force'
sudo docker exec product-php /bin/bash -c 'php artisan migrate --force'
sudo docker exec store-php /bin/bash -c 'php artisan migrate --force'
sudo docker exec user-php /bin/bash -c 'php artisan migrate --force'
sudo docker exec bill-php /bin/bash -c 'php artisan migrate --force'
sudo docker exec payment-php /bin/bash -c 'php artisan migrate --force'
sudo docker exec employee-php /bin/bash -c 'php artisan migrate --force'

sudo docker exec address-php /bin/bash -c 'php artisan db:seed --force'
sudo docker exec admin-php /bin/bash -c 'php artisan db:seed --force'
sudo docker exec api-php /bin/bash -c 'php artisan db:seed --force'
sudo docker exec image-php /bin/bash -c 'php artisan db:seed --force'
sudo docker exec mail-php /bin/bash -c 'php artisan db:seed --force'
sudo docker exec order-php /bin/bash -c 'php artisan db:seed --force'
sudo docker exec product-php /bin/bash -c 'php artisan db:seed --force'
sudo docker exec store-php /bin/bash -c 'php artisan db:seed --force'
sudo docker exec user-php /bin/bash -c 'php artisan db:seed --force'
sudo docker exec bill-php /bin/bash -c 'php artisan db:seed --force'
sudo docker exec payment-php /bin/bash -c 'php artisan db:seed --force'
sudo docker exec employee-php /bin/bash -c 'php artisan db:seed --force'

sudo docker exec address-php /bin/bash -c 'php artisan migrate:rollback --force'
sudo docker exec admin-php /bin/bash -c 'php artisan migrate:rollback --force'
sudo docker exec api-php /bin/bash -c 'php artisan migrate:rollback --force'
sudo docker exec image-php /bin/bash -c 'php artisan migrate:rollback --force'
sudo docker exec mail-php /bin/bash -c 'php artisan migrate:rollback --force'
sudo docker exec order-php /bin/bash -c 'php artisan migrate:rollback --force'
sudo docker exec product-php /bin/bash -c 'php artisan migrate:rollback --force'
sudo docker exec store-php /bin/bash -c 'php artisan migrate:rollback --force'
sudo docker exec user-php /bin/bash -c 'php artisan migrate:rollback --force'
sudo docker exec bill-php /bin/bash -c 'php artisan migrate:rollback --force'
sudo docker exec payment-php /bin/bash -c 'php artisan migrate:rollback --force'
sudo docker exec employee-php /bin/bash -c 'php artisan migrate:rollback --force'



