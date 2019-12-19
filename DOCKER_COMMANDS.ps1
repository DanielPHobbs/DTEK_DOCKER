
#get current version 
docker --version

## List images available
docker images


#Install and run 2019 core image 
docker run mcr.microsoft.com/windows/servercore:ltsc2019

#Install and run 2019 core image leave running
docker run -it mcr.microsoft.com/windows/servercore:ltsc2019

# gives status of containers running on dockercls
docker ps


Docker run -it microsoft/nanoserver powershell.exe

Docker run -d -p 8080:80 --name iis microsoft/iis -latest

