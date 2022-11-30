# VSCode in interactive node

## Description

These are the instructions to use Visual Studio Code to run and debug scripts/notebooks within an **interactive node** from the cluster.

## Requirements

-   **Conda** or **Mamba** installed
-   Have an account on [ngrok](https://ngrok.com)

## Create a conda environment

```bash
interactive
conda create -n vsc_node -c conda-forge code-server screen pyngrok -y
conda activate vsc_node
```

## Run code server in a screen (inside the interactive session)

```bash
screen -S vscode
[vscode screen] conda activate vsc_node
[vscode screen] code-server
```

Exit the screen with `Ctrl + A + D`

## Run a Ngrok tunnel in a screen (inside the interactive session)

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
[pyngrok screen] conda activate vsc_node
[pyngrok screen] pyngrok http 8080
```

Copy the URL to your browser and exit the session `Ctrl + A + D`

## Check your VSCode password

```bash
cat ~/.config/code-server/config.yaml
```

## Browse your VSCode remotely

When entering the URL in your browser, click `Visit site` and introduce the password you obtained in the previous step in order to be able to use VSCode.

![Screenshot from 2022-11-21 09-06-25](https://user-images.githubusercontent.com/1315429/202997070-fe8d28cb-97f5-4981-bf84-2909056e8fbd.png)

## Notes

!!! warning

    With this process, within your interactive session, you will see with `screen -ls` that you have two screens working (`vscode` and `pyngrok`). Because of this, keep in mind that if the interactive session is closed at any point, **the two screens will be killed as well**, crashing any ongoing process.

## Reference

-   Jordi Deu Pons
-   Carlos López Elorduy
-   Federica Brando
