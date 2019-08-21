#!/bin/bash

# building the executable: 
# with GO installed 
#CGO_ENABLED=0 GOOS=linux go build -v -a -installsuffix cgo -o myexe .

# building the executable:
# with GO not installed; leveraging the official GOlang container 
docker run --rm -v $PWD:/usr/src/myapp -w /usr/src/myapp golang go build -v -a -installsuffix cgo -o myexe
