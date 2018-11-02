FROM ubuntu:bionic

WORKDIR /home/ubuntu/superpeer

ENV DEBIAN_FRONTEND noninteractive

RUN \
apt-get update && \
apt-get install --no-install-recommends -y \
  openjdk-8-jre

# TODO(conorb): copy over Superpeer binary

EXPOSE 40000/udp
