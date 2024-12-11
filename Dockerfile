ARG IMAGE=intersystemsdc/irishealth-community
ARG VERSION=latest
FROM $IMAGE:$VERSION

ENV JAVA_HOME=/opt/java/openjdk
COPY --from=eclipse-temurin:21 $JAVA_HOME $JAVA_HOME
ENV PATH="${JAVA_HOME}/bin:${PATH}"

USER root

WORKDIR /opt/irisbuild
RUN chown -R ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /opt/irisbuild

USER ${ISC_PACKAGE_MGRUSER}

COPY synthea synthea
COPY src src
# COPY module.xml module.xml
COPY iris.script iris.script

USER root
RUN chown -R ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /opt/irisbuild
USER ${ISC_PACKAGE_MGRUSER}

RUN <<EOF
cd synthea
./run_synthea -s 12345 -p 10
cd ..
iris start IRIS
iris session IRIS < iris.script
iris stop IRIS quietly
EOF
