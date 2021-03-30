#!/bin/sh

/usr/bin/java -Dserver.port=8080 -Dlogging.config=file:/hygieia/api/logback_api.xml -jar /hygieia/api/api.jar --spring.config.name=api --spring.config.location=/hygieia/application.properties