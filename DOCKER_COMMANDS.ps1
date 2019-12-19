
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


docker run mcr.microsoft.com/windows/nanoserver:1903 

docker run -it mcr.microsoft.com/windows/nanoserver:1809 powershell

docker run -it microsoft/nanoserver-insider-powershell powershell -c '$psversiontable' #fails 

Docker run -d -p 8080:80 --name iis microsoft/iis -latest

