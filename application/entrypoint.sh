#!/bin/sh

ENTRYPOINT_CLASS="org.springframework.boot.loader.launch.JarLauncher"

# Execute the JarLauncher with the appropriate JAVA_OPTS and shared archive file
exec java $JAVA_OPTS -XX:SharedArchiveFile=application.jsa -cp . $ENTRYPOINT_CLASS