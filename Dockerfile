FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install -y \
    g++-10 \
    gcc-10 \
    git \
    gpg \
    ninja-build \
    pkg-config \
    python3 \
    python3-pip \
    ssh \ 
    sudo \ 
    wget

# Install latest CMake
RUN wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | tee /usr/share/keyrings/kitware-archive-keyring.gpg >/dev/null
RUN echo 'deb [signed-by=/usr/share/keyrings/kitware-archive-keyring.gpg] https://apt.kitware.com/ubuntu/ focal main' | tee /etc/apt/sources.list.d/kitware.list >/dev/null
RUN apt-get update
RUN apt-get install -y cmake

# Clean temporary files
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Conan
RUN pip install conan
