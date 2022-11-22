# VSCode in interactive node

## Description

These are the instructions to use the VSCode in order to run nd debug scripts/notebooks within an interactive node from the cluster.

## Requirements

- Conda or Mamba
- Ngrok binary installed somewhere at your home folder: <https://ngrok.com/download> (you also need to register and configure your auth token)

## Create a conda environment

```bash
interactive
conda create -n vscode -c conda-forge code-server screen -y
conda activate vscode
```

## Run code server in a screen (inside the interactive session)

```bash
screen -S vscode
[vscode screen] conda activate vscode
[vscode screen] code-server
```

Exit the screen with `Ctrl + A + D`

## Run a Ngrok tunnel in a screen (inside the interactive session)

```bash
screen -S ngrok
[ngrok screen] ngrok http 8080
```

Copy the URL to your browser and exit the session `Ctrl + A + D`

## Check your VSCode password

```bash
cat ~/.config/code-server/config.yaml
```

## Browse your VSCode remotely

When entering the URL in your browser, click `Visit site` and introduce the password you obtained in the previous step in order to be able to use VSCode.

![Screenshot from 2022-11-21 09-06-25](https://user-images.githubusercontent.com/1315429/202997070-fe8d28cb-97f5-4981-bf84-2909056e8fbd.png)

## Reference

- Jordi Deu Pons
- Carlos López Elorduy
- Federica Brando
