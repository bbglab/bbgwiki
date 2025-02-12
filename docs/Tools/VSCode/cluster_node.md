# VSCode in interactive node

## Description

These are the instructions to use Visual Studio Code to run and debug scripts/notebooks within an **interactive node** from the cluster.

## Using VSCode App

### Step 1: [CLUSTER] Open interactive session

The first step is to allocate the resources you will need for your executions. We can do this with the `interactive` command.

> [!NOTE]
> Consider launching the interactive session in a screen so that it doesn't get killed when the terminal is closed.
>
> ```bash
> screen -S vscode
> ```

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

> [!NOTE]
> **First time setup**
>
> If it is the first time you are using this method, copy the following lines into a file called `vscode-interactive-job.sh` in your home directory.
>
> ```bash
> #!/bin/bash
> #SBATCH --job-name="tunnel"
> #SBATCH --time=8:00:00     # walltime
> 
> /usr/sbin/sshd -D -p 2222 -f /dev/null -h ${HOME}/.ssh/id_ecdsa # uses the user key as the host key
> ```

Execute the `vscode-interactive-job.sh` script with:

```bash
bash vscode-interactive-job.sh
```

The terminal will look like it got stuck, but what is happening is that it is waiting for the SSH tunnel to be established.

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

> [!IMPORTANT]
> This is marked as a "*ONE-TIME-STEP*", but in reality it depends on the node you are allocated. If you need to change the node or add a new node, the configuration will need to be updated.

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

Open the side bar at the "Remote - SSH" panel, and then click the `irbccn*` option. A new window will open with the terminal connected to the interactive node. All the execution of notebooks and debuggers will be done from this node.

## Using code-server

### Requirements

-   **Conda** or **Mamba** installed
-   Have an account on [ngrok](https://ngrok.com)

### Create a conda environment

The conda environment must include the packages `code-server`, `pyngrok` and `screen`

```bash
conda create -n vsc_node -c conda-forge code-server screen pyngrok -y
conda activate vsc_node
```

### Run code server in a screen (inside `login01`)

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

### Run a Ngrok tunnel in a screen (inside `login01`)

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

### Check your VSCode password

```bash
cat ~/.config/code-server/config.yaml
```

### Browse your VSCode remotely

When entering the URL in your browser, click `Visit site` and introduce the password you obtained in the previous step in order to be able to use VSCode.

![Screenshot from 2022-11-21 09-06-25](https://user-images.githubusercontent.com/1315429/202997070-fe8d28cb-97f5-4981-bf84-2909056e8fbd.png)

## Reference

-   Carlos López-Elorduy
-   Federica Brando
-   Jordi Deu Pons
