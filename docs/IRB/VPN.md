# VPN

When working from home or outside the PCB, connecting to the VPN is neeeded in order to have access to resources such
as the cluster.

## First Things First - Install the Forticlient

1. Go to [https://www.fortinet.com/support/product-downloads#vpn](https://www.fortinet.com/support/product-downloads#vpn)
2. Download the FortiClient VPN
   ![forticlient_web](assets/forticlient_web.png)

3. Once it is installed, if you are on Ubuntu, run:
   ```sh
   sudo su
   mkdir -p /etc/systemd/resolved.conf.d && echo -e "[Resolve]\nDNS=10.10.16.4\nDomains=~sc.irbbarcelona.org" >  /etc/systemd/resolved.conf.d/vpn.conf && systemctl restart systemd-resolved
   ```
4. Download [this configuration file](https://drive.google.com/file/d/11XyRfBM4eGn08a3qsiKY1PLBa7DIBTuS/view?usp=drive_link) in your computer.
5. Install it by either double-clicking it or running the command:
   ```sh
   sudo apt-get install ./<your-downloaded-forticlient-file>.deb
   ```
6. Click on the three bars and "Add a new connection".
7. Click "XML" and then "+ Import XML Configuration". Click "Save".
   !!! note "Important"
   **Don't introduce your password here**. This will be done in the next steps.
8. Now, back in the initial window, you should see "VPN-Nexica". Hit again the three bars and select
"Edit the selected connection".
9.  Here, click on the option "Save login", and then introduce your cluster username and then your password. Click "Save".
10. Now you are ready. Click connect!

## Connecting from the terminal

| Description         | Command                                 |
| ------------------- | --------------------------------------- |
| Connect to VPN      | `forticlient vpn connect VPN-Nexica`    |
| Disconnect from VPN | `forticlient vpn disconnect VPN-Nexica` |
| Check VPN status    | `forticlient vpn status`                |

## References

- Carlos López-Elorduy
