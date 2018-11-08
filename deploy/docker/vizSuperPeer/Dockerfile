FROM ubuntu:bionic

WORKDIR /home/ubuntu/superpeer

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository 'deb http://ca.archive.ubuntu.com/ubuntu/ bionic main' && \
    apt-get install -y openjdk-8-jre

COPY Superpeer /usr/bin/Superpeer
RUN chmod -R +x /usr/bin/Superpeer

EXPOSE 40000/udp
CMD "./usr/bin/Superpeer/bin/Superpeer"