FROM ubuntu:bionic

WORKDIR /home/ubuntu/superpeer

ENV DEBIAN_FRONTEND noninteractive

# JDK 8.131
FROM openjdk:8u131

# Initial update
RUN apt-get update

# Ansible
RUN apt-get install software-properties-common --yes && \
    apt-get install ansible --yes

# WGET
RUN apt-get install wget

# Download and install Gradle
RUN wget https://services.gradle.org/distributions/gradle-4.10.2-bin.zip
RUN mkdir /opt/gradle
RUN unzip -d /opt/gradle gradle-4.10.2-bin.zip
ENV PATH /opt/gradle/gradle-4.10.2/bin:$PATH

# Add binary generated with gradle's installDist to PATH
ENV PATH /home/ubuntu/superpeer/build/install/Superpeer/bin:$PATH

# Make install.sh and configure.sh accessible to container
COPY ../install.sh /usr/local/bin/

# backwards compat
RUN ln -s usr/local/bin/install.sh /

COPY ../../../configure.sh /usr/local/bin/

# backwards compat
RUN ln -s usr/local/bin/configure.sh /

EXPOSE 40000/udp

CMD install.sh