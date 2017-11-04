# Intermediate Networking

Here is a breakdown of the various exercises that can be performed with the provided environment topologies in the `docker-compose.yaml` file. There are three topologies provided where you can investigate network traffic within the docker network: 

### [Topology 1](./Switch)

This topology is a simple environment with a **Client** and **Server** on a single docker network: **NTW-1**. Both entities are local to each other on the same LAN. 
  
  * Explore `arp` commands
  * Explore `ping` commands
  * Expolre `tcpdump` commands
  * Explore `curl` commands

**Client:** Latest [Ubuntu container](./Dockerfile) with basic network utilities installed. 
  
  * Static IP of `192.168.13.5` on the `LAN` network. 

  >See [Instructions](#Instructions) to build you container locally or pull it from dockerhub. 

**Server:** Simple website hosting linux server
  
  * `http` on port `80`
  * `https` on port `443`
  * Static IP of `192.168.13.11` on the `LAN` network. 


### [Topology 2](./Router)

This topology is a simple environment with a **Client**, **Server**, and a **Router** across two docker networks: **NTW-1** and **NTW-2**.
  
  * Explore `arp` commands
  * Explore `ping` commands
  * Expolre `tcpdump` commands
  * Explore `curl` commands
  * Explore `traceroute` commands 
  * Explore `dig` or `nslookup` commands
  * Explore [`route`](https://www.cyberciti.biz/faq/linux-route-add/) commands

**Client:** Latest [Ubuntu container](./Dockerfile) with basic network utilities installed. 
  
  * Static IP of `192.168.13.5` on the `CLIENT` network. 

**Server:** Simple website hosting linux server
  
  * `http` on port `80`
  * `https` on port `443`
  * Static IP of `192.168.14.11` on the `BACKEND` docker network. 

**Router:** [Webmin router](https://hub.docker.com/r/chsliu/docker-webmin/) in a docker container. Admin GUI can be reached at [`https://localhost:1000`](https://localhost:1000)

  * Static IP of `192.168.13.10` on the `CLIENT` network. 
  * Static IP of `192.168.14.10` on the `BACKEND` network.
  * `https` on port `10000` mapped to port `10000` on local host for Admin Management
    > [Logon](https://localhost:1000) using **username:** `root` and **password:** `pass`

### [Topology 3](./Proxy) 

This topology is a simple environment with a **Client**, **Server**, and a **Proxy** across two docker networks: **NTW-1** and **NTW-2**.
  
  * Explore `arp` commands
  * Explore `ping` commands
  * Expolre `tcpdump` commands
  * Explore `curl` commands
  * Explore `traceroute` commands

**Client:** Latest [Ubuntu container](./Dockerfile) with basic network utilities installed. 
  
  * Static IP of `192.168.13.12` on the `CLIENT` network. 

  >See [Instructions](#Instructions) to build you container locally or pull it from dockerhub. 

**Server 1:** Simple website hosting linux server
  
  * `http` on port `80`
  * `https` on port `443`
  * Static IP of `192.168.14.11` on the `SERVER` docker network. 

**Server 2:** Simple website hosting linux server
  
  * `http` on port `80`
  * `https` on port `443`
  * Static IP of `192.168.14.12` on the `SERVER` docker network. 

**Proxy:** [NetScaler ADC](https://hub.docker.com/r/chsliu/docker-webmin/) in a docker container. You can configure LB VIP on CPX's static IP on the `NTW-1` by following [this tutorial](https://github.com/Citrix-TechSpecialist/nitro-ide/#getting-started)

  * Static IP of `192.168.15.10` on the `ADMIN` network. 
  * Static IP of `192.168.13.10` on the `CLIENT` network. 
  * Static IP of `192.168.14.10` on the `SERVER` network.
  * Available ports: `10000-10050` also mapped to host that can be used for endpoints for LB vServers.
  * `http` on port `80` mapped to localhost to validate if CPX is up and running successfully. 

**Cloud9 IDE:**  This is a Web IDE to execute code written with NITRO SDK that will quickly configure NS CPX to LB back end web services and function as a proxy to client requests. Refer to [this tutorial](https://github.com/Citrix-TechSpecialist/nitro-ide/#getting-started) for further details on how it works. 

  * Static IP of `192.168.13.100` on the `NTW-1` network.
  * Static IP of `192.168.14.100` on the `NTW-2` network.
  * `http` on port `9090` mapped to port `80` on local host for IDE access.

  >If required, you can access the IDE web interface at `http://localhost:9090`.  

# Instructions 

### Provisioning Your Environment. 

Within each environment's respective directory (`Switch`, `Router`, `Proxy`) enter the following commands to provision your environment: 

```
# Assuming you are in ./NTW-201/Switch or ./NTW-201/Router or ./NTW-201/Proxy directory, enter: 
docker-compose up -d
```
>**NOTE:** If you are provisioning the `./NTW-201/Proxy` environment, remember to also enter the command: `docker exec -dt proxy_nitro-ide_1 python /workspace/nsAuto.py` to configure your NetScaler CPX as a reverse proxy which load balances your back end web servers. ***Execute this command after 180 sec. which is the approximate time required for the CPX container to initialize***. 

This will spin up configured containers as described above. 

### De-provision your environment

Within the same directory you provisioned the environment, enter the following command: 

```
# Assuming you are in ./NTW-201/Switch or ./NTW-201/Router or ./NTW-201/Proxy directory, enter: 
docker-compose down
```

### Accessing your Client's CLI

Once your containers are running and your environment has provisioned successfully, you can execute into the shell of the Ubuntu client by entering in the following commands: 

```
# Identify the Client container's name and see if the container is running
docker ps -a

>>>

CONTAINER ID        IMAGE                  COMMAND                  CREATED             STATUS              PORTS                      NAMES
319ece0e578f        mayankt/webserver:a    "/bin/sh -c 'nginx'"     19 minutes ago      Up 19 minutes       80/tcp, 443/tcp            router_server_1
c7f5cbca0cdd        mayankt/ubuntu:ntw     "tail -f /dev/null"      19 minutes ago      Up 19 minutes                                  router_client_1
2d461cadd589        chsliu/docker-webmin   "/bin/sh -c '/usr/..."   19 minutes ago      Up 19 minutes       0.0.0.0:10000->10000/tcp   router_router_1

# Execute into the shell of the container
docker exec -it router_client_1 bash
```

# Common Linux Networking Commands 

Below are references to common networking commands to configure your client or to inspect network traffic across the various containers. 

1. .**Display Routing Table:** Enter the following to visualize your local host's routing table. 

    ```
    # Display all of your your routes
    route -n
    
    # You can also use the following to show Kernel IP routing table
    netstat -rn
    ```

2. [**Delete a Route**:](https://serverfault.com/questions/181094/how-do-i-delete-a-route-from-linux-routing-table) Enter the following command to remove a route from your host's local routing table.  

    ```  
    # Delete desired route, for example your default gateway
    route del -net 0.0.0.0 gw 192.168.13.1 netmask 0.0.0.0 dev eth0
    ```

3. [**Aad a Static Route**]()

    ```
    route add -net 192.168.14.0/24 gw 192.168.13.10 dev eth0
    ```

4. **Show Arp Table**: Enter the following command

    ```
    arp
    ```

5. [**Collect Network Trace:**](http://packetlife.net/media/library/12/tcpdump.pdf) Enter the following command to collect all TCP packets in the trace across all interfaces and write out to a `test.pcap` file in the `/tmp` directory that you can open in [WireShark](https://www.wireshark.org/).

    ```
    tcpdump -i any -w /mnt/test.pcap
    ```

6. **Trace route:** Enter the following command to see all your hops across the network to your destination ip

    ```
    traceroute 192.168.14.11
    ```


