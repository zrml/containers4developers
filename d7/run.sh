#!/bin/bash

# just in case I 'rm -f' the container, that is, IRIS was brutally brought down...
rm -f ./MYDATA/iris.lck

docker run -d \
  -p 52773:52773 \
  -v $PWD:/ISC \
  -v $PWD/MYDATA:/MYDATA \
  -e ISC_DATA_DIRECTORY=/ISC/iris.sys.d \
  --name iris \
  --init \
  my-iris-app:1 \
  --key /ISC/iris.key
