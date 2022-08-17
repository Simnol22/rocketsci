ARG DISTRO

FROM ubuntu:${DISTRO} AS base

ARG DISTRO
ARG COMPILER

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install -y \
    git \
    gpg \
    ninja-build \
    pkg-config \
    python3 \
    python3-pip \
    ssh \ 
    sudo \ 
    wget

RUN apt-get install -y g++-${COMPILER} gcc-${COMPILER}
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-${COMPILER} 10
RUN update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-${COMPILER} 10

# # Install latest CMake
RUN wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | tee /usr/share/keyrings/kitware-archive-keyring.gpg >/dev/null
RUN echo "deb [signed-by=/usr/share/keyrings/kitware-archive-keyring.gpg] https://apt.kitware.com/ubuntu/ ${DISTRO} main" | tee /etc/apt/sources.list.d/kitware.list >/dev/null
RUN apt-get update
RUN apt-get install -y cmake

# Clean temporary files
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Conan
RUN pip install conan
RUN conan profile new default --detect
