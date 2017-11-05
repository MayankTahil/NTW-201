# Provisioning a Sandbox Environment

In this repository's directory, enter the following command: 

```bash
docker-compose run --rm sandbox
```

Inside the container's `/data` directory will be a mapped volume mount to access the repository's file and data within the container. 

If you exit out of this CLI, your sandbox environment will be de-provisioned and you will have to start your work all over again. Simply enter in the command listed at the start of these instructions to re-provision a new environment. 