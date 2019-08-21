#!/bin/bash

docker run -d -p 8090:8080 --name crochunter oveits/crochunter

printf "\nPlease launch your browser at http://<host-node-ip>:8090 and have fun :) \n\n"

