#!/bin/bash
sudo apt update -y && sudo apt upgrade -y && sudo apt install docker docker-compose -y && sudo apt-get remove apache2
sudo mkdir -p /home/admin
sudo docker network create collectandverything
sudo docker run -d -p 9001:9001 --name portainer_agent --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/docker/volumes:/var/lib/docker/volumes portainer/agent:latest
cd /home/admin && sudo git clone -b staging https://deployment:glpat-ProCxh7sxrgzeWiotZY5@gitlab.com/hopnspace/weu1-d-001.docker.hopnspace.io
wget https://gitlab-runner-downloads.s3.amazonaws.com/latest/deb/gitlab-runner_amd64.deb
sudo dpkg -i gitlab-runner_amd64.deb
sudo rm gitlab-runner_amd64.deb
sudo gitlab-runner register
#> https://gitlab.collectandverything.fr
#> wW65p7WVhLEM5bzaFBbM
#> staging
#> staging
#> leave blank
#> shell
sudo nano /etc/sudoers
#> gitlab-runner ALL=(ALL) NOPASSWD: ALL
sudo gitlab-runner install -u gitlab-runner
sudo gitlab-runner start

