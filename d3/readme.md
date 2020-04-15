# Use Case  
I get it, containers holds code and run processes.  
What if I don't want to create new containers, wasting time with the build process?  
Is it possible to leverage pre-packaged interpreters, compilers, framework etc. 
and dynamically pass my code, info, html, css, images, config-files even, 
without building a container and have to copy things and create YAC (yet another container)?  


# Exposed Tech  
+ No Dockerfile
+ No build process
+ Just testing my code, mapping it, without building any extra container
+ Container mounting host directory and/or file 
+ Developer does not have to copy code into the container or worse jump into it
+ leveraging a pre-packaged container image

# Focus  
+ The file/code/config/etc. is here represented by the **index.html** file
+ Again we leverage a pre-packaged container: a *"simple"* Nginx web server
+ However, we do *not run the build process* creating a new container
+ We map, in this case, a single file, but it could be a full host directory ([bind mount](https://docs.docker.com/storage/bind-mounts/)) into the container so that the in-container process sees it and act on it. In this case Nginx simply responds to the incoming request with this default *index.html* page
+ Run the script  
```
$ ./run.sh
```
+ Launch your browser or a curl command against  
```
http://localhost:8083
```
+ Edit the *index.html* greetings and refresh your browser to verify that Nginx is effectively picking up the file you intended to test   

---
If you are using Docker for Windows, you should change the bind mount for index.html to 
reflect Windows file specifications, similar to
  -v c:/Users/<USER>/repos/containers4developers/d3/index.html:/usr/share/nginx/html/index.html \
  
