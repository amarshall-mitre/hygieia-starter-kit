#!/bin/sh

/usr/bin/java -Dserver.port=8081 -Djavax.net.ssl.trustStore=/usr/lib/jvm/java-openjdk/jre/lib/security/cacerts -Dlogging.config=file:/hygieia/collectors/logback.xml -jar /hygieia/collectors/gitlab-scm-collector.jar --spring.config.name=gitlab --spring.config.location=/hygieia/application.properties