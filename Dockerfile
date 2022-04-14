# docker build -t snslab/srsenb .
# docker run --name=srsenb --privileged snslab/srsenb
FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive

# Dependencies for the UHD driver for the USRP hardware
RUN apt-get update && \
    apt-get -yq install libzmq3-dev && \
    apt-get -yq install cmake git libfftw3-dev libmbedtls-dev libboost-program-options-dev libconfig++-dev libsctp-dev libuhd-dev iproute2

RUN git clone https://github.com/zeromq/libzmq.git && \
    cd libzmq && \
    apt-get install -y libtool && \
    ./autogen.sh && \
    apt-get install g++ && \
    ./configure && \
    make && \
    make install && \
    ldconfig

RUN git clone https://github.com/zeromq/czmq.git && \
    cd czmq && \
    ./autogen.sh && \
    ./configure && \
    make && \
    make install && \
    ldconfig

# Fetching empower-enb-agent
RUN git clone https://github.com/5g-empower/empower-enb-agent.git
RUN cd empower-enb-agent && \
    cmake -DCMAKE_BUILD_TYPE=Release . && \
    make && \
    make install

# Fetching srsRAN
RUN git clone https://github.com/5g-empower/srsRAN.git && \
    cd srsRAN && \
    git checkout agent && \
    mkdir build && \
    cd build && \
    cmake ../ && \
    make

# Add configuration files from SRS
ADD conf/. /etc/srsran/

# Add Kubernetes launch scripts
# ADD dns_replace.sh /

# Set env variables
# ENV enb_id=0x19B01
# ENV mcc=901
# ENV mnc=70
# ENV n_prb=50
# ENV mme_addr = EPC_REPLACE


# Add launcher script
ADD run.sh /

ADD launcher.sh /

# Run the launcher script
# ENTRYPOINT ["bash","/launcher.sh"]