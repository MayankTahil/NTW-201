# Common Linux Networking Commands 

Below are references to common networking commands to configure your client or to inspect network traffic across the various containers. 

# Investigating L2 networking
---

### **Show Arp Table**

Enter the following command to see the list of local MAC to IP translations. 

```bash
arp -n
```

# Investigating L3 networking
---

### **Display Routing Table**

Enter the following to visualize your local host's routing table. 

```bash
route -n
```

You can also use the following to show Kernel IP routing table

```bash
netstat -rn
```

### [**Delete a Static Route**](https://serverfault.com/questions/181094/how-do-i-delete-a-route-from-linux-routing-table) 

Enter the following command to remove a route from your host's local routing table. Delete your desired route, for example your default gateway shown in the following example.

```bash
route del -net 0.0.0.0 gw 192.168.13.1 netmask 0.0.0.0 dev eth0
```

### [**Add a Static Route**](https://www.cyberciti.biz/faq/linux-route-add/)

In the following example, you are adding a route to the `192.168.14.0/24` network via the `192.168.13.10` gateway using `eth0`. 

```bash
route add -net 192.168.14.0/24 gw 192.168.13.10 dev eth0
```

### **Traceroute** 

Enter the following command to see all your gateway hops across the network to your destination ip

```bash
traceroute 192.168.14.11
```

# Investigating L2-L7 networking
---

### **Ping a host**

Enter the following commands to send a ping request to a specific host. This command is commonly used to check general connectivity to a desired host. 

```bash
ping 192.168.14.11
```

If DNS works properly, you can use hostnames as well. 

```bash
ping server
```

> Note: Ping will help populate your local ARP Table

### Check if a Port is Open on a Host

Enter the following command to see if a port on a desired host is listening for traffic. This will help identify if a service is bond and running on that host on that port or not. 

```bash
telnet 192.168.14.11 443
```

### [**Collect Network Trace**](http://packetlife.net/media/library/12/tcpdump.pdf) 

Enter the following command to collect all network packets across all interfaces and write out to a `test.pcap` file in the `/mnt` directory that you can open in [WireShark](https://www.wireshark.org/).

> Note: All files saved in `/mnt` within provisioned containers will be saved in `<topology>/traces` directory that can be accessed from the sandbox contianer as well as the local host machine. To analyze traces, open the following file `<repository>/<topology>/traces/test.pcap` on your local machine with wireshark. 

```bash
tcpdump -i any -w /mnt/test.pcap
```

### Analyze Server Certificate Presented to Client 

```bash 
echo | openssl s_client -showcerts -servername server -connect server:443 2>/dev/null | openssl x509 -inform pem -noout -text 
```
> Note: `server` is the hostname of the target webserver. You can substitute any FQDN hosting HTTPS for `server` in the above command.

# Other Commands
---

These commands are not necessarily required for linux networking but rather reference commands that you can use to within modules to make life easier. 

### Autoconfigure Configure NetScaler CPX 

This command targets the desired CPX and configures required settings to function as a reverse proxy and Load Balancer within these environments. 

```bash 
docker-compose exec nitro-ide python /workspace/nsAuto.py
```

> You want to execute this command within the module's directory. It will execute the `./scripts/nsAuto.py` python script to configure the CPX to it's desired state as defined by the `ns.AutoCfg.json` file. You can also view an IDE to interact with the code and JSON file by navigating on your local machine to [`http://localhost:9010`](http://localhost:9010). 

### Reset your provisioned module 

Within the module's directory, enter the following 2 commands to de-provision your topology and re-build docker images for a clean, baseline environment. 

```bash
docker-compose down 
docker-compose up -d --build
```
