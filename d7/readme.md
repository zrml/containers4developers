
# Use Case
How about creating my container importing my IRIS Object Script application code?

# Exposed Tech
+ Creating my container deriving it from an InterSystems IRIS container image
+ The container has my IRIS ObjectScript app code
+ The build process creates a **MYCODE** only DB (see [separation of concerns](https://en.wikipedia.org/wiki/Separation_of_concerns) between code and data) in the container
+ Defining an IRIS **MYAPP** *namespace* wiht mapping to MYCODE & MYDATA
	+ The MYAPP namespace definition and the MYCODE database will be in the container, while the MYDATA database will be mounted at container startup from a host OS directory
+ Executing a %Installer declaration to tune the system, import code and create namespace and databases mappping at build time
+ Mounting host volumes
+ Mounting a a specific host volume that contains an existing database that will be used as the non-ephemeral/persistent MYDATA db
+ IRIS 2019.3 non-root default user


# Focus
+ Here we have a super simple application purposefully built with *.ro* & *.xml* to show that even legacy apps can be containerized. There is also a ZSTU routine for that all important service startup when the instance comes up.
+ The end result will be a MYAPP [namespace](https://docs.intersystems.com/irislatest/csp/docbook/DocBook.UI.Page.cls?KEY=GORIENT_ch_enviro) pointing at 2 distinct [databases](https://docs.intersystems.com/irislatest/csp/docbook/DocBook.UI.Page.cls?KEY=GORIENT_ch_enviro#GORIENT_enviro_database_basics):  
	a) MYCODE, in the container and  
	b) MYDATA, bind mounted from the host  
	Please see the **myappInstaller.xml** for all the details and system tuning.
+ The Dockerfile is the secret source here to understand, together with the above mentioned installer.
+ Please note the Dockerfile **USER** directives that dictates what user should be running those commands. This is extremely important with InterSystems new containers (from 2019.3) as it provides a default non-root user (irisowner) in order to be more acceptable in highly controlled enterprise environments: 
 
```
USER root 
USER irisowner
```
+ The subdirectory ./MYDATA is where the data database is located. This directory will be bind mounted by the IRIS container and will be the database of the MYAPP [namespace](https://docs.intersystems.com/irislatest/csp/docbook/DocBook.UI.Page.cls?KEY=GORIENT_ch_enviro) and app.
+ Please note in the IRIS section of the Dockerfile new utilities that will grace 2019.3. They are useful as one prepares a clean application container [SYS.Container](link-TBD)
+ Requirements: to successfully *build* & *run* the **buildContainer.sh** you need to have  
	a) InterSystems IRIS 2019.3 or later and  
	b) a valid *iris.key* (note that the one in the repository is empty)
	+ If you use InterSystems IRIS 2019.3 Community Edition [from the Docker Hub Registry](https://hub.docker.com/_/intersystems-iris-data-platform), you will not need the key.
+ if the above requirements are satisfied, run the following commands to
	+ build the container image that will have a new MYCODE db and a MYAPP namespace
	+ run the container that will bind mount the ```$PWD/MYDATA/IRIS.DAT``` as the MYDATA database in the InterSystems IRIS instance running in the container.  Make sure that the IRIS user within the container (irisowner, UID 51773. GID 52773) has privilege to write to $PWD/MYDATA and $PWD/MYDATA/IRIS.DAT.  If not, the application will receive <PROTECT> errors and fail.

```
$ ./buildContainer.sh  
$ ./run.sh
```  

+ Via a browser, [log into the system](http://localhost:52773/csp/sys/utilhome.csp) with credentials _SYSTEM/SYS and check the process...
	+  *System Operation > Processes* 
+ Via the same browser, check the data that is constantly been written
	+ *System Explorer > Globals*
	+ Select the **MYAPP** Namespace on the left hand selector
	+ Select the **View** link for the Global **^myappData** 

+ or if you prefer do the same ops via the terminal follow the instructions below
	+ use %SS (system status; like a Linux *ps -ef*) to find the running process that is writing data to the **MYAPP** namespace in the **^myappData** global
	+ and then switch Namespace (the ZN command) and output (ZW) the content of that global 

```
# allow few seconds for the container to implement the Durable %SYS feature, then
# look for the Routine myapp running in the MYAPP Namespace

$ docker exec -it iris iris session IRIS
>do ^%SS
>

# and check the data

>zn "MYDATA"
>zw ^myappData
...
```  

---


