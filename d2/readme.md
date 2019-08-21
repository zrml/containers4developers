#Use case
I have some code I want to test...  
instead of installing the environment needed, I just use a container with it. Basically I want to know if I can leverage pre-prepared containers with the technology I need.


#Exposed Tech
+ Leverage pre-packaged interpreters, compilers, framework, databases, etc.
+ Dockerfile declaration
+ Dockerfile commands
+ Build command
+ Push to registry

#Focus
+ Check the code we want to test in *server.js*
+ Check the Dockerfile; we leverage a pre-built & existing nodeJS container image
+ We tell the container to run nodeJS and pass our code to it
+ Run the **run.sh** script which runs the *Docker build* command for us and creates the container image *zrml/js-srv:1*
+ Note the full repository name of *zrml/js-srv*. That is needed as we will push the portable image to the Docker Hub to demonstrate its availability on the internet and its portabililty
+ The push command can be found below. Please be aware that  
	1) you'll have to log into the Container Registry you'll want to use (in this case [Docker Hub](https://hub.docker.com)) and  
	2) you'll have to use your Docker Hub repository name and retag the image with your repo name   
```
$ docker push zrml/js-srv:1
```  

