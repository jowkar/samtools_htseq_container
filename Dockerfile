FROM ubuntu:20.04

# Install prerequisites
RUN apt-get update && \
    apt-get install -y wget bzip2 && \
    apt-get clean

# Install Miniconda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh

# Set path to conda
ENV PATH /opt/conda/bin:$PATH

# Update conda and install tools
RUN conda update -n base -c defaults conda && \
    conda create -n htseq_env python=2.7 && \
    conda run -n htseq_env conda install -y -c bioconda -c conda-forge htseq=0.6.1.post1 && \
    conda create -n samtools_env samtools=1.14 -c bioconda -c conda-forge
