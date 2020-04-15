#!/bin/bash

#docker run -d -p 8083:80 --name nginx nginx:latest

#Run          |Volume mount                                       |Port                   |Container
docker run -d \
  --rm \
  -v $PWD/index.html:/usr/share/nginx/html/index.html \
  -p 8083:80 \
  --name nginx \
  nginx:latest

