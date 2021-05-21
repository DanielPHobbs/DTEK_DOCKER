#get current version 
docker --version

## List images available
docker images

Docker attach aa0e977ecedf


# gives status of containers running on docker
docker ps
docker ps -a

docker stop 90127752a705

#If we want to access a running container and run a command, we can do it in the following way.

docker exec -it container_id cmd/powershell
kubectl exec -it container_id -- cmd/powershell


docker pull mcr.microsoft.com/powershell