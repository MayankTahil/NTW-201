# Accessing your webmin GUI

### Router 1 (Edge)
**Logon URL:** [`https://localhost:9000`](https://localhost:9000)
**Username:** `root`
**Password:** `pass`

### Router 2
**Logon URL:** [`https://localhost:9001`](https://localhost:9001)
**Username:** `root`
**Password:** `pass`

# Accessing your Nitro IDE to manage CPX Reverse Proxy

**Logon URL:** [`http://localhost:9010`](https://localhost:9010)

> In the CLI pane below, you will notice you are in the `/workspace` directory that is volume mounted to the `./scripts` directory within the module that hosts the `nsAuto.py` that executes NITRO commands to configure the CPX to its desired state based on the `nsAutoCfg.json` file. To learn more about Nitro and this IDE environment, check out more information on [GitHub here](Github.com/Citrix-TechSpecialist/nitro-ide)

# Accessing your containers

If you have [provisioned a sandbox container](../Sandbox.md), you can simply enter the following command to enter the CLI of any infrastructure component. 

```bash
sh <service-name>
```

If you have opted to perform these modules on your local machine directly, you can can simply enter the following command to enter the CLI of any infrastructure component. 

```bash
docker-compse exec <service-name> bash
```