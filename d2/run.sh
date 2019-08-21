#!/bin/bash

CONTAINER_IMAGE=zrml/js-srv:1

function run()
{
	
  printf "\n\nStarting container...\n"	
  docker run -d -p 8080:8080 --name js-srv $CONTAINER_IMAGE
  printf "\nTry\ncurl http://localhost:8080\n"
}

main() 
{
if [ -z $(docker images -q $CONTAINER_IMAGE) ] 
then
  printf "\nImage does not exist\nBuilding it...\n"
  docker build -t zrml/js-srv:1 .
  
  # might as well run it...
  run	

else
  run
fi
}

main
