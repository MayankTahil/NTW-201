![Topology-3](../images/topology-3.png)

This topology is a simple environment with a **Client**, **Server-a**, **Server-b** and a **Reverse Proxy** across two docker networks: **CLIENT** and **BACKEND**.

> Note: There is another network **ADMIN** for management of NetScaler (NSIP). There is also an IDE in this network pushing configs via Nitro to NetScaler CPX for Load balancing. This network is irrelevant for the purpose of investigating network traffic.
  
  * Explore `arp` commands
  * Explore `ping` commands
  * Expolre `tcpdump` commands
  * Explore `curl` commands
  * Explore `traceroute` commands

**Client:** Latest [Ubuntu container](./Dockerfile) with basic network utilities installed. 
  
  * Static IP of `192.168.13.12` on the `CLIENT` network. 

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

  >If required, you can access the IDE web interface at `http://localhost:9000`.

  >**NOTE:** If you are provisioning the `./Proxy` environment, remember to also enter the command: 
  ```bash
  docker-compose exec nitro-ide python /workspace/nsAuto.py
  ```
  This will configure your NetScaler CPX as a reverse proxy which load balances your back end web servers. 
  ***Execute this command after 180 sec. which is the approximate time required for the CPX container to initialize***. 

### Access Cloud9 IDE 

**Logon URL:** [`http://localhost:9000`](http://localhost:9000)

### Access Load Balancing End Point (NetScaler VIP)

**VIP:** [`http://localhost:9002`](http://localhost:9002)

> From the client you can send a curl request to see the HTML content of the Load Balanced Page by entering in the following command: `curl http://cpx:9002/` 

