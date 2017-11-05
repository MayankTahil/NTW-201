# Introduction

![Topology-2](../images/topology-2.png)

This topology is a simple environment with a **Client**, **Server**, and a **Router** across two docker networks: **CLIENT** and **BACKEND**.
  
* Explore `arp` commands
* Explore `ping` commands
* Expolre `tcpdump` commands
* Explore `curl` commands
* Explore `traceroute` commands 
* Explore [`route`](https://www.cyberciti.biz/faq/linux-route-add/) commands

**Client:** Latest [Ubuntu container](./Dockerfile) with basic network utilities installed. 
  
  * Static IP of `192.168.13.5` on the `CLIENT` network. 

**Server:** Simple website hosting linux server
  
* `http` on port `80`
* `https` on port `443`
* Static IP of `192.168.14.11` on the `BACKEND` docker network. 

**Router:** [Webmin router](https://hub.docker.com/r/chsliu/docker-webmin/) in a docker container. Admin GUI can be reached at [`https://localhost:1000`](https://localhost:1000)

# Instructions 

### Attach to the container's CLI by entering the following command within this directory: 

```bash
docker-compose exec <service-name> bash
```

Values for `<service-name>` consist of: 

* client
* server
* router

### **Step 1:** Observe the following in the Client machine

1. route table
	* `route`
2. arp table
	* `arp -a`
3. network configurations
  * `ifconfig eth0` or `ip a show eth0`
	  - IP
	  - MAC

### **Step 2:** Observe the following in the Server machine

1. route table
	* `route`
2. arp table
	* `arp -a`
3. network configurations
  * `ifconfig eth0` or `ip a show eth0`
	  - IP
	  - MAC

### **Step 3:** Ping the Server from the Client machine

```bash
ping 192.168.14.11
```

### **Step 4:** Add a route on the Client machine to resolve `192.168.14.0/24` network.

```bash
route add -net 192.168.14.0/24 gw 192.168.13.10 dev eth0
```

### **Step 5:** Add a route on the Server machine to resolve `192.168.13.0/24` network.

```bash
route add -net 192.168.13.0/24 gw 192.168.14.10 dev eth0
```

### **Step 6:** Ping the Server from the Client machine

```bash
ping 192.168.14.11
```

### **Step 7:** Ping the Client from the Server machine

```bash
ping 192.168.13.5
```

### **Step 8:** Observer the arp table in both Client and Server machine

```bash
arp -a
```

### **Step 9:** Collect packet capture of Client's `ping` to Server machine from the Router
	
```bash
tcpdump -i any -w /mnt/router-ping.pcap
```

- Observe the trace in wireshark
- Filter for ICMP packet
- Observe MAC SRC
- Observe IP DST
- Observe IP SRC

### **Step 10:** Collect packet capture of Client's `curl` request to Server machine from the Router

```bash
tcpdump -i any -w /mnt/router-curl.pcap
```

- Observe the trace in wireshark
- [Filter](https://www.wireshark.org/docs/dfref/) for `ip.addr==192.168.13.5` 
- Observe MAC DST 
- Observe IP DST
- Observe IP SRC
- Observe Port DST
- Observe Port SRC
- Observe HTTP content  