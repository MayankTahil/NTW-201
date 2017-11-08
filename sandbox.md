# Provisioning a Sandbox Environment

In this repository's directory, enter the following command: 

```bash
docker-compose up -d sandbox
```

Then check if the container is running by entering the following command: 

```bash
docker-compose ps 
```

You can drop into the sandbox container's CLI anytime by entering the following command within this repository's directory. 

```bash 
docker-compose exec sandbox bash
```

Inside the container's `/data` directory will be a mapped volume mount to access the local repository's file and data within the container. 

From within this sandbox container, you can `cd` into each respective module and execute commands like : 

Command | Details
--- | --- 
`docker-compose up -d` | To provision the module's infrastructure components.
`sh <service-name>` | To enter the bash shell of the service. Depending on your topology, values of `<service-name>` are included below. 

### Services

* client
* server
* server-a
* server-b
* router
* edge-router
* router-2
* cpx
* nitro-ide

> Check within the `docker-compose.yaml` file within each module's directory to see a list of all services within the topology.

# De-provision your Sandbox Environment 

Within this repository's directory on the local machine, enter the following command: 

```bash 
docker-compose down
```
 
This command will remove your sandbox container and everything within it. 