#!/bin/sh

echo "Setting env variables"

export AZ_RESOURCE_GROUP=myapp-jdbc-sql-server
export AZ_DATABASE_NAME=mydatabase-tmp-spring-jdbc-sql-server
export AZ_LOCATION=westeurope
export AZ_SQL_SERVER_USERNAME=Mohammed
export AZ_SQL_SERVER_PASSWORD=Bucharest2018*
export AZ_LOCAL_IP_ADDRESS=$(curl http://whatismyip.akamai.com/)

export SPRING_DATASOURCE_URL="jdbc:sqlserver://$AZ_DATABASE_NAME.database.windows.net:1433;database=demo;encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;loginTimeout=30;"
export SPRING_DATASOURCE_USERNAME=spring@$AZ_DATABASE_NAME
export SPRING_DATASOURCE_PASSWORD=$AZ_SQL_SERVER_PASSWORD