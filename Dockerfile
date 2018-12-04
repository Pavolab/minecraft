FROM alpine:3.8

# Minecraft version
ARG MC_VERSION=1.13.2
ARG MC_JAR_SHA1=3737db93722a9e39eeada7c27e7aca28b144ffa7

# Set jar file URL
ARG JAR_URL=https://launcher.mojang.com/v1/objects/${MC_JAR_SHA1}/server.jar

# Set default JVM options
ENV _JAVA_OPTIONS '-Xms256M -Xmx1024M'

# Add the EULA file
COPY files/eula.txt /etc/minecraft/eula.txt
COPY files/server.properties /etc/minecraft/server.properties

# Add the ops script
COPY files/ops /usr/local/bin/ops
RUN chmod +x /usr/local/bin/ops

# Install dependencies, fetch Minecraft server jar file and chown files
RUN apk add --update ca-certificates openjdk8-jre-base tzdata wget \
    && wget -O /etc/minecraft/minecraft_server.jar ${JAR_URL} \
    && apk del --purge wget && rm -rf /var/cache/apk/* 

# Define volumes
VOLUME /etc/minecraft

# Expose port
EXPOSE 25565

# Set the working dir
WORKDIR /etc/minecraft

# Default run command
CMD ["java", "-jar", "/etc/minecraft/minecraft_server.jar", "nogui"]