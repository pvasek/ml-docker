# based on https://github.com/pytorch/pytorch/blob/master/Dockerfile
FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04

RUN echo "deb http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1604/x86_64 /" > /etc/apt/sources.list.d/nvidia-ml.list

RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        cmake \
        git \
        curl \
        vim \
        ca-certificates \
        libjpeg-dev \
        imagemagick \
        nano \
        net-tools \
        rtorrent \         
        unzip \
        p7zip-full \
        wget \
        libpng-dev \
        sudo \
        && rm -rf /var/lib/apt/lists/*

ENV PATH /opt/conda/bin:$PATH

RUN curl -sSL https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -o /tmp/miniconda.sh \
    && mkdir /opt/conda \
    && chown root:users /opt/conda \
    && bash /tmp/miniconda.sh -bfp /opt/conda \
    && rm -rf /tmp/miniconda.sh

COPY usr /usr
COPY root /root

WORKDIR /workspace
RUN chmod -R a+w /workspace && chmod -R 775 /usr/bin

# 5678 - python remote debugging: https://docs.microsoft.com/en-us/visualstudio/python/debugging-python-code-on-remote-linux-machines
EXPOSE 5678 8000 8080 8888
