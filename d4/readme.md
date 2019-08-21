# Use Case
Similar to the previous demo:  
I do not want to create a container.  
I just want to run *my code* while testing *different compilers*
as I do not want to waste time installing four different C compilers versions

# Exposed Tech
+ Leveraging prepackaged compilers 
+ Even **gcc** is containerized

# Focus
+ The code I want test is in **gcc_app.c**
+ Without installing 4 compilers, resetting environment variables, etc. I am able to simply test four compiler verisions by simply running four containers.
+ Run any of the scripts to create a relative compiled executable. See the ```-o``` flag to the *gcc* command  

```
$ ./run_gcc_4_9.sh     # or any of the other gcc version scripts
$ ./run_gcc_9_1.sh  
```  
+ run the executable, for example  

```
$ ./myapp_4_9.         # and similarly, for example
$ ./myapp_9_1
```  

--> *WARNING: while the compilation will run with gcc in the container, the executables, saved at the host level in your $PWD, will only run on Linux*

---
