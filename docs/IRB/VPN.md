# VPN

When working from home or outside the PCB, connecting to the VPN is neeeded in order to have access to resources such as the cluster.

## Linux (Ubuntu 20.04)

1 - Install "Openconnect"

```bash
sudo apt update
sudo apt install openconnect
```

2 - Connect to the VPN

```bash
sudo openconnect --protocol=gp vpnirb.pcb.ub.es
# You can use the parameter --user to automatically enter the username.
```

You can disconnect by just pressing `Ctrl+C`

## Full instructions

[VPN tutorial - pdf](https://drive.google.com/file/d/1-YJJEQLtHlNQ6EX1x1cLLRB6zQdLXrn4/view)

## References

- Miguel Grau
- Carlos López Elorduy
