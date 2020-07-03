FROM sonatype/nexus3:3.24.0
USER root
RUN yum install -y rsync
COPY entrypoint.sh /tmp/
RUN chmod g+w /etc/passwd && chmod g+x /tmp/entrypoint.sh
ENV SONATYPE_WORK /sonatype-work
VOLUME ${SONATYPE_WORK}
EXPOSE 8081
WORKDIR /opt/sonatype/nexus
USER nexus
ENV CONTEXT_PATH /nexus
ENV MAX_HEAP 768m
ENV MIN_HEAP 256m
ENV JAVA_OPTS -server -Djava.net.preferIPv4Stack=true
ENV LAUNCHER_CONF="/opt/sonatype/nexus/etc/jetty/jetty.xml /opt/sonatype/nexus/etc/jetty/jetty-requestlog.xml"
USER 56456
CMD /tmp/entrypoint.sh
