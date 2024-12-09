# VSCode in interactive node

## VSCode App

In cluster (login):
- `srun --pty -c 4 --mem=16G --time=1:00:00 bash`
- `hostname` (to check the node you have been allocated to). Copy it

In local:
- `ssh -L 2222:yourcopiednode:22 youruser@irblogin01.irbbarcelona.pcb.ub.es`

In ssh config:

```txt
Host irbcluster-interactive
    HostName localhost
    Port 2222
    User youruser
    StrictHostKeyChecking no
    UserKnownHostsFile /dev/null
```

After this, in your VSCode, open the "Remote SSH" extension and connect to `irbcluster-interactive`.

## VSCode Server

If you didn't manage to run VSCode from the app, don't worry! There is still another workaround to run VSCode in an interactive node. This method is a bit more complex, but it is still a good alternative to run VSCode in the cluster. It will be like running VSCode in the app, but you will have to access it through a web browser.

### Method 1

#### Description

These are the instructions to use Visual Studio Code to run and debug scripts/notebooks within an **interactive node** from the cluster.

#### Requirements

-   **Conda** or **Mamba** installed
-   Have an account on [ngrok](https://ngrok.com)

#### Create a conda environment

The conda environment must include the packages `code-server`, `pyngrok` and `screen`

```bash
conda create -n vsc_node -c conda-forge code-server screen pyngrok -y
conda activate vsc_node
```

#### Run code server in a screen (inside `login01`)

```bash
screen -S vscode
```

Right after creating the screen, create an interactive session and remember on which node you are allocated.

```bash
interactive
conda activate vsc_node
code-server
```

Exit the screen with `Ctrl + A + D`

#### Run a Ngrok tunnel in a screen (inside `login01`)

!!! note

    If this is your first time doing this step, you'll first need to setup your authentification token for ngrok.

    1. Log in to your [ngrok home page](https://ngrok.com).
    2. On the left-hand side bar: `Getting Started > Your Authtoken`
    3. On the `Command Line` section, **copy only the key**, which is the big string with random letters and numbers.
    4. Go back to the terminanl in the cluster (with the `vsc_pyngrok` environment activated) and add your authentification token with the following command:

        `ngrok authtoken <the_token_you_copied_in_the_previous_step>`

    This setup only has to be done once.

```bash
screen -S pyngrok
```

```bash
interactive -w <bbgnXXX> # Node of previous step
conda activate vsc_node
pyngrok http 8080
```

Copy the URL to your browser and exit the session `Ctrl + A + D`

#### Check your VSCode password

```bash
cat ~/.config/code-server/config.yaml
```

#### Browse your VSCode remotely

When entering the URL in your browser, click `Visit site` and introduce the password you obtained in the previous step in order to be able to use VSCode.

![Screenshot from 2022-11-21 09-06-25](https://user-images.githubusercontent.com/1315429/202997070-fe8d28cb-97f5-4981-bf84-2909056e8fbd.png)


### Method 2

### Description

The MacGyver way of mounting the bbgcluster filesystem in our respective local computers is very inefficient when it comes to coding with VSCode, particularly with regards to git version control capabilities.

But there is a way to use full-fledged capabilities of VSCode for projects that are kept in the bbgcluster.

### TL;DR

* Launch a vscode server in the bbgcluster.
* SSH tunnel to this session from a local terminal.
* Connect to the server using a browser.
* Do so while keeping everything secure.

### Setting all up

For the time being this tutorial does not cover the set up part in depth. However, here there is a bundle of command lines that are needed for setting up the security part.

#### Become a certificate authority

```
# Generate private key
openssl genrsa -des3 -out myCA.key 2048

# Generate root certificate
openssl req -x509 -new -nodes -key myCA.key -sha256 -days 825 -out myCA.pem
```

#### Create CA-signed certs

```sh
NAME=vscode  # Use your own domain name
# Generate a private key
openssl genrsa -out $NAME.key 2048

# Create a certificate-signing request
openssl req -new -key $NAME.key -out $NAME.csr

# Create a config file for the extensions
>$NAME.ext cat <<-EOF
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names
[alt_names]
DNS.1 = $NAME # Be sure to include the domain name here because Common Name is not so commonly honoured by itself
DNS.2 = bar.$NAME # Optionally, add additional domains (I've added a subdomain here)
IP.1 = 0.0.0.0 # Optionally, add an IP address (if the connection which you have planned requires it)
EOF

# Create the signed certificate
openssl x509 -req -in $NAME.csr -CA myCA.pem -CAkey myCA.key -CAcreateserial \
-out $NAME.crt -days 825 -sha256 -extfile $NAME.ext
```

### VSCode server in the bbgcluster

#### Screen

In the bbgcluster, either create
```sh
screen -S vscode
```
or access an existing *vscode* screen
```sh
screen -r vscode
```

!!! warning
    When opening a new screen, this should be done from the `login01` node, since this guarantees that the screen will be **constantly running** and not shut down (which could happen if the screen is opened in one of the other nodes).

#### Interactive

Launch an interactive session within a given node, allocating some computing resources:

```sh
interactive -w <bbg-node> -c 6 -m 20
```

#### Conda activate *vsc_node* environment

```sh
conda activate vsc_node
```

!!! warning
    the environment *vsc_node* is supposed to have been already created by the user; check this [reference](https://bbglab.github.io/bbgwiki/Tools/VSCode/cluster_node/#create-a-conda-environment).

#### Launch vscode server

From your bbgcluster home do:

```sh
unset XDG_RUNTIME_DIR && \
code-server --port 8090 \
            --bind-addr 0.0.0.0 \
            --cert vscode.crt \
            --cert-key vscode.key
```

!!! warning
    *--cert* file **vscode.crt**
    *--cert-key* file **vscode.key**
    are supposed to be already generated by the user.

### SSH tunnel

In a terminal of your local computer, do the following:

```sh
ssh -L 8090:<bbgnode>:8090 \
    -p 22022 \
    <bbg-user>@bbgcluster \
    -t "htop"
```

!!! warning
    *htop* is just a dirty trick to ensure the SSH tunnel does not spontaneouly shut down.

### Connect to the server

Type the following **https** address in the browser:

```
https://0.0.0.0:8090/
```

A password prompt will appear. Fullfill the password request with a password you must have generated during the security setup referred to above.


## Reference

-   Jordi Deu Pons
-   Carlos López-Elorduy
-   Federica Brando
-   Ferriol Calvet
-   Ferran Muinos
