FROM ubuntu:bionic

WORKDIR /home/ubuntu/parity

ENV DEBIAN_FRONTEND noninteractive

# Parity expects libssl shared object
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository 'deb http://ca.archive.ubuntu.com/ubuntu/ bionic main' && \
    add-apt-repository 'deb http://us.archive.ubuntu.com/ubuntu/ bionic main' && \
    apt-get install -y libssl1.0.0 libssl-dev

# Install & run Parity
COPY parity /usr/bin
RUN chmod +x /usr/bin/parity
CMD parity --geth --chain kovan --force-ui --reseal-min-period 0 --jsonrpc-cors "*" --jsonrpc-apis web3,eth,net,parity,traces,rpc,personal --jsonrpc-interface all &> parity.log &