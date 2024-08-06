#!/bin/bash

#Build our image from Dockerfile
docker build -t msc_project ./

#Run our instance
docker run --name MSc_Project --cpus 8 -m 8GB -it -v ./:/project  msc_project 