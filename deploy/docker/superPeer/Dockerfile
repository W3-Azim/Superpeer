FROM ubuntu:bionic

WORKDIR /home/ubuntu/superpeer

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y openjdk-8-jre

COPY Superpeer /usr/bin
RUN chmod +x /usr/bin/Superpeer

EXPOSE 40000/udp
