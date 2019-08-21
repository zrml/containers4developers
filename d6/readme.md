# Use Case
I get containers but I have my executable and I don't need anything else...  
I don't need nor want a 200MB container...
How much can I skin my container?

# Exposed Tech
+ Leveraging Dockerfile 
+ See the FROM SCRATCH directive
+ creating a minimal size container for my executable

# Focus
+ This is a GO based code example. The program access an html page (no https support, yet), retieves the page and returns the size of the page. The code is in **sizeofpg.go**
+ The **buildGoApp.sh** script simply builds the executable. Beacause I cannot expect the user to have GOlang installed I leverage the official GO compiler container and use that to compile out code (as per previous C compilers examples). The only caveats is that you might have to wait few seconds as the container is pulled. Just run the script  
```
$ ./buildGoApp.sh
```

+ The main point of this exercise is in this **Dockerfile** that leverages few KBs of overheads vs several hundred MBs of the standard base images from the operating systems providers. 
+ We use **FROM SCRATCH** in the Dockerfile. Please review the Dockerfile and see how easy it is to have a minimal size container image
+ After you have run the **buildContainer.sh** you should have a new container image called *myexe:1*. Please run the container build process and subsequently check the size of the image via  

```
$ ./buildContainer.sh  
$ docker images
```
+ of course :-) don't forget to check if the new container with its executabale actually works  
```
$ ./run.sh
```

---
