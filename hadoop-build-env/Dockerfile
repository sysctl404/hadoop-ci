FROM ubuntu:bionic

WORKDIR /root

RUN apt-get update && apt-get install -y \
    curl git openjdk-8-jdk maven build-essential autoconf automake libtool cmake zlib1g-dev pkg-config libssl-dev libsasl2-dev software-properties-common && \
    add-apt-repository -y ppa:ubuntu-toolchain-r/test && \
    apt-get update && apt-get -y install g++-9 gcc-9 && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 60 --slave /usr/bin/g++ g++ /usr/bin/g++-9 && \
    apt-get clean && apt-get remove --purge --auto-remove -y && rm -rf /var/lib/apt/lists/* && \
    update-alternatives --set java $(update-alternatives --list java | grep java-8) && \
# Install cmake
    curl -L https://cmake.org/files/v3.19/cmake-3.19.0.tar.gz > cmake-3.19.0.tar.gz && \
    tar -zxvf cmake-3.19.0.tar.gz && cd cmake-3.19.0 && \
    ./bootstrap && make -j$(nproc) && make install && cd ../ && rm cmake-3.19.0.tar.gz && rm -rf cmake-3.19.0 && \
# Install protobuf    
    curl -L -s -S https://github.com/protocolbuffers/protobuf/releases/download/v2.5.0/protobuf-2.5.0.tar.gz -o protobuf-2.5.0.tar.gz && \
    mkdir protobuf-2.5-src && tar xzf protobuf-2.5.0.tar.gz --strip-components 1 -C protobuf-2.5-src && cd protobuf-2.5-src && \
    ./configure && make -j$(nproc) && make install && ldconfig && cd ../ && rm protobuf-2.5.0.tar.gz && rm -rf protobuf-2.5-src && \
# Install boost
    curl -L https://sourceforge.net/projects/boost/files/boost/1.72.0/boost_1_72_0.tar.bz2/download > boost_1_72_0.tar.bz2 && \
    tar --bzip2 -xf boost_1_72_0.tar.bz2 && cd boost_1_72_0 && \
    ./bootstrap.sh --prefix=/usr/ && ./b2 --without-python && ./b2 --without-python install && cd ../ && rm boost_1_72_0.tar.bz2 && rm -rf cd boost_1_72_0