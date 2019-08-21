
# Use Case
How about importing my IRIS Object Script application code?

# Exposed Tech
+ Creating my container with my IRIS ObjectScript code
+ Creating a **MYCODE** only DB (see [separation of concerns](https://en.wikipedia.org/wiki/Separation_of_concerns) between code and data) in the container
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
	a) the InterSystems IRIS *2019.3 Preview* and  
	b) a valid *iris.key* 
	+ as soon as the 2019.3 CE edition will be published the requirements can be ignored. IOW as soon as the InterSystems IRIS 2019.3 Community Edition will be available [in the Docker Hub Registry](https://hub.docker.com/_/intersystems-iris-data-platform), you will not need the Preview version nor the key.

```
$ ./buildContainer.sh  
$ ./run.sh
```

---


