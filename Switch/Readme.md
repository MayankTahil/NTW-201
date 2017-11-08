# Introduction 

This is an overview of the network topology that we will be provisioning to analyze network traffic between a client and a Server connected to the same L2 Switch. 

![Topology-1](../images/topology-1.png)

This topology is a simple environment with a **Client** and **Server** on a single, flat LAN network: **LAN**. 
  
  * Explore `arp` commands
  * Explore `ping` commands
  * Expolre `tcpdump` commands
  * Explore `curl` commands
  * Explore capturing a network trace from the Client and from the Server

**Client:** Latest [Ubuntu machine](./Client.dockerfile) with basic network utilities installed. 
  
  * Static IP of `192.168.13.5` on the `LAN` network. 

**Server:** Simple website hosting [linux server](./Server-a.dockerfile)
  
  * `http` on port `80`
  * `https` on port `443`
  * Static IP of `192.168.13.11` on the `LAN` network. 

# Instructions 

### Attach to the desired container's CLI: 

Within the module's respective directory, enter the following if you are in the sandbox container: 

```bash
sh <service-name>
```

Otherwise enter the following on your local machine: 

```bash
docker-compose exec <service-name> bash
```

Values for `<service-name>` consist of: 

* client
* server

## **Step 1:** Observe the following in the Client machine

1. route table
	* `route`
2. arp table
	* `arp -a`
3. network configurations
  * `ifconfig`
	  - IP
	  - MAC

### **Step 2:** Observe the following in the Server machine

1. route table
	* `route`
2. arp table
	* `arp -a`
3. network configurations
  * `ifconfig eth0`
	  - IP
	  - MAC

### **Step 3:** Ping the Server from the Client machine

```bash
ping 192.168.14.11
```

### **Step 4:** Observer the arp table in both Client and Server machine

```bash
arp -n
```

### **Step 5:** Collect packet capture of Client's `ping` to Server machine from the Client machine
	
```bash
tcpdump -i any -w /mnt/client-ping.pcap
```

- Observe the trace in wireshark
- Filter for ICMP packet
- Observe MAC DST 
- Observe IP DST
- Observe IP SRC

### **Step 6:** Collect packet capture of Client's `curl` request to Server machine from the Client machine

```bash
# On the Client
curl http://server
```

```bash
# On the Server
tcpdump -i any -w /mnt/client-curl.pcap
```

- Observe the trace in wireshark
- Filter for `ip.addr==192.168.13.5` 
- Observe MAC DST 
- Observe IP DST
- Observe IP SRC
- Observe Port DST
- Observe Port SRC
- Observe HTTP content  