FROM --platform=linux/amd64 continuumio/miniconda3

RUN apt-get -y update

# Set up our conda environment
WORKDIR ./
RUN mkdir project
COPY snippy.yml ./
COPY panaroo.yml ./
COPY roary.yml ./
COPY ./workflow.sh ./project
RUN conda env create --f snippy.yml; conda env create --f panaroo.yml; conda env create --f roary.yml

