
#get current version 
docker --version

## List images available
docker images


#Install and run 2019 core image 
docker run mcr.microsoft.com/windows/servercore:ltsc2019

#Install and run 2019 core image leave running
docker run -it mcr.microsoft.com/windows/servercore:ltsc2019

# gives status of containers running on docker
docker ps
