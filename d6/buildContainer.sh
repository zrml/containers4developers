#!/bin/bash

# removing the old one just in case
docker rmi myexe:1

# building the container with the newly compiled executable
docker build -t myexe:1 .

