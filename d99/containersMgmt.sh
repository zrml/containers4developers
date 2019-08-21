#!/bin/bash

docker run -d -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data --name portainer portainer/portainer

printf "\nPlease launch your browser at http://<host-node-ip>:9000 and \n"
printf "manage your fleet of containers and images without all those Docker commands :-)\n\n"
