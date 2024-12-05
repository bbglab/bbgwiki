# VPN

When working from home or outside the PCB, connecting to the VPN is neeeded in order to have access to resources such as the cluster.

Since December 2023, the setup for setting up the VPN has changed. Now, it is required to have a Two Factor Authentification using an Authenticator app.



## First Things First - Setting Up

After your meeting with HR, within roughly a week you will receive a letter containing your username, initial PCB services password and a 8-digit code (weak token) to set up your VPN. If you did not receive a letter, contact the Barcelona Science Park’s Information and Telecommunications Systems Department (sic@pcb.ub.es). After you changed your initial password to your preferred password, as explained in the letter, you are ready to set up your two-factor authentification needed for the VPN.

[Two Factor Authentication PDF](https://www.pcb.ub.edu/wp-content/uploads/2023/11/two-factor_authentication.pdf)

Once your two-factor authentification is set up, you are ready to connect to the VPN.



## Connecting on Linux

### Ubuntu 20.04 / 22.04

[Openconnect-Client Setup - pdf](https://www.pcb.ub.edu/wp-content/uploads/Configuracio-VPN-Linux-Ubuntu-catala_EN_RR.pdf)



## Possible Errors

### VPN stuck on Login successful

With Ubuntu 22, if you keep getting stuck on "Login Successful", here is a fix:

In your terminal do:
```sh
sudo add-apt-repository ppa:dwmw2/openconnect
sudo apt update
sudo apt-get install openconnect
```
This should fix the default way to connect to the VPN.



## Full instructions

[VPN tutorial - pdf](https://drive.google.com/file/d/1-YJJEQLtHlNQ6EX1x1cLLRB6zQdLXrn4/view)



## References

- Miguel Grau
- Carlos López-Elorduy
