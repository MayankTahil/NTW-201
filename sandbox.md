# Provisioning a Sandbox Environment

In this repository's directory, enter the following command: 

```bash
docker-compose up -d sandbox
```

Then check if the container is running by entering the following command: 

```bash
docker ps 

> 

CONTAINER ID        IMAGE               COMMAND                  CREATED                  STATUS              PORTS                                        NAMES
77692d5040b9        ntw-201:sandbox     "dockerd-entrypoin..."   Less than a second ago   Up 2 seconds        2375/tcp, 0.0.0.0:9000-9010->9000-9010/tcp   ntw201_sandbox_1
```

You can drop into the container's CLI anytime by entering the following command within this repository's directory. 

```bash 
docker-compose exec sandbox bash
```

Inside the container's `/data` directory will be a mapped volume mount to access the repository's file and data within the container. 

# De-provision your Sandbox Environment 

within this repository's directory, enter the following command: 

```bash 
docker-compose down
```
