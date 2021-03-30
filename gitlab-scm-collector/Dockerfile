# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM registry1.dso.mil/ironbank/redhat/openjdk/openjdk8

ARG GITLAB_SCM_VERSION=3.1.0

ENV container docker

USER 0

RUN mkdir -p /hygieia/logs; \
mkdir -p /hygieia/collectors/; \
mkdir -p /hygieia/cacerts

# Pulls GitLab Collector jar
RUN curl -o /hygieia/collectors/gitlab-scm-collector.jar https://repo.maven.apache.org/maven2/com/capitalone/dashboard/gitlab-scm-collector/${GITLAB_SCM_VERSION}/gitlab-scm-collector-${GITLAB_SCM_VERSION}.jar

EXPOSE 8080

ENV JAVA_HOME /usr/lib/jvm/java-openjdk
ENV PROP_FILE /hygieia/application.properties


COPY logback.xml /hygieia/collectors/
COPY properties-builder.sh /hygieia/

COPY entrypoint.sh /hygieia/collectors

# For adding certs
RUN ls -1 /hygieia/cacerts | while read cert; do \
       openssl x509 -outform der -in /hygieia/cacerts/$cert -out $cert.der; \
       $JAVA_HOME/bin/keytool -import -alias $cert -keystore $JAVA_HOME/jre/lib/security/cacerts -trustcacerts -file $cert.der -storepass changeit -noprompt; \
       rm $cert.der; \
   done

WORKDIR /hygieia/
RUN chmod 777 properties-builder.sh
RUN chmod 777 collectors/entrypoint.sh

RUN /bin/sh /hygieia/properties-builder.sh

RUN chown -R 1001 /hygieia

USER 1001

ENTRYPOINT ["/hygieia/collectors/entrypoint.sh"]
