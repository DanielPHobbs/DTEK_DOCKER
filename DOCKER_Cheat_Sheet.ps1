#Swarm Mode
#Enable swarm mode:

if(!(docker info).contains("Swarm: active")){
	docker swarm init
}

#Create a custom overlay network:

$network = "network_name"
if(!(docker network ls --filter name=$network -q)){
	docker network create --driver overlay $network
}

#Create and start a service using a custom overlay network:

$service = "service_name"
$network = "network_name"
$image = "image_name"
$replicas = 5
docker service create --name $service --network $network --replicas $replicas $image

#Start a service and expose a port on the host system:

$service = "service_name"
$network = "network_name"
$image = "image_name"
$hostPort = 8080
$servicePort = 80
docker service create --name $service --network $network --publish ${hostPort}:${servicePort} $image

# test port
Start-Sleep -s 5
Test-NetConnection -ComputerName "10.0.75.2" -Port $hostPort -InformationLevel "Detailed"
Start a service and mount a local system directory:

$service = "service_name"
$image = "image_name"
$hostDir = "/c/users/docker/data"
$serviceDir = "/data"
docker service create --mount type=bind,src=$hostDir,dst=$serviceDir --name $service $image

#Start a service and mount a local volume:

$volume = "volume_name"
docker volume create --driver local --name $volume

$service = "service_name"
$image = "image_name"
$serviceDir = "/data"
docker service create --mount type=volume,src=$volume,dst=$serviceDir --name $service $image

#List all matching services:

$service = "service_name_part"
docker service ls --filter name=$service

#Get CPU, memory, network and IO statistics for all running instances of a swarm service:

$service = "service_name"
docker stats $(docker ps -q -f "name=$service") --no-stream 

#Get the virtual IP list of all running instances of a swarm service:

$service = "service_name"
docker inspect --format='{{.Name}}{{range .NetworkSettings.Networks}} IP: {{.IPAMConfig.IPv4Address}} {{end}}' $(docker ps -q -f "name=$service")

#Get the virtual IP of all running instances of a swarm service for a specific overlay network:

$service = "service_name"
$network = "network_name"
$template = '{{.Name}}{{with index .NetworkSettings.Networks \"' + $network + '\"}} {{.IPAddress}}{{end}}';
docker inspect -f $template $(docker ps -q -f "name=$service")

#Get the volume list of all running instances of a swarm service:

$service = "service_name"
docker inspect --format '{{.Name}}{{range .Mounts}} Source: {{.Source}} Destination: {{.Destination}}{{end}}' $(docker ps -q -f "name=$service")

#Remove all instances of a swarm service that aren’t currently running:

$service = "service_name"
docker rm $(docker ps -a -q -f "name=$service" -f "status=exited")

#Update a service:

$service = "service_name"
$image = "image_name"
docker service update --image $image $service

#Stop a service:

$service = "service_name"
docker service scale ${service}=0

#Remove a service:

$service = "service_name"
docker service rm $service
Docker host cleanup

#Remove all stopped containers:

docker rm $(docker ps -a -q -f "status=exited")

#Remove untagged images:

docker rmi $(docker images -q -f "dangling=true")

#Remove orphaned volumes:

docker volume rm $(docker volume ls -q -f "dangling=true")
Containers

#Start a Bash session in a running container:

$container = "container_id"
docker exec -i -t $container /bin/bash

##Stop and remove all containers by image name or image ID:

$image = "image_name"
docker rm $(docker stop $(docker ps -a -q -f "ancestor=$image"))

#Connect to a docker server over TCP:

$env:DOCKER_HOST= "tcp://192.168.1.134:4243"
docker info
Monitoring

#Monitor MobyLinuxVM with cAdvisor container:

docker run -dp 8090:8080 -v /var/run:/var/run:rw -v /sys:/sys:ro -v /var/lib/docker/:/var/lib/docker:ro --name=cadvisor google/cadvisor:latest

#Note that --volume=/:/rootfs:ro mount is not available in Docker for Windows VM, that’s why I removed it from the run command. Access cAdvisor interface on your Windows machine at http://localhost:8090/.

#Aggregate all containers logs with logspout:

$ docker run -dp 8010:80 --name="logspout" --volume=/var/run/docker.sock:/var/run/docker.sock gliderlabs/logspout

#Connect with PowerShell to see your local aggregated logs in realtime:

Invoke-RestMethod http://10.0.75.2:8010/logs