# Use Case
How difficult is it to containerize my code?  
It depends on the code and the dependencies...  
In general it's extremely easy

# Exposed Tech
+ possibly the simplest app in the world with mycode wrapped in a myapp container
+ intro to Dockerfile declarative definition and its simple & portable commands

# Focus
+ The app is defined in *myapp.sh*
+ The container will be created via the Docker build command that will read the Dockerfile
+ View the *Dockerfile* and understand the simple commands & where *myapp.sh* ends up
+ the **CMD** commands tell the container what to run when started up
+ run the build command  
```
$ docker build -t myapp:1 .
```  
that will create a container image called ```myapp``` tagged as ```1```
+ run the app via  
```
$ docker run myapp:1
```  
observer the output and consider what just happened  
+ the container was started from the local repository
+ the container run and
+ we saw the output
+ the container stopped  
+ check to see if the container is still running via  
```$ docker ps ```  

---


