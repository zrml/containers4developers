FROM intersystems/iris:2019.3.0.302.0

# copying IRIS resources 
USER root
COPY myappInstaller.xml myapp.ro myappZSTU.ro $ISC_PACKAGE_INSTALLDIR/mgr/

# creating directory for MYCODE database that will be created by myappInstaller.xml
# changing ownership of directories & files
RUN mkdir /MYCODE \
    && chown ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /MYCODE \
    && chown ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /usr/irissys/mgr/myappInstaller.xml /usr/irissys/mgr/myapp.ro /usr/irissys/mgr/myappZSTU.ro  \
    #
    # ghost DB for the installer to setup CODE and DATA databases for the **MYAPP** namespace
    # so that the installer can work successfully & create the right mapping
    # this will be removed later in favour of a host bind mount volume for the DATA database
    && mkdir /MYDATA \
    && chown ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /MYDATA
    # add dependencies as needed... 
    # && apt-get update \
    # && apt-get install -y dnsutils

# Create a new CODE db and load the code + mount the DATA db and define the MYAPP namespace + ZSTU
# it's easier with irisowner as it's OS authenticated
USER irisowner
RUN iris start $ISC_PACKAGE_INSTANCENAME \
    && iris session $ISC_PACKAGE_INSTANCENAME -U %SYS "##class(%SYSTEM.OBJ).Load(\"/usr/irissys/mgr/myappInstaller.xml\",\"cdk\")" \
    && iris session $ISC_PACKAGE_INSTANCENAME -U %SYS "##class(App.Installer).implementDesiredSystemState()" \
    && iris session $ISC_PACKAGE_INSTANCENAME -U %SYS "##class(SYS.Container).PreventFailoverMessage()" \
    && iris session $ISC_PACKAGE_INSTANCENAME -U %SYS "##class(SYS.Container).PreventJournalRolloverMessage()" \
    && iris session $ISC_PACKAGE_INSTANCENAME -U %SYS "##class(SYS.Container).SetMonitorStateOK(\"irisowner\")" \
    && iris session $ISC_PACKAGE_INSTANCENAME -U %SYS "##class(SYS.Container).QuiesceForBundling()" \
    && iris session $ISC_PACKAGE_INSTANCENAME -U %SYS "##class(Security.Users).UnExpireUserPasswords(\"*\")" \
    && iris stop $ISC_PACKAGE_INSTANCENAME quietly

# housekeeping
USER root
RUN rm -f $ISC_PACKAGE_INSTALLDIR/mgr/messages.log $ISC_PACKAGE_INSTALLDIR/mgr/alerts.log $ISC_PACKAGE_INSTALLDIR/mgr/IRIS.WIJ $ISC_PACKAGE_INSTALLDIR/mgr/journal/* /MYCODE/iris.lck \
    && rm -fr /MYDATA/* \
    && rmdir /MYDATA 

# resetting the default container user
USER irisowner
