# VSCode in interactive node

## Description

These are the instructions to use Visual Studio Code to run and debug scripts/notebooks
within an **interactive node** from the cluster.

## Using VSCode App

### Step 1: [CLUSTER] Open interactive session

The first step is to allocate the resources you will need for your executions.
We can do this with the `interactive` command.

!!! tip "Tip: Use `screen`"
    Consider launching the interactive session in a screen so that it doesn't get killed when the terminal is closed.

    ```bash
    screen -S vscode
    ```

Launch an interactive session within a given node, allocating some computing resources:

```bash
interactive -c 6 -m 20
```

Then, check on which node you are. You can look at the prompt, or use the `hostname` command.

```bash
hostname
```

Example:

```bash
$ hostname
irbccn43.hpc.irbbarcelona.pcb.ub.es
```

### Step 2: [CLUSTER] Execute job vscode-interactive-job.sh

!!! note "First time setup"
    If it is the first time you are using this method, copy the following lines into a
    file called `vscode-interactive-job.sh` in your home directory.

    **File: `vscode-interactive-job.sh`**

    ```bash
    #!/bin/bash
    #SBATCH --job-name="tunnel"
    #SBATCH --time=8:00:00     # walltime
    
    /usr/sbin/sshd -D -p 2222 -f /dev/null -h ${HOME}/.ssh/id_ecdsa # uses the user key as the host key
    ```

Execute the `vscode-interactive-job.sh` script with:

```bash
bash vscode-interactive-job.sh
```

!!! failure "`id_ecdsa` not found"
    If you get an error saying that the file `id_ecdsa` is not found, you can generate it with the following command:

    ```bash
    ssh-keygen -t ecdsa
    ```

    It will prompt you several times to confirm the generation of the key. You can just press `Enter` to accept the default values.

The terminal will look like it got stuck, but what is happening is that it is waiting for
the SSH tunnel to be established.

### Step 3: [LOCAL] Open SSH tunnel

In your local machine, you need to open the SSH tunnel with the following command:

```bash
ssh -L 2222:<interactive_hostname>:22 <user>@irblogin01.irbbarcelona.pcb.ub.es
```

Example:

```bash
ssh -L 2222:irbccn43.hpc.irbbarcelona.pcb.ub.es:22 clopeze@irblogin01.irbbarcelona.pcb.ub.es
```

### Step 4: [LOCAL] [ONE-TIME-STEP] Add the SSH configuration

Modify the file `~/.ssh/config` in your local machine to include the following configuration:

```bash
Host irbccn*
    HostName %h
    ProxyJump irblogin01.irbbarcelona.pcb.ub.es
    User <user>
    Port 2222
```

Example:

```bash
Host irbccn43
    HostName %h
    ProxyJump irblogin01.irbbarcelona.pcb.ub.es
    User clopeze
    Port 2222
```

!!! warning "Node change"
    This is marked as a "*ONE-TIME-STEP*", but in reality it depends on the node you are allocated.
    If you need to change the node or add a new node, **the configuration will need to be updated**.

!!! tip "Tip (Optional): Helper function to add SSH configuration"
    Here is a helper function that you can add to your `.bashrc` file to make it easier to
    setup the node and the tunnel.

    Steps the function does:

    1. Prompts only for the **host alias**.
    2. Checks if a config entry for that **host already exists** in `~/.ssh/config` (and skips adding it if so).
    3. Uses the fixed configuration values (with HostName as "%h", the fixed ProxyJump, port 2222, and the current computer user).
    4. Computes the full hostname for the tunnel (by appending ".hpc.irbbarcelona.pcb.ub.es" to the alias) and creates the SSH tunnel (running in the background).

    ```bash
    add_cluster_ssh_host_with_tunnel() {
        read -p "Enter host alias (e.g., irbccn43): " host_alias
        current_user=$(whoami)

        # Check if SSH config for this host already exists
        if grep -qE "^Host[[:space:]]+${host_alias}\$" ~/.ssh/config; then
            echo "SSH configuration for host '${host_alias}' already exists. Skipping configuration update."
        else
            new_entry="Host ${host_alias}
        HostName %h
        ProxyJump irblogin01.irbbarcelona.pcb.ub.es
        User ${current_user}
        Port 2222
        "
            echo -e "\n${new_entry}" >> ~/.ssh/config
            echo "SSH configuration added for host '${host_alias}'."
        fi

        # Create the SSH tunnel.
        # Assuming the full hostname is <host_alias>.hpc.irbbarcelona.pcb.ub.es
        computed_hostname="${host_alias}.hpc.irbbarcelona.pcb.ub.es"
        tunnel_cmd="ssh -f -N -L 2222:${computed_hostname}:22 ${current_user}@irblogin01.irbbarcelona.pcb.ub.es"
        echo "Establishing SSH tunnel with command:"
        echo "${tunnel_cmd}"
        eval ${tunnel_cmd}
        if [ $? -eq 0 ]; then
            echo "SSH tunnel established for host '${host_alias}'."
        else
            echo "Failed to establish SSH tunnel."
        fi
    }

    alias addsshcluster='add_cluster_ssh_host_with_tunnel'
    ```

#### Step 4.1: [LOCAL] [ONE-TIME-STEP] Access though the terminal to the node

To make sure the configuration is working, you can access the node through the terminal with the following command:

```bash
ssh irbccn*
```

Example:

```bash
ssh irbccn43
```

This is needed the first time you connect to a new node, so that the node is added to the known hosts.

### Step 5: [VSCODE] Connect VSCode to the interactive node

Open Visual Studio Code and make sure you have installed the `Remote - SSH` extension.

Open the side bar at the "Remote - SSH" panel, and then click the `irbccn*` option. A new window will open with the
terminal connected to the interactive node. All the execution of notebooks and debuggers will be done from this node.

!!! tip "Tip: Create a 'Profile' to keep the VSCode settings and extensions"
    You can create a profile in VSCode to keep the settings and extensions for the connection to the cluster.
    This works similar to the idea of conda environments, but for the VSCode settings.

    To create a profile, click on the gear icon in the bottom left corner of VSCode, and then click on Profiles and create a new profile.

## From Browser (*code-server*)

This approach doesn't use the VSCode app, but instead uses the code-server package to run a VSCode instance in the
cluster. This will result in launching VSCode from the browser.

===+ "Setup 1: Code-Server"

    **Description**

    The macgiver way of mounting the bbgcluster filesystem in our respective local computers is very inefficient when it comes to coding with VSCode, particularly with regards to git version control capabilities.

    But there is a way to use full-fledged capabilities of VSCode for projects that are kept in the bbgcluster.

    **TL;DR**

    * Launch a vscode server in the bbgcluster.
    * SSH tunnel to this session from a local terminal.
    * Connect to the server using a browser.
    * Do so while keeping everything secure.

    **Setting all up**

    For the time being this tutorial does not cover the set up part in depth. However, here there is a bundle of command lines that are needed for setting up the security part.

    **Become a certificate authority**

    ```sh
    # Generate private key
    openssl genrsa -des3 -out myCA.key 2048

    # Generate root certificate
    openssl req -x509 -new -nodes -key myCA.key -sha256 -days 825 -out myCA.pem
    ```

    **Create CA-signed certs**

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

    **VSCode server in the bbgcluster**

    **Screen**

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

    **Interactive**

    Launch an interactive session within a given node, allocating some computing resources:

    ```sh
    interactive -w <bbg-node> -c 6 -m 20
    ```

    **Conda activate *vsc_node* environment**

    ```sh
    conda activate vsc_node
    ```

    !!! warning
        the environment *vsc_node* is supposed to have been already created by the user; check this [reference](cluster_node.md#create-a-conda-environment).

    **Launch vscode server**

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

    **SSH tunnel**

    In a terminal of your local computer, do the following:

    ```sh
    ssh -L 8090:<bbgnode>:8090 \
        -p 22022 \
        <bbg-user>@bbgcluster \
        -t "htop"
    ```

    !!! warning
        *htop* is just a dirty trick to ensure the SSH tunnel does not spontaneouly shut down.

    **Connect to the server**

    Type the following **https** address in the browser:

    ```sh
    https://0.0.0.0:8090/
    ```

    A password prompt will appear. Fullfill the password request with a password you must have generated during the security setup referred to above.

=== "Setup 2: PyNgrok"

    **Requirements**

    -   **Conda** or **Mamba** installed
    -   Have an account on [ngrok](https://ngrok.com)

    **Create a conda environment**

    The conda environment must include the packages `code-server`, `pyngrok` and `screen`

    ```bash
    conda create -n vsc_node -c conda-forge code-server screen pyngrok -y
    conda activate vsc_node
    ```

    **Run code server in a screen (inside `login01`)**

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

    **Run a Ngrok tunnel in a screen (inside `login01`)**

    !!! note

        If this is your first time doing this step, you'll first need to setup your authentication token for ngrok.

        1. Log in to your [ngrok home page](https://ngrok.com).
        2. On the left-hand side bar: `Getting Started > Your Authtoken`
        3. On the `Command Line` section, **copy only the key**, which is the big string with random letters and numbers.
        4. Go back to the terminanl in the cluster (with the `vsc_pyngrok` environment activated) and add your authentication token with the following command:

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

    **Check your VSCode password**

    ```bash
    cat ~/.config/code-server/config.yaml
    ```

    **Browse your VSCode remotely**

    When entering the URL in your browser, click `Visit site` and introduce the password you obtained in the previous step in order to be able to use VSCode.

    ![Screenshot from 2022-11-21 09-06-25](https://user-images.githubusercontent.com/1315429/202997070-fe8d28cb-97f5-4981-bf84-2909056e8fbd.png)

## Reference

- Carlos López-Elorduy
- Federica Brando
- Ferriol Calvet
- Ferran Muiños
- Jordi Deu Pons
