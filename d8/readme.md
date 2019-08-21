# Use Case
I understand how to work with a single container but I work with multiple InterSystems IRIS services.  
At times I need several instances as I work with shards, ECP, http, webgateway, InterSystems API Manager (IAM), Mirroring, etc.    
As a developer I need to be able to create a "cluster" on my laptop. The cloud is nice but...

# Exposed Tech
+ Build the solution with Docker Compose
	+ Docker Compose allows you to define a local composition of containers on a single host
+ Example of a local InterSystems IRIS shard cluster

# Focus
+ Requirements:
	+ Make sure you have *Docker Compose* installed
		+ Simply run ```$ docker-compose``` and you should see the default output illustrating the available flags
		+ Alternatively just [install it](https://docs.docker.com/compose/install/) as it's super useful and helpful
	+ Make sure you have a non-CE version of InterSystems IRIS (and specify it in the ```./build/Dockerfile``` declaration
	+ Make sure you have a valid *iris.key* with the sharding feature enabled
+ View the **docker-compose.yml** declaration
	+ It describe *3 InterSytems IRIS instances* running in their respective containers.
+ Initially, as the container does not exist, it builds it.
	+ you can find the information of what it builds in the ```./build``` subdirectory *Dockerfile*
	+ it builds an InterSystems IRIS container image ready to work as a shard instances
+ By running the **run.sh** shell scripts in the directory ```./d8``` you bring up (run) the **docker-compose** definition
+ Allow few seconds for the instances to connect to each other and then
+ Connect to the [first node portal](http://localhost:9012/csp/sys/utilhome.csp) with
+ Credentials _SYSTEM/SYS
+ Go and check that the 3 shard instances are all configured
	+ Navigate to *System > Configuration > Sharding Configuration* and
	+ Select *IRISCLUSTER* in the namespace. You should see the 3 IRIS instances
+ Run the following SQL to satisfy yourself that the shards are correctly configured
	+ Navigate to *System > SQL*, Switch namespace to IRISCLUSTER and 
	+ Create a sharded Table ```CREATE TABLE T1 (name char(20), tel int, shard)```  
	+ Then quickly SQL INSERT some data from the SQL Shell
	+ from your host OS level get to the InterSystems IRIS SQL shell in the last shard for example  
	
	```
	$ docker exec -it d8_iris3_1 iris session iris
	>zn "IRISCLUSTER"
	>do $system.SQL.Shell()
	>>
	```
	+ and copy/paste the following SQL INSERT statements
	
	```SQL  
INSERT INTO T1 VALUES('John', 1111) 
INSERT INTO T1 VALUES('Scott', 1144)  
INSERT INTO T1 VALUES('Simon', 1122)  
INSERT INTO T1 VALUES('Fred', 1133)  
INSERT INTO T1 VALUES('Raj', 1155)  
INSERT INTO T1 VALUES('Craig', 1156)  
INSERT INTO T1 VALUES('Patrick', 1157)  
INSERT INTO T1 VALUES('Thomas', 1158)  
INSERT INTO T1 VALUES('Carmen', 1159)  
INSERT INTO T1 VALUES('Andreas', 1166)  
INSERT INTO T1 VALUES('Benjamin', 1177)  
INSERT INTO T1 VALUES('Stefan', 1188)  
INSERT INTO T1 VALUES('Luca', 1199)  
INSERT INTO T1 VALUES('Joe', 1145)  
INSERT INTO T1 VALUES('Jeff', 1300)  
INSERT INTO T1 VALUES('Sylvain', 1200)  
INSERT INTO T1 VALUES('Daniel', 1211)  
INSERT INTO T1 VALUES('Davide', 1222)  
INSERT INTO T1 VALUES('Alex', 1233)  
INSERT INTO T1 VALUES('Zorro', 1244)  
INSERT INTO T1 VALUES('Lee', 1255)  
INSERT INTO T1 VALUES('Dave', 1260)  
INSERT INTO T1 VALUES('Jamie', 1265)  
INSERT INTO T1 VALUES('Tom', 1270)  
INSERT INTO T1 VALUES('Mary', 1272)  
INSERT INTO T1 VALUES('Monica', 1273)  
INSERT INTO T1 VALUES('Nicole', 1280)  
INSERT INTO T1 VALUES('Arieli', 1281)  
INSERT INTO T1 VALUES('Brigitte', 1282)  
INSERT INTO T1 VALUES('Anastasia', 1283)  
INSERT INTO T1 VALUES('Christian', 1290)  
INSERT INTO T1 VALUES('Steven', 1291)  
INSERT INTO T1 VALUES('Helen', 1146)  
	```
+ Go back to your browser portal in *System > SQL* in namespace IRISCLUSTER and make sure you can see the data  

```
SELECT *
FROM T1
ORDER BY Name
```
+ Congrats! :-) You have an InterSystems shard cluster running on your laptop
+ to bring it all down just  

```
$ docker-compose down
```
---
