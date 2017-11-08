> NOTE: THIS PAGE IS ALSO A WORK IN PROGRESS

# Accessing your webmin GUI

### Router 1 (Edge)
**Logon URL:** [`https://localhost:9000`](https://localhost:9000)
**Username:** `root`
**Password:** `pass`

### Router 2 (Edge)
**Logon URL:** [`https://localhost:9001`](https://localhost:9000)
**Username:** `root`
**Password:** `pass`

# [Step 1] : Instructions for Client

Drop into the client's shell : 

```bash
docker-compose exec client bash

>>

root@Client:/# 
```

Within the client's shell, delete the default route: 

```bash
root@Client:/# route del -net 0.0.0.0
```

Now add a new default route:

```bash
root@Client:/#  route add -net 192.168.14.0/24 gw 192.168.13.10 dev eth0
```

Now exit the client's shell.

```bash
root@Client:/# exit
```

# [Step 2] : Instructions for Edge Router

Drop into the edge router's shell : 
> Ignore any warnings.

```bash
docker-compose exec router-edge bash

>>

root@Client:/# 
```

Within the client's shell, delete the default route: 

```bash
root@Client:/# route del -net 0.0.0.0
```

Now add a new default route:

```bash
root@Client:/#  route add -net 192.168.14.0/24 gw 192.168.13.10 dev eth0
```