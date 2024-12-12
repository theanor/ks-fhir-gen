ARG IMAGE=intersystemsdc/irishealth-community
ARG VERSION=2024.3
FROM $IMAGE:$VERSION

ARG TESTS=0
ARG MODULE="dc-sample"
ARG NAMESPACE="IRISAPP"

WORKDIR /home/irisowner/dev
ENV HOMEDIR=/home/irisowner/dev
ENV NAMESPACE=$NAMESPACE

## install synthea
ENV JAVA_HOME=/opt/java/openjdk
COPY --from=eclipse-temurin:21 $JAVA_HOME $JAVA_HOME
ENV PATH="${JAVA_HOME}/bin:${PATH}"
COPY synthea synthea

RUN --mount=type=bind,src=.,dst=. <<EOF
iris start IRIS
iris session IRIS < iris.script
([ "$TESTS" -eq 0 ] || iris session iris -U "$NAMESPACE" "##class(%ZPM.PackageManager).Shell(\"test $MODULE -v -only\",1,1)")
iris stop IRIS quietly
EOF
