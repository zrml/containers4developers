#!/bin/bash

# run the container and allow to pass a param
docker run --rm --net=host myexe:1 $1 
