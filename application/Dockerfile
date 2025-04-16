FROM eclipse-temurin:21-jre

USER root

# Update package lists and install packages using apt-get
RUN apt-get update && \
    apt-get install -y nano vim procps && \
    apt-get install -y --no-install-recommends ca-certificates && \
    # Clean up to reduce layer size
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Add user and group
RUN groupadd app -g 1001 && \
    useradd -u 1001 -g app appuser

#IMPORT GC CA CERT
#COPY GC_CA.crt /tmp/GC_CA.crt
#RUN keytool -import -trustcacerts -file /tmp/GC_CA.crt -cacerts -storepass changeit -noprompt
# DNS cache configuration
RUN sed -i 's/#networkaddress.cache.ttl=-1/networkaddress.cache.ttl=60/' $JAVA_HOME/conf/security/java.security



WORKDIR "/"
RUN mkdir -p /home/default
RUN chown -R appuser:app /home/default
USER 1001
################################### end of java-base dockerfile #######################################################

VOLUME /tmp
ENV JAVA_OPTS=""

ARG JAVA_VERSION=${JAVA_VERSION}
LABEL java.version=${JAVA_VERSION}
RUN mkdir -p /home/default/app
WORKDIR /home/default/app
ARG HOMEDIR=/home/default
ARG LAYER_LOCATION=build/libs/extracted
COPY  ${LAYER_LOCATION}/dependencies/ .
COPY  ${LAYER_LOCATION}/snapshot-dependencies/ ./
COPY  ${LAYER_LOCATION}/spring-boot-loader/ ./
COPY  ${LAYER_LOCATION}/application/ ./
#COPY  ${WORKDIR}/application.jsa ./
COPY --chmod=755 entrypoint.sh /home/default/app/entrypoint.sh

ENTRYPOINT ["/home/default/app/entrypoint.sh"]