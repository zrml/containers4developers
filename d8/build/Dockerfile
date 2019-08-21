FROM  intersystems/iris:2019.3.0.302.0

USER root
RUN sed -i -e 's/MaxServerConn=.*/MaxServerConn=12/g' /usr/irissys/iris.cpf \
    && sed -i -e 's/MaxServers=.*/MaxServers=12/g' /usr/irissys/iris.cpf \
    && chown ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /usr/irissys/iris.cpf

USER irisowner
RUN iris start IRIS \
    && iris session $ISC_PACKAGE_INSTANCENAME -U %SYS "##class(%SYSTEM.Sharding).EnableSharding()" \
    && iris session $ISC_PACKAGE_INSTANCENAME -U %SYS "##class(SYS.Container).QuiesceForBundling()" \
    && iris session $ISC_PACKAGE_INSTANCENAME -U %SYS "##class(SYS.Container).SetMonitorStateOK(\"irisowner\")" \
    && iris session $ISC_PACKAGE_INSTANCENAME -U %SYS "##class(Security.Users).UnExpireUserPasswords(\"*\")" \
    && iris stop IRIS quietly

# housekeeping
USER root
RUN rm -f $ISC_PACKAGE_INSTALLDIR/mgr/messages.log $ISC_PACKAGE_INSTALLDIR/mgr/alerts.log $ISC_PACKAGE_INSTALLDIR/mgr/IRIS.WIJ $ISC_PACKAGE_INSTALLDIR/mgr/journal/*

# resetting the default container user
USER irisowner
